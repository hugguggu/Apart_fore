import 'package:apart_forest/board/model/article_model.dart';
import 'package:apart_forest/board/model/network_singleton.dart';

class PostItem {
  static final PostItem _instance = PostItem._internal();

  Function function_setstate;

  factory PostItem() {
    return _instance;
  }

  PostItem._internal() {}

  List<article_apt> postList = [];

  void setSetStateFunction(Function func) {
    function_setstate = func;
  }

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

  Future<void> reLoadPostItem() async {
    List<dynamic> list = await NetworkSingleton().getPostingList();

    if (list == null) {
      return;
    }

    postList.clear();
    for (int i = 0; i < list.length; i++) {
      postList.add(list[i]);
    }

    function_setstate();
  }

  Future<void> addLoadPostItem() async {
    List<dynamic> list = await NetworkSingleton().getPostingList();

    List<article_apt> newList = avoidDuplication(list);

    for (int i = 0; i < newList.length; i++) {
      postList.add(newList[i]);
    }

    function_setstate();
  }

  List<article_apt> avoidDuplication(List<dynamic> newlist) {
    List<article_apt> res = [];

    var currentArticleIds = (postList.asMap().entries.map((entry) {
      MapEntry<int, article_apt> map = entry;
      return map.value.id;
    })); //.contains('04');

    List<article_apt> list = newlist;
    for (int i = 0; i < newlist.length; i++) {
      if (currentArticleIds.toList().contains(list[i].id)) {
        // print('중복');
      } else {
        res.add(list[i]);
      }
    }
    return res;
  }
}
