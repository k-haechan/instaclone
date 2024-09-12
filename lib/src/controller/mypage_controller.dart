import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/src/controller/auth_controller.dart';
import 'package:instaclone/src/models/instagram_user.dart';

class MypageController extends GetxController with GetTickerProviderStateMixin{
  late TabController tabController;
  Rx<IUser> targetUser = IUser().obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  void setTargetUser() {
    var uid = Get.parameters['targetUid'];
    if(uid==null){ // 내 페이지면
      targetUser(AuthController.to.user.value);
    } else { // 다른 사람 페이지면
      // 다른 사람 정보 로드
      

    }
  }

  void _loadData() {
    setTargetUser();
    // 포스트 리스트 로드
    // 사용자 정보 로드

  }
}