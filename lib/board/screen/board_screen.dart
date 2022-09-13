import 'dart:convert';

import 'package:apart_forest/board/model/network_singleton.dart';
import 'package:apart_forest/board/model/post_item_singlton.dart';
import 'package:apart_forest/board/model/user_info_singleton.dart';
import 'package:apart_forest/board/screen/write_screen.dart';
import 'package:apart_forest/board/widget/posting_card.dart';
import 'package:apart_forest/board/widget/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BoardScreen extends StatefulWidget {
  final List<String> list = List.generate(10, (index) => "Text $index");

  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    // _loadPostItem();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text(UserInfo().getKaptName()),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // showSearch(context: context, delegate: Search(widget.list));
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SearchPage()));
            },
          ),
        ],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = const Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = const CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = const Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = const Text("release to load more");
            } else {
              body = const Text("No more Data");
            }
            return SizedBox(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) => postcard(post: PostItem().getPostItembyIdx(i)),
          // itemExtent: 100.0,
          itemCount: PostItem().getPostItemNum(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WriteScreen()),
          );
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    ));
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 500));
    // if failed,use refreshFailed()
    PostItem().reLoadPostItem(funcSetState);
    // if (mounted) setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 500));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length + 1).toString());
    PostItem().reLoadPostItem(funcSetState);
    // if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  void funcSetState() {
    setState(() {});
  }
}
