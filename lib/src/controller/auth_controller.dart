import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaclone/src/binding/init_bindings.dart';
import 'package:instaclone/src/models/instagram_user.dart';
import 'package:instaclone/src/repository/user_repository.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find(); // GetX의 컨트롤러를 사용할 때 사용하는 방법. to라는 getter를 통해 사용

  Rx<IUser> user = IUser().obs;

  Future<IUser? > loginUser(String uid) async{
    var userData = await UserRepository.loginUserByUid(uid);
    if(userData != null){
      user(userData);
      InitBinding.addtionalBinding(); // 로그인이 되면 추가적인 controller바인딩을 해줌 (로그인 이전에 필요없는 컨트롤러는 바인딩을 하지 않아서 생명주기를 효율적으로 조절함.)
    }
    return userData;
  }

  void signUp(IUser signupUser, XFile? thumbnail) async{ // 유저 정보와 썸네일을 받아서 DB에 저장. (여기서 드는 의문점. 썸네일을 받는 순간 user정보에 저장해도 될 것 같은데? 어차피 IUser에 썸네일이 있으니까)
    if(thumbnail == null) {
      _submitSignup(signupUser);
    } else {
      print("test1");
      var task = uploadXfile(thumbnail, '${signupUser.uid}/profile.${thumbnail.path.split('.').last}'); // 파일 업로드 task
      task.snapshotEvents.listen((event) async{ // 업로드의 성공, 진행, 실패 등의 이벤트를 받아옴
        print(event.bytesTransferred);
        if(event.bytesTransferred == event.totalBytes && event.state == TaskState.success) { // 네트워크 과정에서 업로드가 누락되지 않고 완료되면
        print("test2");

          var downloadUrl = await event.ref.getDownloadURL(); // 업로드된 파일의 URL(cdn)을 가져옴
          var updatedUserData = signupUser.copyWith(thumbnail: downloadUrl); // signupUser을 immutable하게 유지시켜주는 방법.(final로 선언하고 _private로 변경해줘도 좋을듯?)
          _submitSignup(updatedUserData); // 업로드된 파일의 URL을 가진 유저 정보를 DB에 저장
        }
        print("test3");

      });
    }
  }

  UploadTask uploadXfile(XFile xfile, String filename){
    var file = File(xfile.path);
    var ref = FirebaseStorage.instance.ref().child('users').child(filename);
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': xfile.path},
    );
    return ref.putFile(file, metadata);
    //users/{uid}/prifile.(jpg, png)
  }

  void _submitSignup(IUser signupUser) async{
    var result = await UserRepository.signUp(signupUser);
    if(result){
      loginUser(signupUser.uid!);
    }
  }
}