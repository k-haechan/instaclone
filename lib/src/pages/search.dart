import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/src/pages/search/search_focus.dart';
import 'package:quiver/iterables.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<List<int>> groupBox = [[], [], []];
  List<int> groupIdx = [0, 0, 0];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 100; i++) {
      var gi = groupIdx.indexOf(min<int>(groupIdx)!);
      // var x=i % 3 == 1 ? 2 : 1;
      // var gi = i%3;
      // var size = 1;
      // if(gi != 1) size = 2;
      // groupBox[gi].add(size);
      // print(x);
      var size = gi != 1 ? (Random().nextInt(100) % 4 == 0 ? 2 : 1) : 1;
      groupBox[gi].add(size);
      groupIdx[gi] += size;
    }
  }

  Widget _appbar() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Get.to(SearchFocus()); // Get.to로 이동하면서 이전 페이지를 기억하지 않음.
              Navigator.push(context, // 중복라우팅 관리. 여기는 Navigator.push로 라우팅을 따로 관리함.
                  MaterialPageRoute(builder: (context) => const SearchFocus()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              margin: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xFFEFEFEF)),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.black),
                  Text('검색', style: TextStyle(color: Color(0xFF838383))),
                ],
              ),
            ),
          ),
        ),
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: const Icon(Icons.location_pin)),
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          groupBox.length,
          (r) => Expanded(
            child: Column(
              children: List.generate(
                  groupBox[r].length,
                  (c) => Container(
                        height: Get.width * 0.33 * groupBox[r][c],
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: Colors.primaries[Random().nextInt(Colors
                                .primaries
                                .length)]), // Colors.primaries에 속하는 값들 중 랜덤으로 추출
                      )),
            ),
          ),
        ).toList(), // toList는 필요없지않나?
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // 상태표시바까지 침범하지 않도록 해줌.
        child: Column(
          children: [
            _appbar(), // 위로 슬라이드 했을 때 사라지는 appBar 수동 구현. 관련 위젯은 있을거임 여기에선 그냥 공부용으로 구현.
            Expanded(child: _body())
          ],
        ),
      ),
    );
  }
}
