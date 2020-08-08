import 'package:flutter/material.dart';

class Utils {
  Widget error() {
    return Scaffold(
      body: Center(
        child: Text('Oops... Something went wrong !'),
      ),
    );
  }

  Widget empty() {
    return Scaffold(
      body: Center(
        child: Text('Oops... No Articles Found !'),
      ),
    );
  }
}
