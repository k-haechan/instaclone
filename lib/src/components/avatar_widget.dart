import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum AvatarType { TYPE1, TYPE2, TYPE3 }

class AvatarWidget extends StatelessWidget {
  final bool? hasStory;
  final String thumbPath;
  final String nickname;
  final AvatarType type;
  final double? size; // radius로 변경(리팩토링)

  const AvatarWidget({
    super.key,
    this.hasStory,
    required this.thumbPath,
    required this.nickname,
    required this.type,
    this.size = 65, // default size
  });

  Widget type1Widget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5), // Story끼리의 간격
      padding: const EdgeInsets.all(2),                  // Story의 테두리
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.purple, Colors.orange],
        ),
        shape: BoxShape.circle,
      ),
      child: type2Widget());
  }

  Widget type2Widget() {
    return Container(
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        padding: const EdgeInsets.all(2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size!),
          child: SizedBox( // 위에는 다 Container 옵션. -> 이거 나중에 CircleAvatar로 변경해보기.
              width: size,
              height: size,
              child: CachedNetworkImage(imageUrl: thumbPath, fit: BoxFit.cover)),
        ),
      );
  }

  Widget type3Widget() {
    return Row(
      children: [
      type1Widget(),
      const SizedBox(width: 10),
      Text(nickname, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    ],);
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AvatarType.TYPE1:
        return type1Widget();
      case AvatarType.TYPE2:
        return type2Widget();
      case AvatarType.TYPE3:
        return type3Widget();
      default:
        return type1Widget();
    }
  }
}
