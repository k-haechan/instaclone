// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:instaclone/src/pages/upload.dart';

// enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

// class BottomNavController extends GetxController {
//   RxInt pageIndex = 0.obs; // 얘에 UI가 종속적임
//   List<int> bottomHistory = [0]; // 히스토리 그 자체 얘가 제일 중요하다.
//   // UI는 view로직에 구현되어 있다. PageIndex의 값에 따라서 body가 바뀐다.

//   void changeBottomNav(int index) { // 접속포인트
//     if (PageName.values[index] == PageName.UPLOAD) {
//       Get.to(() => const Upload()); // 어차피 이렇게 페이지 이동으로 할거면 다른 버튼이랑 동일하게 해도 되지만 아직까진 지켜보자~
//       return;
//     }
//     pageIndex(index);
//     bottomHistory.add(index);
//     print(bottomHistory);
//   }

//   onPopAction() {
//     if (bottomHistory.length == 1) {
//       print('종료');
//       SystemNavigator.pop();
//     } else {
//       print('뒤로가기');
//       bottomHistory.removeLast();
//       pageIndex.value = bottomHistory.last;
//       print(bottomHistory);
//     }
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/src/components/message_popup.dart';
import 'package:instaclone/src/pages/upload.dart';

enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.UPLOAD:
        // _chagePage(value);
        Get.to(() => const Upload());
        break;
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _chagePage(value, hasGesture: hasGesture);
        break;
    }
    // pageIndex(value); // 특이한 문법.. 생성자처럼 수정한다.
  }

  void _chagePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture || bottomHistory.last == value) return;
    bottomHistory.add(value);
  }

  onPopAction() {
    print(bottomHistory);

    if (bottomHistory.length == 1) {
      print('종료');
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopUp(
                title: 'system',
                message: 'quit?',
                okCallback: () {
                  exit(0);
                },
                cancelCallback: Get.back, // ?
              ));
      // SystemNavigator.pop();
      // return true;
    } else {
      print('뒤로가기');
      bottomHistory.removeLast();
      

      changeBottomNav(bottomHistory.last, hasGesture: false);
      // return false;
    }
  }
}
