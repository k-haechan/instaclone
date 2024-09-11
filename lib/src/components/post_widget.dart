import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/src/components/avatar_widget.dart';
import 'package:instaclone/src/components/image_data.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AvatarWidget(
            type: AvatarType.TYPE3,
            thumbPath:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSd7UxYCzowiUdcQsiDNbm6lO8vxzqNpu4PQ&s',
            nickname: 'sojuKing',
            size: 40,
          ),
          GestureDetector(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageData(IconsPath.postMoreIcon, width: 30,),
            ),
          )
        ],
      ),
    );
  }

  Widget _image() {
    return CachedNetworkImage(
      imageUrl: 'https://cdn.hotplacehunter.co.kr/hotplacehunter/2023/12/21103035/3.%EB%8F%84%EB%9D%BD-seuleee____1%EB%8B%98-%EC%9D%B8%EC%8A%A4%ED%83%80%EA%B7%B8%EB%9E%A8-2-2.jpg',
      width: double.infinity,
      // height: 400,
    );
  }

  Widget _infoCount() { // 좋아요, 댓글, dm, 북마크
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Row(children: [
          ImageData(IconsPath.likeOffIcon, width: 65,),
          const SizedBox(width: 15),
          ImageData(IconsPath.replyIcon, width: 60,),
          const SizedBox(width: 15),
          ImageData(IconsPath.directMessage, width: 55,)
        ],), 
                ImageData(IconsPath.bookMarkOffIcon, width: 50 ,)
      
      ],),
    );
  }

  Widget _infoDescription() { // 닉네임, 설명, 댓글, 시간
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10),
          Text('좋아요 100개', style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 5),
          Row(
            children: [
              Text('sojuKing', style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(width: 5),
              Text('오늘은 맛있는 술을 마셨어요.', style: TextStyle(fontSize: 13),)
            ],
          ),
          ExpandableText('댓글정리댓글 길게 댓글 안돼 댓글 적당히\ndgfd\ngjhgjh', style: TextStyle(fontSize: 13),
          maxLines: 2,
          expandOnTextTap: true,
          collapseOnTextTap: true,
          prefixText:'김해찬',prefixStyle: TextStyle(fontWeight: FontWeight.bold), expandText: '더보기', collapseText: '접기',),
          SizedBox(height: 5),
          Text('댓글 10개 모두 보기', style: TextStyle(color: Colors.grey),),
          // _replyTextBtn(),
          SizedBox(height: 5),
          Text('1시간 전', style: TextStyle(color: Colors.grey),)
        ],
      ),
    );
  }

  Widget _replyTextBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GestureDetector(onTap: (){}, child: const Text('댓글 199개 모두보기', style: TextStyle(color: Colors.grey, fontSize: 13),) 
      ),
    );
  }

  Widget _dateAgo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text('1시간 전', style: TextStyle(color: Colors.grey, fontSize: 11)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(),
          const SizedBox(height: 15),
          _image(),
          const SizedBox(height: 15),
          _infoCount(),
          const SizedBox(height: 5),
          _infoDescription(),
          const SizedBox(height: 5),
          _replyTextBtn(),
          _dateAgo(),
        ],
      ),
    );
  }
}
