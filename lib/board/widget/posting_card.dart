import 'package:apart_forest/board/model/article_model.dart';
import 'package:apart_forest/board/model/model_post.dart';
import 'package:apart_forest/board/model/network_singleton.dart';
import 'package:apart_forest/board/screen/read_screen.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apart_forest/board/model/post_item_singlton.dart';

class postcard extends StatelessWidget {
  // const postcard({super.key});

  const postcard({Key key, this.post}) : super(key: key);
  final article_apt post;
  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.blue[100],
      margin: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (BuildContext context) {
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
                  child: Text(
                    PostItem().getCategoryList()[post.category],
                    style: const TextStyle(
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
                      post.content,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 2),
                  child: Text(post.nickname.toString()),
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
                            post.views.toString(),
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
                            post.likes.toString(),
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
                        child: Text(_getTimeText(post.updatedAt)),
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
}

String _getTimeText(String time) {
  Duration diffDate = DateTime.parse(time).difference(DateTime.now());
  diffDate = diffDate * -1;
  if (diffDate.inDays > 0) {
    return '${diffDate.inDays} 일전';
  } else if (diffDate.inHours > 0) {
    return '${diffDate.inHours} 시간전';
  } else if (diffDate.inMinutes > 0) {
    return '${diffDate.inMinutes} 분전';
  } else if (diffDate.inSeconds > 0) {
    return '몇 초전';
  } else {}

  return '알수없음';
}

class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.readDuration,
  });

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                author,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$publishDate - $readDuration',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  const CustomListItemTwo({
    // super.key,
    this.thumbnail,
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.readDuration,
  });

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        //padding: const EdgeInsets.symmetric(vertical: 10.0),
        height: 100,
        child: InkWell(
          onTap: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                  child: _ArticleDescription(
                    title: title,
                    subtitle: subtitle,
                    author: author,
                    publishDate: publishDate,
                    readDuration: readDuration,
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 1.0,
                child: thumbnail,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostCard2 extends StatelessWidget {
  // const PostCard2({super.key});
  const PostCard2({Key key, this.post}) : super(key: key);
  final Post post;
  @override
  Widget build(BuildContext context) {
    return CustomListItemTwo(
      thumbnail: Container(
        decoration: const BoxDecoration(color: Colors.pink),
      ),
      title: post.title,
      subtitle: post.bodyText,
      author: post.writer,
      publishDate: 'Dec 28',
      readDuration: '5 mins',
    );
  }
}
