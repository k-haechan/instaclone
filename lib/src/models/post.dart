import 'package:instaclone/src/models/instagram_user.dart';

class Post {
  final String? id;
  final String? thumbnail; // 여러 이미지들을 관리할거면 리스트로 변경.
  final String? description;
  final int? likeCount;
  final IUser? userInfo;
  final String? uid;
  final DateTime? createAt;
  final DateTime? updateAt;
  final DateTime? deleteAt;

  Post({
    this.id,
    this.thumbnail,
    this.description,
    this.likeCount,
    required this.userInfo,
    this.uid,
    this.createAt,
    this.updateAt,
    this.deleteAt,
  });

  factory Post.fromJson(String docId, Map<String, dynamic> json) {
    return Post(
      id: json['id'] == null ? '' : json['id'] as String,
      thumbnail: json['thumbnail'] == null ? '' : json['thumbnail'] as String,
      description: json['description'] == null ? '' : json['description'] as String,
      likeCount: json['like_count'] == null ? 0 : json['like_count'] as int,
      userInfo: json['user_info'] == null? null : IUser.fromJson(json['user_info']),
      uid: json['uid'] == null ? '' : json['uid'] as String,
      createAt: json['create_at'] == null ? DateTime.now() : json['create_at'].toDate() as DateTime,
      updateAt: json['update_at'] == null ? DateTime.now() : json['update_at'].toDate() as DateTime,
      deleteAt: json['delete_at'] == null ? null : json['delete_at'].toDate() as DateTime,
    );
  }

  factory Post.init(IUser userInfo) {
    var time = DateTime.now();
    return Post(
      thumbnail: '',
      userInfo: userInfo,
      uid: userInfo.uid,
      description: '',
      createAt: time,
      updateAt: time,
    );

  }

  Post copyWith({
    String? id,
    String? thumbnail,
    String? description,
    int? likeCount,
    IUser? userInfo,
    String? uid,
    DateTime? createAt,
    DateTime? updateAt,
    DateTime? deleteAt,
  }) {
    return Post(
      id: id ?? this.id,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
      likeCount: likeCount ?? this.likeCount,
      userInfo: userInfo ?? this.userInfo,
      uid: uid ?? this.uid,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'thumbnail': thumbnail,
      'description': description,
      'like_count': likeCount,
      'user_info': userInfo!.toMap(),
      'uid': uid,
      'create_at': createAt,
      'update_at': updateAt,
      'delete_at': deleteAt,
    };
  }
}