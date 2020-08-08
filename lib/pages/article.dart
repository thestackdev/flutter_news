import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/pages/webview.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class Article extends StatelessWidget {
  final title, imageToUrl, postUrl, content, description;

  const Article(
      {Key key,
      this.title,
      this.imageToUrl,
      this.postUrl,
      this.content,
      this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.zero,
                  centerTitle: false,
                  title: Container(
                    padding: EdgeInsets.all(9),
                    child: Text(
                      title,
                      style: GoogleFonts.firaSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  background: imageToUrl != null
                      ? Hero(
                          tag: imageToUrl,
                          child: CachedNetworkImage(
                            imageUrl: imageToUrl,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          'assets/img_placeholder.jpg',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    padding: EdgeInsets.all(9),
                    child: Text(
                      description ?? 'Description Not Found !',
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(9),
                    child: Text(
                      content ?? 'Content Not Found !',
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                Get.to(
                  ArticleWebView(
                    postUrl: postUrl,
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade100,
                ),
                child: Text(
                  'Read Complete Aricle',
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
