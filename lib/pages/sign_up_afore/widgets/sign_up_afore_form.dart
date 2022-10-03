import 'package:apart_forest/application/auth/sign_up_form/bloc/sign_up_form_bloc.dart';
import 'package:apart_forest/board/model/Apart_model.dart';
import 'package:apart_forest/board/model/network_singleton.dart';
import 'package:apart_forest/domain/core/value_validators.dart';
import 'package:apart_forest/infrastructure/auth/auth_failure_or_success.dart';
import 'package:apart_forest/pages/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apart_forest/main.dart' as main;
import 'package:fluttertoast/fluttertoast.dart';

String g_searchApt = null;
String g_setAptCode = null;
bool g_setApt = false;
TextEditingController _aptText;

void init() {
  if (g_searchApt != null) {
    g_searchApt = null;
  }
  if (_aptText != null) {
    _aptText.dispose();
  }
}

class SignUpAforeForm extends StatelessWidget {
  bool usenick;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String nickname;

    init();

    return BlocConsumer<SignUpFormBloc, SignUpFormState>(
      listener: (context, state) {
        print(state);
        if (state.authFailureOrSuccess == AuthFailureOrSuccess.success()) {
          showSnackBar(
              context,
              SnackBar(
                backgroundColor: Colors.blue,
                content: Text('Success'),
              ));
        } else if (state.authFailureOrSuccess ==
            AuthFailureOrSuccess.emailAlreadyInUse()) {
          showSnackBar(
              context,
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Email Already In Use'),
              ));
        } else if (state.authFailureOrSuccess ==
            AuthFailureOrSuccess.invalidEmailAndPassword()) {
          showSnackBar(
              context,
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Invalid Email And Password'),
              ));
        } else if (state.authFailureOrSuccess ==
            AuthFailureOrSuccess.serverError()) {
          showSnackBar(
              context,
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Server Error'),
              ));
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30,
            bottom: 50,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Form(
            // autovalidate: state.showErrorMessages,
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.account_box_rounded),
                        labelText: '닉네임',
                        hintText: '닉네임을 입력하세요.',
                        // suffixIcon: Icon(Icons.check_rounded, color: Colors.red,), //체크 아이콘 추가
                        // suffixIcon: IconButton(
                        //     padding: EdgeInsets.zero,
                        //     icon: const Icon(
                        //         Icons.info,
                        //         color: Colors.grey //change icon color according to form validation
                        //     )),

                        contentPadding: EdgeInsets.only(
                            left: 5, bottom: 5, top: 5, right: 5),
                      ),
                      autocorrect: false,
                      autofocus: false,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (value) {
                        final RegExp _regExp =
                            // RegExp(r'[\uac00-\ud7afa-zA-Z0-9]', unicode: true); // 영문 + 숫자 + 완성형 한글
                            RegExp(r'[ㄱ-ㅎ|ㅏ-ㅣ|가-힣a-zA-Z0-9]',
                                unicode: true); // 영문 + 숫자 + 한글 // 영문 + 숫자 + 한글
                        if (value.isEmpty) {
                          return '닉네임을 입력해주세요.';
                        } else if (_regExp.allMatches(value).length !=
                            value.length) {
                          return "닉네임은 한글/영문/숫자 조합만 가능합니다.";
                        } else if (value.length < 2 || value.length > 6) {
                          return "닉네임을 2~6글자 사이로 입력해주세요.";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) => nickname = value,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: _aptText = TextEditingController(),
                        maxLength: 20,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.add_business_rounded),
                          labelText: '주거 아파트',
                          hintText: '아파트명을 입력하세요.',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: _APTListviewPage(),
                                        insetPadding: const EdgeInsets.fromLTRB(
                                            0, 80, 0, 80),
                                        actions: [
                                          TextButton(
                                            child: const Text('확인'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              }
                            },
                          ), //검색 아이콘 추가
                          contentPadding: EdgeInsets.only(
                              left: 5, bottom: 5, top: 5, right: 5),
                        ),
                        autocorrect: false,
                        autofocus: false,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (value) {
                          final RegExp _regExp = RegExp(
                              r'[\uac00-\ud7afa-zA-Z0-9]',
                              unicode: true); // 영문 + 숫자 + 완성형 한글
                          if (value.isEmpty) {
                            g_searchApt = null;
                            g_setApt = false;
                            return '아파트명을 입력해주세요.';
                          } else if (_regExp.allMatches(value).length !=
                              value.length) {
                            return "아파트명은 한글/영문/숫자 조합으로 조회 가능합니다.";
                          } else if (value.length < 2 || value.length > 10) {
                            return '아파트명을 2~10글자 사이로 입력해주세요.';
                          } else {
                            g_searchApt = value;
                            return null;
                          }
                        },
                        onChanged: (value) => {
                              g_searchApt = value,
                            }),
                  ],
                ),
                Column(
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        checkNickname(nickname);
                        if (NetworkSingleton().getSetName() == true &&
                            g_setApt == true) {
                          // 닉네임 사용 가능
                          NetworkSingleton().postSetApart(g_setAptCode);
                          print('User Info set complete');

                          FocusScope.of(context).unfocus();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return WelcomePage();
                          }));
                        } else {
                          // 닉네임 사용 불가
                          FocusScope.of(context).unfocus();
                        }
                        // main.postSetApart("A13579501");
                        // FocusScope.of(context).unfocus();
                        // context
                        //     .bloc<SignUpFormBloc>()
                        //     .add(SignUpFormEvent.registerWithEmailAndPassword());
                      },
                      color: Color(0xff347af0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(
                          color: Color(0xff347af0),
                        ),
                      ),
                      child: Container(
                        width: 160,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          '가입하기',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showSnackBar(BuildContext context, Widget snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

Future<bool> checkNickname(String nickname) async {
  await NetworkSingleton().postcheckNick(nickname);
  if (NetworkSingleton().getDuplicateName()) {
    flutterToast();
    return false;
  } else {
    await NetworkSingleton().postSetNick(nickname);
    return true;
  }
}

class _APTListviewPage extends StatelessWidget {
  const _APTListviewPage({Key key}) : super(key: key);
  // void ScreenSearchAPT() async{
  //   main.postSearchApart(g_searchApt);
  //
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('검색결과'),
      ),
      body: FutureBuilder<List<Apart>>(
        future: NetworkSingleton().postSearchApart(g_searchApt),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ApartList(aparts: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ApartList extends StatelessWidget {
  final List<Apart> aparts;

  ApartList({Key key, this.aparts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 1,
      ),
      itemCount: aparts.length,
      itemBuilder: (context, index) {
        return Scaffold(
          backgroundColor: Colors.green[(index % 2) * 100],
          body: SafeArea(
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    print('onTap : ' + aparts[index].kaptName);
                    g_setAptCode = aparts[index].kaptCode;
                    g_setApt = true;
                    Navigator.of(context).pop();
                    FocusScope.of(context).unfocus();
                    _aptText.text = aparts[index].kaptName;
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 70,
                    child: Text(aparts[index].kaptName +
                        '  [' +
                        aparts[index].as1 +
                        ' ' +
                        aparts[index].as3 +
                        ']'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void flutterToast() async {
  await Fluttertoast.showToast(
      msg: "중복된 닉네임 입니다.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
