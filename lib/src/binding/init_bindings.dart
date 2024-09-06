import 'package:get/get.dart';

import '../controller/bottom_nav_controller.dart';

class InitBinding extends Bindings{
  @override
  void dependencies() {
    // Get.lazyPut(() => BottomNavController());
    Get.put(BottomNavController(), permanent: true);
  }
}