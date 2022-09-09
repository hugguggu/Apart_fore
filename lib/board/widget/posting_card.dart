import 'package:apart_forest/board/model/model_post.dart';
import 'package:apart_forest/board/screen/read_screen.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class postcard extends StatelessWidget {
  // const postcard({super.key});

  const postcard({Key key, this.post}) : super(key: key);
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
              return ReadScreen(
                post: post,
              );
            }));
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
                    post.title,
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
                    post.bodyText,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 2),
                child: Text(post.writer),
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
                          post.visit.toString(),
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
                          post.visit.toString(),
                        ),
                        // const Icon(
                        //   Icons.comment,
                        //   size: 26,
                        // ),
                        // Text(post.viewer.toString()),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: const Text('TIME'),
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
    );
  }
}
