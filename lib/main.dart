import 'package:flutter/material.dart';
import 'screens/splash.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runApp(
    OKToast(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    ),
  );
}
