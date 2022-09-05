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
          children: makeArticleList(),
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

  for (var i = 0; i < 10; i++) {
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
              child: Container(
                padding: EdgeInsets.only(right: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '가나다라',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
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
                  Text('12'),
                  Icon(
                    Icons.comment,
                    size: 12,
                  ),
                  Text('12'),
                ],
              ),
            ),
            Container(
              height: 1.0,
              width: 500.0,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  return res;
}
