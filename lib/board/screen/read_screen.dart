import 'package:apart_forest/board/model/article_model.dart';
import 'package:apart_forest/board/model/user_info_singleton.dart';
import 'package:flutter/material.dart';

class ReadScreen extends StatefulWidget {
  final article_apt post;

  const ReadScreen({Key key, this.post}) : super(key: key);

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  List<String> dropdownList = ['1', '2', '3'];
  String selectedDropdown = '1';

  @override
  Widget build(BuildContext context) {
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                DropdownButton(
                  value: selectedDropdown,
                  items: dropdownList.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (dynamic value) {
                    setState(() {
                      selectedDropdown = value;
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
              // controller: _titleController,
              controller: TextEditingController(text: widget.post.title),
              decoration: const InputDecoration(labelText: 'Title'),
              enabled: false,
              maxLines: 1,
            ),
            Expanded(
              child: TextField(
                controller: TextEditingController(text: widget.post.content),
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
                  onPressed: () {},
                  child: Row(children: [
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.thumb_up,
                        size: 36,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('${widget.post.likes}')),
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
                        padding: EdgeInsets.all(5),
                        child: Text("${widget.post.likes}")),
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
            )
          ],
        ));
  }
}
