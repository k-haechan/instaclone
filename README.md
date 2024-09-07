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

- 리팩토링 1. IconPath의 image파일을 svg로 변경하면 됨. -> static getter 굳이? static field로 변경
- Pop 구현을 Get.back()으로 바꾸자.
- GetView
- CirCleAvartar
- SizedBox에 너무 의존적인 레이아웃? _myStory와 InstaHomeLogo의 선을 맞추는데 SizedBox보단 다른 방법이 좋지 않을까?