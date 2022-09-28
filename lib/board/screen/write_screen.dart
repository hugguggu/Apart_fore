import 'package:apart_forest/board/model/network_singleton.dart';
import 'package:apart_forest/board/model/post_item_singlton.dart';
import 'package:apart_forest/board/screen/board_screen.dart';
import 'package:flutter/material.dart';

class WriteScreen extends StatefulWidget {
  final int category_modify;
  final String title_modify;
  final String content_modify;

  const WriteScreen(
      {Key key, this.category_modify, this.title_modify, this.content_modify})
      : super(key: key);

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  int selectedDropdown = 0;
  final titleTextFieldController = TextEditingController();
  final contentTextFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (widget.category_modify != null &&
        widget.title_modify != null &&
        widget.content_modify != null) {
      selectedDropdown = widget.category_modify;
      titleTextFieldController.text = widget.title_modify;
      contentTextFieldController.text = widget.content_modify;
    }
    return Scaffold(
        appBar: AppBar(
          // iconTheme: Icons.,
          title: const Text('새 글쓰기'),
          leading: IconButton(
            onPressed: () {
              if (selectedDropdown == 0 &&
                  titleTextFieldController.text.isEmpty &&
                  contentTextFieldController.text.isEmpty) {
                Navigator.pop(context);
              } else {
                _showdBackDialog(context)
                    .then((value) => (value) ? Navigator.pop(context) : null);
              }
            },
            icon: const Icon(Icons.backspace),
          ),
          actions: <Widget>[
            MaterialButton(
              // textColor: Colors.white,
              onPressed: () {
                if (selectedDropdown == 0) {
                  _showdTextFieldDialog(context, 0);
                } else if (titleTextFieldController.text.isEmpty) {
                  _showdTextFieldDialog(context, 1);
                } else if (contentTextFieldController.text.isEmpty) {
                  _showdTextFieldDialog(context, 2);
                } else {
                  _showdSaveDialog(context)
                      .then((value) => (value) ? Navigator.pop(context) : null);
                }
              },
              child: const Text(
                "저장",
                style: TextStyle(fontSize: 16, color: Colors.redAccent),
              ),
              // shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                DropdownButton(
                  value: PostItem().getCategoryList()[selectedDropdown],
                  items: PostItem().getCategoryList().map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (dynamic value) {
                    setState(() {
                      // selectedDropdown = value;
                      selectedDropdown =
                          PostItem().getCategoryList().indexOf(value);
                    });
                  },
                ),
              ],
            ),
            Container(
              height: 1.0,
              width: double.maxFinite,
              color: Colors.blueAccent,
            ),
            TextField(
              decoration: const InputDecoration(labelText: '제목을 입력하세요'),
              controller: titleTextFieldController,
              maxLines: 1,
            ),
            Expanded(
              child: TextField(
                controller: contentTextFieldController,
                decoration: const InputDecoration(labelText: '내용을 입력하세요'),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true, // <-- SEE HERE
              ),
            ),
          ],
        ));
  }

  Future<dynamic> _showdSaveDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        // title: Text('글쓰기'),
        content: const Text('작성한 글을 게시하겠습니까?'),
        actions: [
          ElevatedButton(
            child: const Text('확인'),
            onPressed: () {
              NetworkSingleton().posting(
                  selectedDropdown,
                  titleTextFieldController.text,
                  contentTextFieldController.text);
              PostItem().addLoadPostItem();

              Navigator.pop(context, true);
            },
          ),
          ElevatedButton(
            child: const Text('취소'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showdTextFieldDialog(BuildContext context, int code) {
    String txt;
    if (code == 0) {
      txt = '카테고리를 지정해 주세요';
    } else if (code == 1) {
      txt = '글의 제목을 작성해 주세요';
    } else if (code == 2) {
      txt = '글의 내용을 작성해 주세요';
    } else {
      txt = '알수없는 오류';
    }
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(txt),
        actions: [
          ElevatedButton(
            child: const Text('확인'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showdBackDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('작성중이던 내용이 있습니다.\n취소하시겠습니까?'),
        actions: [
          ElevatedButton(
            child: const Text('확인'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          ElevatedButton(
            child: const Text('취소'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      ),
    );
  }
}
