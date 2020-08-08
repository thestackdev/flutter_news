import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/services/bindings.dart';
import 'package:flutter_news/services/pages.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: TextTheme(
    headline6: TextStyle(
      color: Colors.white,
      fontSize: 23,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    ),
    headline5: GoogleFonts.aBeeZee(
      textStyle: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    brightness: Brightness.light,
    centerTitle: true,
    textTheme: TextTheme(
      headline6: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    ),
  ),
);

main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: false,
      initialBinding: MyBindings(),
      getPages: Pages.pages,
      initialRoute: 'home',
      theme: theme,
    ),
  );
}
