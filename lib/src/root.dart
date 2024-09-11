import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/src/app.dart';
import 'package:instaclone/src/pages/login.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext _, AsyncSnapshot<User?> user) {
          if (user.hasData) {
            print('user: ${user.data}');
            return App();
          } else {
            print('no user');
            return Login();
            // return Container(
            //   width: 100,
            //   height: 100,
            //   color: Colors.amber,
            // );
          }
        });
  }
}
