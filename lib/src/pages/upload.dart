import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/src/components/image_data.dart';
import 'package:instaclone/src/controller/upload_controller.dart';
import 'package:photo_manager/photo_manager.dart';

class Upload extends GetView<UploadController> {
  // stateless + GetX로도 할 수 있음. 여기선 GetX에 대한 의존성을 줄이기 위해 stateful로 작성
  Upload({super.key});

  Widget _imagePreview() {
    var width = Get.width; // 화면의 전체 너비
    return Obx(
      () => Container(
        width: width,
        height: width,
        color: Colors.grey[400],
        child: _photo(controller.selectedImage.value, width.toInt(),
            builder: (data) {
          return Image.memory(
            data,
            fit: BoxFit.cover,
          );
        }),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: Get.context!,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  isScrollControlled:
                      controller.albums.length > 10 ? true : false,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(Get.context!).size.height -
                        MediaQuery.of(Get.context!).padding.top,
                  ),
                  builder: (_) => 
                     Container(
                      // height: 200,
                      height: controller.albums.length > 10
                          ? Size.infinite.height
                          : controller.albums.length * 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 7),
                              width: 40,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: List.generate(
                                  controller.albums.length,
                                  (idx) => GestureDetector(
                                    onTap:(){
                                      controller.changeAlbum(controller.albums[idx]);
                                      Get.back();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 20),
                                      child: Text(controller.albums[idx].name), //recent, like, ...
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                );
              },
              child: Row(
                children: [
                  Obx(
                    () => Text(
                      controller.headerTitle.value,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: Color(0xff808080),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    ImageData(IconsPath.imageSelectIcon),
                    const SizedBox(width: 5),
                    Text(
                      '여러 항목 선택',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xff808080),
                ),
                child: ImageData(IconsPath.cameraIcon),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _photo(
      // 사진을 불러오는 함수
      AssetEntity? entity,
      int size, // AssetEntity는 PhotoManager에서 제공하는 클래스
      {required Widget Function(Uint8List) builder}) {
    if (controller.imageList.isEmpty) {
      // 사진이 로드가 되어있지 않으면
      return Container(); // 빈 컨테이너를 반환
    }
    var thumbnail = entity!.thumbnailDataWithSize(ThumbnailSize(size, size));
    return FutureBuilder(
        future: thumbnail,
        builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return builder(snapshot.data!);
          // builder 패턴으로 UI관련 Builder는 클라이언트에게 위임
          // builder 패턴을 더 잘게 쪼개서 중복된 부분을 이 위젯에 위임하고 클라리언트는 flag로 구분해서 사용해도 될듯?
          // 물론 flag는 확장에는 좋지 않지만. 중복을 제외하므로 코드가 간결해지고 가독성이 좋아짐(여기선 우선 2가지 경우만 존재함)
          // return Opacity(
          //   opacity: entity == selectedImage ? 0.5 : 1,
          //   child: Image.memory(
          //     snapshot.data!,
          //     fit: BoxFit.cover,
          //   ),
          // );
        });
  }

  Widget _imageSelectList() {
    // 이미지 미리보기
    return Obx(()=> GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 4개의 열
          childAspectRatio: 1, // 가로 세로 비율
          mainAxisSpacing: 1, // 메인축 방향의 간격
          crossAxisSpacing: 1, // 가로 간격
        ),
        itemCount: controller.imageList.length,
        itemBuilder: (BuildContext context, int index) {
          return _photo(controller.imageList[index], 200, builder: (data) {
            // 심지어 data는 _photo위젯에 종속적임. 별로 좋은 패턴은 아닌것같은디
            return GestureDetector(
              onTap: () {
                controller.changeSeletedImage(controller.imageList[index]);
              },
              child: Obx(()=>Opacity(
                  opacity: controller.imageList[index] ==
                          controller.selectedImage.value
                      ? 0.3
                      : 1,
                  child: Image.memory(
                    data,
                    fit: BoxFit.cover,
                  ),
                ),
            ));
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(IconsPath.closeImage),
          ),
        ),
        title: const Text('New Post',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        actions: [
          GestureDetector(
            onTap: controller.gotoImageFilter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.nextImage,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagePreview(), // 이미지 미리보기
            _header(), // 헤더..? 이미지 폴더 명 + 여러 항목 선택, 카메라 아이콘
            _imageSelectList(), // 이미지 선택 리스트
          ],
        ),
      ),
    );
  }
}
