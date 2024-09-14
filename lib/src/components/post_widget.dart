import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/src/components/avatar_widget.dart';
import 'package:instaclone/src/components/image_data.dart';
import 'package:instaclone/src/models/post.dart';
import 'package:timeago/timeago.dart' as timeago;
class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AvatarWidget(
            type: AvatarType.TYPE3,
            thumbPath:post.userInfo!.thumbnail!,
            nickname: post.userInfo!.nickname!,
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
      imageUrl: post.thumbnail!,
      // width: double.infinity,
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('좋아요 ${post.likeCount??0 }개', style: TextStyle(fontWeight: FontWeight.bold),),
          ExpandableText(post.description??'', prefixText:post.userInfo!.nickname,
          onPrefixTap: (){print('postWidget._infoDescription.onPrefixTap');},
          prefixStyle: TextStyle(fontWeight: FontWeight.bold),
          expandText: '더보기',
          collapseText: '접기',
          maxLines: 3,
          expandOnTextTap: true,
          collapseOnTextTap: true,
          linkColor: Colors.grey,
          )


          // SizedBox(height: 10),
          // Text('좋아요 ${post.likeCount??0}개', style: TextStyle(fontWeight: FontWeight.bold),),
          // SizedBox(height: 5),
          // Row(
          //   children: [
          //     Text('sojuKing', style: TextStyle(fontWeight: FontWeight.bold),),
          //     SizedBox(width: 5),
          //     Text('오늘은 맛있는 술을 마셨어요.', style: TextStyle(fontSize: 13),)
          //   ],
          // ),
          // ExpandableText('댓글정리댓글 길게 댓글 안돼 댓글 적당히\ndgfd\ngjhgjh', style: TextStyle(fontSize: 13),
          // maxLines: 2,
          // expandOnTextTap: true,
          // collapseOnTextTap: true,
          // prefixText:'김해찬',prefixStyle: TextStyle(fontWeight: FontWeight.bold), expandText: '더보기', collapseText: '접기',),
          // SizedBox(height: 5),
          // Text('댓글 10개 모두 보기', style: TextStyle(color: Colors.grey),),
          // // _replyTextBtn(),
          // SizedBox(height: 5),
          // Text('1시간 전', style: TextStyle(color: Colors.grey),)
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
      child: Text(
        timeago.format(post.createAt!),
        style: TextStyle(color: Colors.grey, fontSize: 11)),
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
