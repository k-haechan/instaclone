# instaclone

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


- ImageData , CachedNetworkImage 차이?
- v1??'null'; => v1==null? 'null':null;
- Expanded 위젯 : Expanded는 child가 범위를 최대한 가져갈 수 있도록 해준다. ex_텍스트 입력 Container가 적을 때. 그 길이를 늘려준다.
- 리스트 생성: 1.[], 2.List.generate(), 3.toList()
- PreferredSize : AppBar의 사이즈를 설정할 수 있도록 하는 위젯
- 양 쪽 끝에 배치. leading, action을 사용하지 않아도, Row에서 MainAxisAlginment를 spaceBetween하면 됨.

- 리팩토링 1. IconPath의 image파일을 svg로 변경하면 됨. -> static getter 굳이? static field로 변경
- Pop 구현을 Get.back()으로 바꾸자.
- GetView
- CirCleAvartar
- SizedBox에 너무 의존적인 레이아웃? _myStory와 InstaHomeLogo의 선을 맞추는데 SizedBox보단 다른 방법이 좋지 않을까?
- BottomNavigate고정. - 심지어 여기는 getX도 아닌 기본 플러터로 구현했다.? -> qppBar 5_ 24:47
    - 기존엔 Bottom 고정하고 body를 변경하면서 페이지를 바꿨는데 searchFocus는 아예 페이지 채로 변경이기에.