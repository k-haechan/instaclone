import 'package:get/get.dart';
import 'package:instaclone/src/models/post.dart';
import 'package:instaclone/src/repository/post_repository.dart';

class HomeController extends GetxController{

  RxList<Post> postList = <Post>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _loadFeedList();
  }

  void _loadFeedList() async {
    List<Post> feedList = await PostRepository.loadFeedList();
    postList.addAll(feedList);
  }
}