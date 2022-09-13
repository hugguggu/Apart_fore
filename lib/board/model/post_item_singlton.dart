import 'package:apart_forest/board/model/article_model.dart';
import 'package:apart_forest/board/model/network_singleton.dart';

class PostItem {
  static final PostItem _instance = PostItem._internal();

  factory PostItem() {
    return _instance;
  }

  PostItem._internal() {}

  List<article_apt> postList = [];

  List<article_apt> getPostList() {
    return postList;
  }

  article_apt getPostItembyIdx(int value) {
    return postList[value];
  }

  void addPostItem(article_apt post) {
    postList.add(post);
  }

  int getPostItemNum() {
    return postList.length;
  }

  Future<void> reLoadPostItem(Function function) async {
    List<dynamic> list = await NetworkSingleton().getPostingList();
    postList.clear();
    for (int i = 0; i < list.length; i++) {
      postList.add(list[i]);
    }

    function();
  }

  Future<void> reLoadPostItem_test() async {
    List<dynamic> list = await NetworkSingleton().getPostingList();
    postList.clear();
    for (int i = 0; i < list.length; i++) {
      postList.add(list[i]);
    }
  }
}
