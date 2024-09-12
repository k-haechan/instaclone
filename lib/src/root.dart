import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/src/app.dart';
import 'package:instaclone/src/controller/auth_controller.dart';
import 'package:instaclone/src/models/instagram_user.dart';
import 'package:instaclone/src/pages/login.dart';
import 'package:instaclone/src/pages/signup_page.dart';

class Root extends GetView<AuthController> { // GetView는 기본적으로 stateless 위젯이다.
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext _, AsyncSnapshot<User?> user) {
          if (user.hasData) { // 스냅샷을 보고 build의 결과값을 본다.
            //
            var storedUser = controller.loginUser(user.data!.uid);
            return FutureBuilder<IUser?>(future: storedUser, builder: (context, snapshot){
              if(snapshot.hasData){ // storedUser가 존재하면
                return const App();
              } else {
                return Obx(()=> controller.user.value.uid!=null? const App() : SignupPage(uid: user.data!.uid));
              }
            });
          } else {
            print('no user');
            return const Login();
          }
        });
  }
}
