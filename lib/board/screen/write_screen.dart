import 'package:flutter/material.dart';

class WriteScreen extends StatefulWidget {
  // const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  List<String> dropdownList = ['1', '2', '3'];
  String selectedDropdown = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // iconTheme: Icons.,
          title: const Text('A.Fore Board - Writing'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.backspace),
          ),
          actions: <Widget>[
            MaterialButton(
              // textColor: Colors.white,
              onPressed: () {},
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
            const TextField(
              decoration: InputDecoration(labelText: 'Title'),
              maxLines: 1,
            ),
            const Expanded(
              child: TextField(
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
