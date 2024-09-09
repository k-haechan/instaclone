import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/src/pages/home.dart';
import 'package:instaclone/src/pages/search/search.dart';

import 'components/image_data.dart';
import 'controller/bottom_nav_controller.dart';

class App extends GetView<BottomNavController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult:(bool didPop, Object? result) { 
        if(didPop){
          return; 
        }
        controller.willPopAction();
      },
      child: Obx(
        () => Scaffold(
          // appBar: AppBar(),
          body: IndexedStack(
            index: controller.pageIndex.value, // 페이지 번호에 따라서 body가 바뀜.
            children: [
              // Container(child: Center(child:Text("HOME"),),),
              Home(),
              Navigator(
                key: controller.searchPageNavigationKey,
                onGenerateRoute: (routeSetting){
                  return MaterialPageRoute(builder: (context)=>const Search());
                },
              ),
              Container(child: Center(child:Text("UPLOAD"),),),
              Container(child: Center(child:Text("ACTIVITY"),),),
              Container(child: Center(child:Text("MYPAGE"),),),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: controller.pageIndex.value,
              elevation: 0,
              onTap: controller.changeBottomNav,
              items: [
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.homeOff),
                  activeIcon: ImageData(IconsPath.homeOn),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                    icon: ImageData(IconsPath.searchOff),
                    activeIcon: ImageData(IconsPath.searchOn),
                    label: 'search'),
                BottomNavigationBarItem(
                    icon: ImageData(IconsPath.uploadIcon), label: 'upload'),
                BottomNavigationBarItem(
                    icon: ImageData(IconsPath.activeOff),
                    activeIcon: ImageData(IconsPath.activeOn),
                    label: 'active'),
                const BottomNavigationBarItem(
                    icon: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.grey,
                      // backgroundImage: ImageData(IconsPath.activeOff).image,
                    ),
                    label: 'profile'),
              ]),
        ),
      ),
      // onPopInvokedWithResult: () async {return false;}, 이거는 Get.back으로 구현
    );
  }
}
