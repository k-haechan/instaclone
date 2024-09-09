import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/src/components/image_data.dart';
import 'package:instaclone/src/controller/bottom_nav_controller.dart';

class SearchFocus extends StatefulWidget {
  const SearchFocus({super.key});

  @override
  State<SearchFocus> createState() => _SearchFocusState();
}

class _SearchFocusState extends State<SearchFocus>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  Widget _tabMenuOne(String menu) {
    return Container(
      // color: Colors.red,
      child: Text(
        menu,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  PreferredSizeWidget _tabMenu() {
    return PreferredSize(
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      child: Container(
        height: AppBar().preferredSize.height,
        width: Get.width, // Size.infinite.width
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Color(0xffe4e4e4)),
          ),
        ),
        child: TabBar(
            // tabAlignment: TabAlignment.fill,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.black,
            controller: tabController,
            tabs: [
              _tabMenuOne('인기'),
              _tabMenuOne('계정'),
              _tabMenuOne('오디오'),
              _tabMenuOne('태그'),
              _tabMenuOne('장소'),
            ]),
      ),
    );
  }

  Widget _body() {
    return TabBarView(
      controller: tabController,
      children: const [
        Center(child: Text('인기페이지')),
        Center(child: Text('계정페이지')),
        Center(child: Text('오디오페이지')),
        Center(child: Text('태그페이지')),
        Center(child: Text('장소페이지')),
      ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: BottomNavController.to.willPopAction,//Get.find<BottomNavController>().willPopAction(),//Get.back,
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData((IconsPath.backBtnIcon))),
        ),
        titleSpacing: 0.0,
        title: Container(
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            color: const Color(0xFFEFEFEF),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '검색',
              // contentPadding: EdgeInsets.only(left: 4, top:7, bottom: 7), // TextField의 내부 패딩값을 조정하려면 contentPadding을 사용
              contentPadding: EdgeInsets.fromLTRB(4, 7, 0, 7),
              // isCollapsed: true, // 패딩값, 마진값 0으로 설정(찌부)
              isDense:
                  true, // contentPadding값 만큼 영역이 생긴다. (최소 영역, 설정하지 않으면 디폴트 값이 적용됨)
            ),
          ),
        ),
        bottom: _tabMenu(),
      ),
      body: _body(),
    );
  }
}
