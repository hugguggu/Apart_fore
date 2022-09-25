import 'package:apart_forest/board/model/article_model.dart';
import 'package:apart_forest/board/model/network_singleton.dart';
import 'package:apart_forest/board/model/post_item_singlton.dart';
import 'package:apart_forest/board/model/user_info_singleton.dart';
import 'package:apart_forest/board/screen/write_screen.dart';
import 'package:flutter/material.dart';

class ReadScreen extends StatefulWidget {
  final article_apt post;

  const ReadScreen({Key key, this.post}) : super(key: key);

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  article_apt _postDetail;
  // bool _iLike;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _getArticleDetail();
    return Scaffold(
      appBar: AppBar(
        title: Text(UserInfo().getKaptName()),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.backspace),
        ),
        actions: UserInfo().getId() != widget.post.userId
            ? null
            : <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WriteScreen(
                                category_modify: widget.post.category,
                                title_modify: widget.post.title,
                                content_modify: widget.post.content,
                              )),
                    );
                  },
                  child: const Text(
                    "수정",
                    style: TextStyle(fontSize: 16, color: Colors.redAccent),
                  ),
                  // shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                ),
              ],
      ),
      body: FutureBuilder(
          future: _getArticleDetail(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                return Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            PostItem()
                                .getCategoryList()[_postDetail.category]
                                .toString(),
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _postDetail.title,
                              style: const TextStyle(
                                fontSize: 32,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _postDetail.nickname,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                PostItem().getTimeText(_postDetail.updatedAt),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // TextField(
                    //   // controller: _titleController,
                    //   controller: TextEditingController(
                    //       text: PostItem()
                    //           // .getCategoryList()[widget.post.category]
                    //           .getCategoryList()[_postDetail.category]
                    //           .toString()),
                    //   decoration: const InputDecoration(labelText: 'Category'),
                    //   enabled: false,
                    //   maxLines: 1,
                    // ),
                    // Container(
                    //   height: 1.0,
                    //   width: double.maxFinite,
                    //   color: Colors.blue[100],
                    // ),
                    // TextField(
                    //   // controller: _titleController,
                    //   controller:
                    //       // TextEditingController(text: widget.post.title),
                    //       TextEditingController(text: _postDetail.title),
                    //   // decoration: const InputDecoration(labelText: 'Title'),
                    //   enabled: false,
                    //   maxLines: 1,
                    // ),
                    Container(
                      height: 1.0,
                      width: double.maxFinite,
                      color: Colors.blue[100],
                    ),
                    Expanded(
                      child: TextField(
                        controller:
                            //  TextEditingController(text: widget.post.content),
                            TextEditingController(text: _postDetail.content),
                        // decoration: const InputDecoration(labelText: 'Message'),
                        // controller: TextEditingController().text = 'dsfsd',
                        maxLines: null,
                        expands: true, // <-- SEE HERE
                        enabled: false,
                        // initialValue: widget.post.bodyText,
                      ),
                    ),
                    // ReadPageBottomBar(
                    //   // postDetail: _postDetail,
                    //   postDetail: widget.post,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () async {
                            if (_postDetail.iLike == null) {
                              await NetworkSingleton()
                                  .checkLike(_postDetail.id);
                              _postDetail.likes =
                                  (int.parse(_postDetail.likes) + 1).toString();
                            } else {
                              await NetworkSingleton()
                                  .deleteLike(_postDetail.id);
                              _postDetail.likes =
                                  (int.parse(_postDetail.likes) - 1).toString();
                            }

                            // Future.delayed(const Duration(milliseconds: 3000));
                            setState(() {});
                          },
                          child: MaterialButton(
                            padding: const EdgeInsets.all(10),
                            // onPressed: () {},
                            child: Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Icon(
                                  _postDetail.iLike == null
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  color: _postDetail.iLike == null
                                      ? Colors.black45
                                      : Colors.red,
                                  size: 36,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(_postDetail.likes)),
                            ]),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 10,
                          color: Colors.red,
                        ),
                        MaterialButton(
                          padding: const EdgeInsets.all(10),
                          onPressed: () {},
                          child: Row(children: [
                            const Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.comment,
                                size: 36,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(_postDetail.likes)),
                          ]),
                        ),
                        Container(
                          width: 1,
                          height: 10,
                          color: Colors.red,
                        ),
                        MaterialButton(
                          padding: const EdgeInsets.all(10),
                          onPressed: () {},
                          child: Row(children: const [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.share,
                                size: 36,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Text('공유하기'),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ],
                );
            }
          }),
    );
  }

  Future<void> _getArticleDetail() async {
    _postDetail = await NetworkSingleton().getArticleDetail(widget.post.id);
    // _postDetail = await NetworkSingleton().getArticleDetail();
    // _iLike = _postDetail.iLike == null ? false : true;
  }
}
