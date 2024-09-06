import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageData extends StatelessWidget {
  final String icon;
  final double? width;
  const ImageData(this.icon, {super.key, this.width=55,});

  @override
  Widget build(BuildContext context) {
    return Image.asset(icon, width: width! / Get.mediaQuery.devicePixelRatio); //  MediaQuery.of(context).devicePixelRatio 플러터 방식
  }
}

class IconsPath{
  static String get homeOff => 'assets/images/bottom_nav_home_off_icon.jpg'; // 리팩토링 1. svg파일로 변경(이미지 색상을 내부적으로 설정할 수 있음)
  static String get homeOn => 'assets/images/bottom_nav_home_on_icon.jpg';
  static String get searchOff => 'assets/images/bottom_nav_search_off_icon.jpg';
  static String get searchOn => 'assets/images/bottom_nav_search_on_icon.jpg';
  static String get uploadIcon => 'assets/images/bottom_nav_upload_icon.jpg';
  static String get activeOff => 'assets/images/bottom_nav_active_off_icon.jpg';
  static String get activeOn => 'assets/images/bottom_nav_active_on_icon.jpg';
}