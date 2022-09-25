import 'package:apart_forest/board/model/network_singleton.dart';
import 'package:apart_forest/board/model/post_item_singlton.dart';
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
  // List<String> dropdownList = ['궁금해요', '불편해요', '칭찬해요', '나눔해요', '공유해요'];
  int selectedDropdown = 0;
  final titleTextFieldController = TextEditingController();
  final contentTextFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (widget.title_modify.isNotEmpty || widget.content_modify.isNotEmpty) {
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
              Navigator.pop(context);
            },
            icon: const Icon(Icons.backspace),
          ),
          actions: <Widget>[
            MaterialButton(
              // textColor: Colors.white,
              onPressed: () {
                NetworkSingleton().posting(
                    selectedDropdown,
                    titleTextFieldController.text,
                    contentTextFieldController.text);
                PostItem().addLoadPostItem();
                Navigator.pop(context);
              },
              child: const Text(
                "Save",
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
}
