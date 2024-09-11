import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/src/components/image_data.dart';
import 'package:photo_manager/photo_manager.dart';

class Upload extends StatefulWidget {
  // stateless + GetX로도 할 수 있음. 여기선 GetX에 대한 의존성을 줄이기 위해 stateful로 작성
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  var albums = <AssetPathEntity>[]; // AssetPathEntity는 앨범을 나타내는 클래스
  var headerTitle = '';
  var imageList = <AssetEntity>[]; // AssetEntity는 사진이나 비디오를 나타내는 클래스
  AssetEntity? selectedImage;

  @override
  void initState() {
    super.initState();
    print("initState");

    _loadPhotos(); // GetX로 하는 방법은? Oninit(){}로 작성하면 될듯?
  }

  void _loadPhotos() async {
    // Get.find<UploadController>().fetchPhotos();
    var result = await PhotoManager
        .requestPermissionExtend(); // await문법이 아니라 then문법도 사용가능
    if (result.isAuth) {
      albums = (await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          imageOption: FilterOption(
              sizeConstraint: SizeConstraint(minHeight: 100, minWidth: 100)),
          orders: [
            const OrderOption(asc: false, type: OrderOptionType.createDate)
          ],
        ),
      ));
      _loadData();
    } else {
      print("권한이 없습니다.");
      print("RESULT${result}");
    }
  }

  void _loadData() async {
    headerTitle = albums.first.name;
    await _pagingPhotos();
    print(albums.first.name);
    setState(() {}); // 중괄호 안에 상태변경로직을 담으면 되지만 그냥 랜더링만 하면 돼서 빈칸으로 둠
  }

  _pagingPhotos() async {
    var photos = await albums.first
        .getAssetListPaged(page: 0, size: 28); // 앨범에서 30개씩 가져오기 -> 28개로 수정
    imageList.addAll(photos);
    selectedImage = imageList.first;
    print(imageList.length);
    print(imageList);
  }

  Widget _imagePreview() {
    var width = MediaQuery.of(context).size.width; // 화면의 전체 너비
    return Container(
      width: width,
      height: width,
      color: Colors.grey[400],
      child: _photo(selectedImage, width.toInt(), builder: (data) {
        return Image.memory(
          data,
          fit: BoxFit.cover,
        );
      }),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  isScrollControlled: true,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                  builder: (_) => Container(
                    // height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 7),
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: List.generate(
                                albums.length,
                                (idx) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  child: Text(albums[idx].name),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Text(
                    headerTitle,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: Color(0xff808080),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    ImageData(IconsPath.imageSelectIcon),
                    const SizedBox(width: 5),
                    Text(
                      '여러 항목 선택',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xff808080),
                ),
                child: ImageData(IconsPath.cameraIcon),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _photo(AssetEntity? entity, int size,
      {required Widget Function(Uint8List) builder}) {
    if (entity == null) {
      return Container();
    }
    var thumbnail = entity.thumbnailDataWithSize(ThumbnailSize(size, size));
    print("thumbnail: $thumbnail");
    return FutureBuilder(
        future: thumbnail,
        builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return builder(snapshot.data!);
          // builder 패턴으로 UI관련 Builder는 클라이언트에게 위임
          // builder 패턴을 더 잘게 쪼개서 중복된 부분을 이 위젯에 위임하고 클라리언트는 flag로 구분해서 사용해도 될듯?
          // 물론 flag는 확장에는 좋지 않지만. 중복을 제외하므로 코드가 간결해지고 가독성이 좋아짐(여기선 우선 2가지 경우만 존재함)
          // return Opacity(
          //   opacity: entity == selectedImage ? 0.5 : 1,
          //   child: Image.memory(
          //     snapshot.data!,
          //     fit: BoxFit.cover,
          //   ),
          // );
        });
  }

  Widget _imageSelectList() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 4개의 열
          childAspectRatio: 1, // 가로 세로 비율
          mainAxisSpacing: 1, // 메인축 방향의 간격
          crossAxisSpacing: 1, // 가로 간격
        ),
        itemCount: imageList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: _photo(imageList[index], 200, builder: (data) {
              // 심지어 data는 _photo위젯에 종속적임. 별로 좋은 패턴은 아닌것같은디
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedImage = imageList[index];
                  });
                },
                child: Opacity(
                  opacity: imageList[index] == selectedImage ? 0.3 : 1,
                  child: Image.memory(
                    data,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(IconsPath.closeImage),
          ),
        ),
        title: const Text('New Post',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.nextImage,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagePreview(),
            _header(),
            _imageSelectList(),
          ],
        ),
      ),
    );
  }
}
