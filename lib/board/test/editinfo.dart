import 'package:apart_forest/board/model/network_singleton.dart';
import 'package:apart_forest/board/model/user_info_singleton.dart';
import 'package:apart_forest/board/test/mypage.dart';
import 'package:apart_forest/main.dart';
import 'package:flutter/material.dart';

class editinfo extends StatelessWidget {
  String strNick = UserInfo().getNickName();
  String strAtp = UserInfo().getKaptName();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    print('******* nickname ******* ' + strNick);
    print('******* nickname ******* ' + strAtp);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text(
          '정보 수정',
        ),
        actions: <Widget>[
          TextButton.icon(
              icon: const Icon(
                Icons.save,
                size: 30,
                color: Colors.white,
              ),
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              label: Text("저장"),
              onPressed: () {
                _showdSaveDialog(context)
                    .then((value) => (value) ? Navigator.pop(context) : null);
              }),
        ],
      ),
      body: Scrollbar(
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            children: [
              Column(
                children: <Widget>[
                  const SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 20,
                        height: 20,
                      ),
                      Container(
                        // color: Colors.grey,
                        padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                        alignment: Alignment.centerLeft,
                        width: 240,
                        height: 50,
                        child: Text(
                          '${strNick}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text(
                        '수정',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.redAccent,
                          onPressed: () {}),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                        height: 20,
                      ),
                      Container(
                        // color: Colors.yellow,
                        padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                        alignment: Alignment.centerLeft,
                        width: 240,
                        height: 50,
                        child: Text(
                          '#${strAtp}',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Future<dynamic> _showdSaveDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('입력한 정보로 변경하시겠습니까?'),
        actions: [
          ElevatedButton(
            child: const Text('확인'),
            onPressed: () {
              // NetworkSingleton().EditInfo();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return myPage();
              }));
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
