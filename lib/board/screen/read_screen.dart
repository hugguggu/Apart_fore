import 'package:apart_forest/board/model/article_model.dart';
import 'package:apart_forest/board/model/network_singleton.dart';
import 'package:apart_forest/board/model/post_item_singlton.dart';
import 'package:apart_forest/board/model/user_info_singleton.dart';
import 'package:flutter/material.dart';

class ReadScreen extends StatefulWidget {
  final article_apt post;

  const ReadScreen({Key key, this.post}) : super(key: key);

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  article_apt _postDetail;

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
      ),
      body: FutureBuilder(
          future: _getArticleDetail(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                return //Center(child: Text(snapshot.data));
                    Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Row(
                    //   children: [
                    //     // DropdownButton(
                    //     //   value: PostItem().getTagList()[widget.post.category],
                    //     //   items: PostItem().getTagList().map((String item) {
                    //     //     return DropdownMenuItem<String>(
                    //     //       child: Text('$item'),
                    //     //       value: item,
                    //     //       enabled: false,
                    //     //     );
                    //     //   }).toList(),
                    //     //   onChanged: (dynamic value) {
                    //     //     setState(() {
                    //     //       selectedDropdown = value;
                    //     //     });
                    //     //   },
                    //     // ),
                    //   ],
                    // ),
                    TextField(
                      // controller: _titleController,
                      controller: TextEditingController(
                          text: PostItem()
                              // .getCategoryList()[widget.post.category]
                              .getCategoryList()[_postDetail.category]
                              .toString()),
                      decoration: const InputDecoration(labelText: 'Category'),
                      enabled: false,
                      maxLines: 1,
                    ),
                    Container(
                      height: 1.0,
                      width: double.maxFinite,
                      color: Colors.blue[100],
                    ),
                    TextField(
                      // controller: _titleController,
                      controller:
                          // TextEditingController(text: widget.post.title),
                          TextEditingController(text: _postDetail.title),
                      decoration: const InputDecoration(labelText: 'Title'),
                      enabled: false,
                      maxLines: 1,
                    ),
                    Container(
                      height: 1.0,
                      width: double.maxFinite,
                      color: Colors.blue[100],
                    ),
                    Expanded(
                      child: TextField(
                        controller:
                            // TextEditingController(text: widget.post.content),
                            TextEditingController(text: _postDetail.content),
                        decoration: const InputDecoration(labelText: 'Message'),
                        // controller: TextEditingController().text = 'dsfsd',
                        maxLines: null,
                        expands: true, // <-- SEE HERE
                        enabled: false,
                        // initialValue: widget.post.bodyText,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          padding: const EdgeInsets.all(10),
                          onPressed: () {
                            _postDetail.iLike == null
                                ? NetworkSingleton().checkLike(_postDetail.id)
                                : NetworkSingleton().deleteLike(_postDetail.id);
                          },
                          child: Row(children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                _postDetail.iLike == null
                                    ? Icons.thumb_up_outlined
                                    : Icons.thumb_up,
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

    // print(_postDetail is Map);
  }
}
