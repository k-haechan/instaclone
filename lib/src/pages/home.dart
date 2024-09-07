import 'package:flutter/material.dart';
import 'package:instaclone/src/components/avatar_widget.dart';
import 'package:instaclone/src/components/image_data.dart';
import 'package:instaclone/src/components/post_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Widget _myStory() {
    return Stack(
      children: [
        AvatarWidget(
          thumbPath:
              'https://cdn.hotplacehunter.co.kr/hotplacehunter/2023/12/21103035/3.%EB%8F%84%EB%9D%BD-seuleee____1%EB%8B%98-%EC%9D%B8%EC%8A%A4%ED%83%80%EA%B7%B8%EB%9E%A8-2-2.jpg',
          nickname: 'seuleee',
          type: AvatarType.TYPE2,
          size: 70,
        ),
        Positioned(
          right: 0,
          bottom: 5,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              border: Border.all(color : Colors.white, width: 3)
            ),
            child: Icon(Icons.add, color: Colors.white, size: 20),
          ),
        )
      ],
    );
  }


  Widget _storyBoardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        const SizedBox(width: 20),
        _myStory(),
        const SizedBox(width: 5),
        ...List.generate( // 이부분이 Column으로 변경해야 이름도 같이 나타낼 수 있음
            100,
            (index) => AvatarWidget(
                thumbPath:
                    'https://cdn.hotplacehunter.co.kr/hotplacehunter/2023/12/21103035/3.%EB%8F%84%EB%9D%BD-seuleee____1%EB%8B%98-%EC%9D%B8%EC%8A%A4%ED%83%80%EA%B7%B8%EB%9E%A8-2-2.jpg',
                nickname: '~',
                type: AvatarType.TYPE1))
      ] // CircleAvatar(
          //       backgroundColor: Colors.grey,
          //       radius: 30,
          //     ),
          ),
    );
  }

  Widget _postList() {
    return Column(children: List.generate(50, (idx)=>PostWidget()).toList());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ImageData(
            IconsPath.logo,
            width: 270,
          ),
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                print('Direct Message');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ImageData(IconsPath.directMessage, width: 70),
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            _storyBoardList(),
            SizedBox(height: 10),
            _postList()
          ],
        ));
  }
}
