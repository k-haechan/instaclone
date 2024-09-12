import 'package:get/get.dart';
import 'package:instaclone/src/controller/auth_controller.dart';

import '../controller/bottom_nav_controller.dart';

class InitBinding extends Bindings{
  @override
  void dependencies() {
    // Get.lazyPut(() => BottomNavController());
    // GetX의 컨트롤러들을 프로그램 시작할 때 생성하고 사용할 수 있도록. Spring의 @Component(Bean)와 비슷한 역할
    Get.put(BottomNavController(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }
}