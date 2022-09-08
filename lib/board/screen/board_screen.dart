import 'package:apart_forest/board/model/model_post.dart';
import 'package:apart_forest/board/widget/posting_card.dart';
import 'package:apart_forest/board/widget/search_bar.dart';
import 'package:flutter/material.dart';

class BoardScreen extends StatefulWidget {
  final List<String> list = List.generate(10, (index) => "Text $index");

  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  List<Post> postList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: const Text('무슨무슨 아파트 게시판'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: Search(widget.list));
            },
          ),
        ],
      ),
      body: Center(
          child: Expanded(
              child: ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return postcard(post: postList[index]);
                  }))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
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
          setState(() {});
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    ));
  }
}
