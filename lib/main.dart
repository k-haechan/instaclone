import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/src/app.dart';

import 'src/binding/init_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black),
        ),
        useMaterial3: true,
      ),
      initialBinding: InitBinding(), // 초기 바인딩 등록 (빈 객체 생성과 유사)
      home: const App(),
    );
  }
}