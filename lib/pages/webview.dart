import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebView extends StatefulWidget {
  final String postUrl;

  ArticleWebView({this.postUrl});

  @override
  _ArticleWebViewState createState() => _ArticleWebViewState();
}

class _ArticleWebViewState extends State<ArticleWebView> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.blueAccent,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Daily News',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              color: Colors.blueAccent.shade100,
              fontSize: 23,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(5),
          child: loading ? LinearProgressIndicator() : Container(),
        ),
      ),
      body: WebView(
        debuggingEnabled: true,
        initialUrl: widget.postUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (finish) {
          setState(() {
            loading = false;
          });
        },
      ),
    );
  }
}
