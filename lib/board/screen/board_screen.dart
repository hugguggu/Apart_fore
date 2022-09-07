import 'package:apart_forest/board/model/model_post.dart';
import 'package:apart_forest/board/widget/search_bar.dart';
import 'package:flutter/material.dart';

class BoardScreen extends StatefulWidget {
  final List<String> list = List.generate(10, (index) => "Text $index");

  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: makeArticleList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    ));
  }
}

List<Widget> makeArticleList() {
  List<Widget> res = [];

  List<Post> posts = [
    Post.fromMap({
      'title': 'BCDE',
      'bodyText':
          'Preview_ABCDEFGHIJKLMNOPQRSTUVWXYZ_ABCDEFGHIJKLMNOPQRSTUVWXYZ_ABCDEFGHIJKLMNOPQRSTUVWXYZ',
      'viewer': 13,
      'blind': false,
      'writer': 'XYZ',
      'visit': 12
      // 'comment' : ['abc', 'dec']
    }),
    Post.fromMap({
      'title': 'BCDE',
      'bodyText':
          'Preview_ABCDEFGHIJKLMNOPQRSTUVWXYZ_ABCDEFGHIJKLMNOPQRSTUVWXYZ_ABCDEFGHIJKLMNOPQRSTUVWXYZ',
      'viewer': 13,
      'blind': false,
      'writer': 'XYZ',
      'visit': 12
      // 'comment' : ['abc', 'dec']
    }),
  ];

  for (var i = 0; i < posts.length; i++) {
    res.add(
      Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
              //   return DetailScreen(
              //     movies: movies[i],
              //   );
              // }));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  child: const Text(
                    'TAG',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      posts[i].title,
                      style: const TextStyle(
                        fontSize: 26,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      posts[i].bodyText,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 2),
                  child: Text(posts[i].writer),
                ),
                Container(
                  height: 1.0,
                  width: double.maxFinite,
                  color: Colors.blueAccent,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          const Icon(
                            Icons.visibility,
                            color: Colors.black54,
                            size: 26,
                          ),
                          Text(
                            posts[i].visit.toString(),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const Icon(
                            Icons.thumb_up,
                            size: 26,
                            color: Colors.black54,
                          ),
                          Text(
                            posts[i].visit.toString(),
                          ),
                          // const Icon(
                          //   Icons.comment,
                          //   size: 26,
                          // ),
                          // Text(posts[i].viewer.toString()),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text('TIME'),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 5.0,
                  width: double.maxFinite,
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return res;
}
