class IUser {
  String? uid;
  String? nickname;
  String? thumbnail;
  String? description;
  IUser({this.uid, this.nickname, this.thumbnail, this.description});

  factory IUser.fromJson(Map<String, dynamic> json) { // 함수 형태로 사용할 수 있는 생성자. static 생성자 함수??
    return IUser(
      uid: json['uid']==null?'':json['uid'] as String, // as String은 toString()과는 다르게 이미 값은 String이지만 데이터형이 dynamic인 변수를 String형으로 명시해주는 것이다.
      nickname: json['nickname']==null?'':json['nickname'] as String,
      thumbnail: json['thumbnail']==null?'':json['thumbnail'] as String,
      description: json['description']==null?'':json['description'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nickname': nickname,
      'thumbnail': thumbnail,
      'description': description,
    };
  }

  IUser copyWith({String? uid, String? nickname, String? thumbnail, String? description}) {
    return IUser(
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
    );
  }
}