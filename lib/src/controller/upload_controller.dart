import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as imageLib;
import 'package:instaclone/src/components/message_popup.dart';
import 'package:instaclone/src/controller/auth_controller.dart';
import 'package:instaclone/src/models/post.dart';
import 'package:instaclone/src/pages/upload/upload_description.dart';
import 'package:instaclone/src/repository/post_repository.dart';
import 'package:instaclone/src/utils/data_util.dart';
import 'package:path/path.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:photofilters/widgets/photo_filter.dart';

class UploadController extends GetxController {
  RxList<AssetEntity> imageList =
      <AssetEntity>[].obs; // AssetEntity는 사진이나 비디오를 나타내는 클래스
  var albums = <AssetPathEntity>[]; // AssetPathEntity는 앨범을 나타내는 클래스
  RxString headerTitle = ''.obs;
  TextEditingController textEditingController = TextEditingController();

  Rx<AssetEntity> selectedImage = AssetEntity(
    id: '0',
    typeInt: 0,
    width: 0,
    height: 0,
  ).obs;
  File? filterdImage;
  Post? post;

  @override
  void onInit() async {
    super.onInit();
    post =
        Post.init(AuthController.to.user.value); // 각자의 계정마다 다른 user값을 가지고 있다.

    await _loadPhotos();
    print("UploadController onInit");
  }

  Future<void> _loadPhotos() async {
    // selectedImage를 초기화하는 로직을 추가해야할듯?
    // Get.find<UploadController>().fetchPhotos();
    var result = await PhotoManager
        .requestPermissionExtend(); // await문법이 아니라 then문법도 사용가능
    if (result.isAuth) {
      albums = (await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          imageOption: FilterOption(
            sizeConstraint: SizeConstraint(minHeight: 100, minWidth: 100),
          ),
          orders: [
            const OrderOption(
              asc: false,
              type: OrderOptionType.createDate,
            )
          ],
        ),
      ));
      await _loadData();
    } else {
      print("권한이 없습니다.");
      print("RESULT${result}");
    }
  }

  Future<void> _loadData() async {
    changeAlbum(albums.first);
  }

  Future<void> _pagingPhotos(AssetPathEntity album) async {
    imageList.clear();
    var photos = await album.getAssetListPaged(
        page: 0, size: 28); // 앨범에서 30개씩 가져오기 -> 28개로 수정
    imageList.addAll(photos);
    // selectedImage = imageList.first;
    changeSeletedImage(imageList.first);
  }

  changeSeletedImage(AssetEntity image) {
    selectedImage(image);
  }

  changeAlbum(AssetPathEntity album) async {
    headerTitle(album.name);
    await _pagingPhotos(album);
    // Get.back();
  }

  void gotoImageFilter() async {
    var file = await selectedImage.value.file;
    var fileName = basename(file!.path);
    var image = imageLib.decodeImage(file.readAsBytesSync());
    image = imageLib.copyResize(image!, width: 600);
    var imagefile = await Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: const Text("Photo Filter Example"),
          image: image!,
          filters: presetFiltersList,
          filename: fileName,
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      filterdImage = imagefile['image_filtered'];
      Get.to(() => const UploadDescription());
    }
  }

  void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void uploadPost() {
    unfocusKeyboard();
    print(textEditingController.text);
    String filename = DataUtil.makeFilePath(); // 랜덤한 파일명(UUID)를 생성
    var task = uploadXfile(
        filterdImage!, '/${AuthController.to.user.value.uid}/$filename');
    if (task != null) {
      task.snapshotEvents.listen(
        (event) async {
          if (event.bytesTransferred == event.totalBytes &&
              event.state == TaskState.success) {
            var downloadUrl = await event.ref.getDownloadURL();
            var updatedPost = post!.copyWith(
                thumbnail: downloadUrl,
                description: textEditingController.text);
          _submitPost(updatedPost);
          }
        },
      );
    }
  }

  UploadTask uploadXfile(File file, String filename) {
    var ref = FirebaseStorage.instance.ref().child('instagram').child(filename);
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );
    return ref.putFile(file, metadata);
    //users/{uid}/prifile.(jpg, png)
  }

  void _submitPost(Post postData) async {
    await PostRepository.updatePost(postData);
    showDialog(
      context: Get.context!,
      builder: (context) => MessagePopUp(
        title: '포스트',
        message: '포스팅이 완료되었습니다.',
        okCallback: () {
          Get.until((route) => Get.currentRoute == '/');
        },
      ),
    );
  }
}
