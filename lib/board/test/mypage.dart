import 'package:apart_forest/board/model/network_singleton.dart';
import 'package:apart_forest/board/model/user_info_singleton.dart';
import 'package:flutter/material.dart';

class myPage extends StatelessWidget {

  String strNick = UserInfo().getNickName();
  String strAtp = UserInfo().getKaptName();

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
          '마이페이지',
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                NetworkSingleton().signOut();
              }),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(
              width: 35,
              height: 35,
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
            const SizedBox(
              width: 20,
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 35,
                  height: 20,
                ),
                Container(
                  // color: Colors.yellow,
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  alignment: Alignment.center,
                  width: 70,
                  height: 50,
                  child: const Text(
                    '포인트',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  alignment: Alignment.centerLeft,
                  width: 70,
                  height: 50,
                  child: const Text(
                    '아이템',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 35,
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  alignment: Alignment.center,
                  width: 70,
                  height: 50,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      print('******* tap point ******* ');
                    },
                    child: const Text('0'),
                  ),
                ),
                const SizedBox(
                  width: 30,
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  alignment: Alignment.center,
                  width: 70,
                  height: 50,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      print('******* tap item ******* ');
                    },
                    child: const Text('0'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
              height: 20,
            ),

            /// *** 여기부터 범위 터치 해야됨
            InkWell(
              onTap: () {
                
              },
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 1.0,
                      width: double.maxFinite,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(
                      width: 5,
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 2, 5, 2),
                          child: const Text(
                            '내가 작성한 글',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const IconButton(
                          icon: Icon(Icons.navigate_next),
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                      height: 5,
                    ),
                    Container(
                      height: 1.0,
                      width: double.maxFinite,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
            ),

            InkWell(
              onTap: () {

              },
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(
                      width: 5,
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 2, 5, 2),
                          child: const Text(
                            '좋아요 한 글',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const IconButton(
                          icon: Icon(Icons.navigate_next),
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                      height: 5,
                    ),
                    Container(
                      height: 1.0,
                      width: double.maxFinite,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
            ),

            InkWell(
              onTap: () {

              },
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(
                      width: 5,
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 2, 5, 2),
                          child: const Text(
                            '설정',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const IconButton(
                          icon: Icon(Icons.navigate_next),
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                      height: 5,
                    ),
                    Container(
                      height: 1.0,
                      width: double.maxFinite,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
            ),

            InkWell(
              onTap: () {

              },
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(
                      width: 5,
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 2, 5, 2),
                          child: const Text(
                            '공지사항',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const IconButton(
                          icon: Icon(Icons.navigate_next),
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                      height: 5,
                    ),
                    Container(
                      height: 1.0,
                      width: double.maxFinite,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
            ),

            InkWell(
              onTap: () {

              },
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(
                      width: 5,
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 2, 5, 2),
                          child: const Text(
                            '자주 묻는 질문',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const IconButton(
                          icon: Icon(Icons.navigate_next),
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                      height: 5,
                    ),
                    Container(
                      height: 1.0,
                      width: double.maxFinite,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
