import 'package:apart_forest/board/model/network_singleton.dart';
import 'package:apart_forest/board/model/user_info_singleton.dart';
import 'package:flutter/material.dart';

class editinfo extends StatefulWidget {
  @override
  State<editinfo> createState() => _editinfoState();
}

class _editinfoState extends State<editinfo> {
  String strNick = UserInfo().getNickName();
  String strAtp = UserInfo().getKaptName();
  String srtEditNick;

  Color errorClr = Colors.blueAccent;
  String errStr = '변경할 닉네임을 입력하세요';
  final nickNameTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nickNameTextController.text = strNick;
    nickNameTextController.addListener(_checkNickname);
  }

  @override
  void dispose() {
    nickNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              label: const Text("저장"),
              onPressed: () async {
                if(errorClr == Colors.red){
                  return;
                }
                _showdSaveDialog(context, srtEditNick)
                    .then((value) => (value) ? Navigator.pop(context) : null);
              }),
        ],
      ),
      body: Scrollbar(
          child: ListView(
        children: [
          Column(
            children: <Widget>[
              const SizedBox(
                width: 20,
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 4, 10, 4),
                alignment: Alignment.topLeft,
                child: Text("닉네임 (5회 남음)",
                    style: TextStyle(fontSize: 15, color: Colors.grey)),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: TextFormField(
                  controller: nickNameTextController,
                  // initialValue: '${strNick}',
                  autocorrect: false,
                  autofocus: false,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    srtEditNick = value;
                    print(" srtEditNick = " + srtEditNick);
                    return errStr;
                  },
                  // onChanged: (value) {
                  //   print("닉네임은 한글/영문/숫자 조합만 가능합니다. onstate");
                  //   _checkNickname();
                  //   setState(() {});
                  // },
                  onSaved: (value) {
                    print("닉네임은 한글/영문/숫자 조합만 가능합니다. onstate");
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: errorClr),
                    hintText: "닉네임을 입력해주세요.",
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(20.0),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 4, 10, 4),
                alignment: Alignment.topLeft,
                child: Text("아파트명 (3회 남음)",
                    style: TextStyle(fontSize: 15, color: Colors.grey)),
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

  Future<dynamic> _showdSaveDialog(BuildContext context, String str) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('입력한 정보로 변경하시겠습니까?'),
        actions: [
          ElevatedButton(
            child: const Text('확인'),
            onPressed: () {
              if (errorClr == Colors.blueAccent) {
                NetworkSingleton().postSetNick(str);
                Navigator.pop(context, true);
                print("닉네임 변경 완료 : " + str);
              } else {
                Navigator.pop(context, false);
                print("닉네임 변경 실패");
              }
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

  Future<void> _checkNickname() {
    // print("Second text field: ${nickNameTextController.text}");
    String value = '${nickNameTextController.text}';
    RegExp _regExp =
        // RegExp(r'[\uac00-\ud7afa-zA-Z0-9]', unicode: true); // 영문 + 숫자 + 완성형 한글
        RegExp(r'[ㄱ-ㅎ|ㅏ-ㅣ|가-힣a-zA-Z0-9]',
            unicode: false); // 영문 + 숫자 + 한글 // 영문 + 숫자 + 한글

    checkNickname(value);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (value.isEmpty) {
        errorClr = Colors.red;
        errStr = '닉네임을 입력해주세요.';
      } else if (_regExp.allMatches(value).length != value.length) {
        errorClr = Colors.red;
        print("닉네임은 한글/영문/숫자 조합만 가능합니다.");
        errStr = "닉네임은 한글/영문/숫자 조합만 가능합니다.";
      } else if (value.length < 2 || value.length > 6) {
        errorClr = Colors.red;
        errStr = "닉네임을 2~6글자 사이로 입력해주세요.";
      } else if (NetworkSingleton().getDuplicateName() == true) {
        errorClr = Colors.red;
        errStr = "중복된 닉네임입니다.";
      } else {
        errorClr = Colors.blueAccent;
        errStr = "사용 가능한 닉네임입니다.";
      }
      setState(() {});
    });

  }

  Future<bool> checkNickname(String nickname) async {
    await NetworkSingleton().postcheckNick(nickname);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (NetworkSingleton().getDuplicateName()) {
        return false;
      } else {
        return true;
      }
    });
  }
}
