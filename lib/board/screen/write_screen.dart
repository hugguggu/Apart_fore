import 'package:apart_forest/board/model/network_singleton.dart';
import 'package:apart_forest/board/model/post_item_singlton.dart';
import 'package:flutter/material.dart';

class WriteScreen extends StatefulWidget {
  // const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  List<String> dropdownList = ['1', '2', '3'];
  String selectedDropdown = '1';
  final titleTextFieldController = TextEditingController();
  final contentTextFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                NetworkSingleton().posting(1, titleTextFieldController.text,
                    contentTextFieldController.text);
                PostItem().addLoadPostItem();
                setState(() {});
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
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleTextFieldController,
              maxLines: 1,
            ),
            Expanded(
              child: TextField(
                controller: contentTextFieldController,
                decoration: InputDecoration(labelText: 'Enter Message'),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true, // <-- SEE HERE
              ),
            ),
          ],
        ));
  }
}
