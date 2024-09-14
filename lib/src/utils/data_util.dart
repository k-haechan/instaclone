import 'package:uuid/uuid.dart';

class DataUtil {
  static String makeFilePath(){
    return '${Uuid().v4()}.jpg'; // 오리지날 파일 명에서 확장자를 추출해주는게 좋다.
  }
}