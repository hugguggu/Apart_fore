import 'dart:ui';

import 'package:apart_forest/board/model/model_post.dart';
import 'package:flutter/material.dart';

class BoardScreen extends StatefulWidget {
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
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
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
      Container(
        child: Column(
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
                    padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        posts[i].title,
                        style: TextStyle(
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        posts[i].bodyText,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(posts[i].writer),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.visibility,
                                size: 12,
                              ),
                              Text(posts[i].visit.toString()),
                              Icon(
                                Icons.comment,
                                size: 12,
                              ),
                              Text(posts[i].viewer.toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1.0,
                    width: 500.0,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  return res;
}
