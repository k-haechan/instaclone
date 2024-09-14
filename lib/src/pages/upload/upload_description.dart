import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/src/components/image_data.dart';
import 'package:instaclone/src/controller/upload_controller.dart';

class UploadDescription extends GetView<UploadController> {
  const UploadDescription({super.key});

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Image.file(
              controller.filterdImage!,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller.textEditingController,
              maxLines: null, // 여러줄 입력 가능
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: '문구 입력...',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 매번 같은 위젯을 반환하는 경우 Getter 방식이 좋다.
  Widget get line => const Divider(color: Colors.grey,);
  // Widget line() => const Divider(color: Color(0xFFE9E9E9),);

  Widget snsInfo() {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 15), child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text('facebook', style: TextStyle(fontSize: 17),),
        Switch(value: false, onChanged: (bool value) {},),
      ],),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text('Twitter', style: TextStyle(fontSize: 17),),
        Switch(value: false, onChanged: (bool value) {},),
      ],),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text('Tumblr', style: TextStyle(fontSize: 17),),
        Switch(value: false, onChanged: (bool value) {},),
      ],),
    ],));
  }

  Widget infoOnt(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(
              IconsPath.backBtnIcon,
              width: 50,
            ),
          ),
        ),
        title: const Text(
          '새 게시물',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          GestureDetector(
            onTap: controller.uploadPost,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: ImageData(
                IconsPath.uploadComplete,
                width: 50,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [Positioned( // 이거 바디를 전체로 바꾸는 트릭. 제대로 된 방법 찾아보기
          left: 0,
          right: 0,
          bottom: 0,
          top: 0,
          child: GestureDetector(
            onTap: controller.unfocusKeyboard,
            // () {
            //   // FocusScope.of(context).unfocus();
            //   FocusManager.instance.primaryFocus?.unfocus();
            // },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _description(),
                  line,
                  infoOnt('사람태그하기'),
                  line,
                  infoOnt('위치 추가하기'),
                  line,
                  infoOnt('다른 미디어에도 게시'),
                  snsInfo(),
                  ],

              ),
            ),
          ),
        ),]
      ),
    );
  }
}
