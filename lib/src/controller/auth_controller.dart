import 'package:get/get.dart';
import 'package:instaclone/src/models/instagram_user.dart';
import 'package:instaclone/src/repository/user_repository.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find(); // GetX의 컨트롤러를 사용할 때 사용하는 방법. to라는 getter를 통해 사용

  Rx<IUser> user = IUser().obs;

  Future<IUser? > loginUser(String uid) async{
    var userData = await UserRepository.loginUserByUid(uid);
    print(userData);
    return userData;
  }

  void signUp(IUser signupUser) async{
    var result = await UserRepository.signUp(signupUser);
    if(result){
      user(signupUser);
    }
  }
}