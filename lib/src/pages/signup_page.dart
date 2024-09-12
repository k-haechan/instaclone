import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaclone/src/controller/auth_controller.dart';
import 'package:instaclone/src/models/instagram_user.dart';

class SignupPage extends StatefulWidget {
  final String uid;
  const SignupPage({super.key, required this.uid});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? thumbnailXFile;

  void update() => setState(() {}); // re-build(re-rendering)

  Widget _avatar() {
    return Column(
      children: [
        ClipRRect(
          // 모서리를 둥글게 자르는 위젯
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            width: 100,
            height: 100,
            child: thumbnailXFile != null
                ? Image.file(File(thumbnailXFile!.path), fit: BoxFit.cover)
                : Image.asset('assets/images/default_image.png',
                    fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            thumbnailXFile = await _picker.pickImage(
                source: ImageSource.gallery, imageQuality: 10);
            update();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            '이미지변경',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _nickname() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        controller: _nicknameController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: '닉네임',
        ),
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        controller: _descriptionController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: '설명',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '회원가입',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // 디바이스 크기가 작은 경우를 고려하여
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            _avatar(),
            const SizedBox(height: 60),
            _nickname(),
            const SizedBox(height: 30),
            _description(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        child: ElevatedButton(
          onPressed: () {
            // validation check도 해주어야 함
            var signupUser = IUser(
              // 매우 간단한 버전. create_data, update_data 등을 사용하여 더 많은 정보를 저장할 수 있음
              uid: widget.uid,
              nickname: _nicknameController.text,
              description: _descriptionController.text,
            );
            AuthController.to.signUp(signupUser, thumbnailXFile);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Colors.blue,
            // minimumSize: Size(double.infinity, 50),
          ),
          child: const Text(
            '회원가입',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
