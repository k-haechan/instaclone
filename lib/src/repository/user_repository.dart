import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaclone/src/models/instagram_user.dart';

class UserRepository {

  static Future<IUser?> loginUserByUid(String uid) async {
    print('uid: $uid');
    //DB 조회
    // FirebaseFirestore.instance.collection('users').doc(uid).get(); // 문서의 id값이 uid인 문서를 가져옴 
    var data = await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: uid).get(); // 문서중 uid 필드의 값이 uid인 문서를 가져옴'

    if(data.size == 0){ // 저장되어 있는 값이 없으면
      return null;  
    }
    return IUser.fromJson(data.docs.first.data());
  }

  static Future<bool> signUp(IUser user) async {
    try{
      await FirebaseFirestore.instance.collection('users').add(user.toMap());
      return true;
    } catch(e){
      print('error: $e');// 로그처리로 변경해주는게 좋음
      return false;
    }
  }

} 