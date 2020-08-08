import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_news/pages/article.dart';
import 'package:flutter_news/services/controllers.dart';
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatelessWidget {
  final controllers = Controllers.find;
  final GlobalKey<PaginatorState> globalKey = GlobalKey<PaginatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        title: Text('News Today'),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              backgroundColor: Colors.blueAccent.shade100,
              floating: true,
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                background: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: controllers.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => {
                        if (controllers.selectedategory.value !=
                            controllers.list[index]['title'].toLowerCase())
                          {
                            controllers.changeCategory(
                                controllers.list[index]['title'].toLowerCase()),
                            globalKey.currentState.changeState(
                              pageLoadFuture: pageLoadFuture,
                              resetState: true,
                            ),
                          }
                      },
                      child: Container(
                        margin: EdgeInsets.all(9),
                        padding: EdgeInsets.all(9),
                        child: Column(
                          children: [
                            CircleAvatar(
                              minRadius: 30,
                              maxRadius: 30,
                              backgroundImage:
                                  AssetImage(controllers.list[index]['image']),
                            ),
                            SizedBox(height: 3),
                            Obx(
                              () => Text(
                                controllers.list[index]['title'],
                                style: GoogleFonts.aBeeZee(
                                  textStyle: TextStyle(
                                    color: controllers.selectedategory.value ==
                                            controllers.list[index]['title']
                                                .toLowerCase()
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.5),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Latest News',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Top Stories at the moment',
                      style: Theme.of(context).textTheme.headline5.apply(
                            color: Colors.grey.shade500,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Paginator.listView(
          scrollPhysics: NeverScrollableScrollPhysics(),
          key: globalKey,
          pageLoadFuture: pageLoadFuture,
          pageItemsGetter: pageItemsGetter,
          listItemBuilder: listItemBuilder,
          loadingWidgetBuilder: loadingWigetBuilder,
          errorWidgetBuilder: errorWidgetBuilder,
          emptyListWidgetBuilder: emptyListWidgetBuilder,
          totalItemsGetter: totalItemsGetter,
          pageErrorChecker: pageErrorChecker,
        ),
      ),
    );
  }

  Future pageLoadFuture(int page) async {
    return await controllers.dio
        .get('https://newsapi.org/v2/top-headlines?', queryParameters: {
      'country': 'in',
      'page': page,
      'pageSize': 18,
      'category': controllers.selectedategory.value,
      'apiKey': '6030a2d1ab034692b855d6d1572d2495',
    });
  }

  List pageItemsGetter(pageData) {
    return pageData.data['articles'];
  }

  Widget listItemBuilder(pageData, index) {
    return GestureDetector(
      onTap: () => Get.to(Article(
        title: pageData['title'],
        imageToUrl: pageData['urlToImage'],
        postUrl: pageData['url'],
        content: pageData['content'],
        description: pageData['description'],
      )),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        margin: EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  pageData['title'],
                  style: GoogleFonts.varela(
                    textStyle: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 1.5,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              if (pageData['urlToImage'] != null) ...[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Hero(
                        tag: pageData['urlToImage'],
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          imageUrl: pageData['urlToImage'],
                        ),
                      ),
                    ),
                  ),
                )
              ] else ...[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.asset(
                        'assets/img_placeholder.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget loadingWigetBuilder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Column(
        children: List.generate(3, (index) {
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            margin: EdgeInsets.all(9),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(height: 18),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.black,
                      height: 50,
                      width: 50,
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget errorWidgetBuilder(pageData, retryCallBack()) {
    return controllers.utils.error();
  }

  Function retryCallBack() {
    return null;
  }

  Widget emptyListWidgetBuilder(pageData) {
    return controllers.utils.empty();
  }

  int totalItemsGetter(pageData) {
    return pageData.data['totalResults'];
  }

  bool pageErrorChecker(pageData) {
    return pageData.data['status'] != 'ok';
  }
}
