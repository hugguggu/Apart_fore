import 'package:apart_forest/board/model/model_post.dart';
import 'package:apart_forest/board/widget/posting_card.dart';
import 'package:apart_forest/board/widget/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class refresh extends StatefulWidget {
  final List<String> list = List.generate(10, (index) => "Text $index");

  _refreshState createState() => _refreshState();
}

class _refreshState extends State<refresh> {
  List<Post> postList = [];

  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length + 1).toString());
    post_test();
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) => postcard(post: postList[i]),
          // itemExtent: 100.0,
          itemCount: postList.length,
        ),
      ),
    );
  }

  // from 1.5.0, it is not necessary to add this line
  //@override
  // void dispose() {
  // TODO: implement dispose
  //  _refreshController.dispose();
  //  super.dispose();
  // }

  // ignore: non_constant_identifier_names
  void post_test() {
    Post post = Post.fromMap({
      'title': 'BCDE',
      'bodyText':
          'Preview_ABCDEFGHIJKLMNOPQRSTUVWXYZ_ABCDEFGHIJKLMNOPQRSTUVWXYZ_ABCDEFGHIJKLMNOPQRSTUVWXYZ',
      'viewer': 13,
      'blind': false,
      'writer': 'XYZ',
      'visit': 12
      // 'comment' : ['abc', 'dec']
    });
    postList.add(post);
    // setState(() {});
  }
}
