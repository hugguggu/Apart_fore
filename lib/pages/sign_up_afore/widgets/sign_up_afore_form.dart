import 'package:apart_forest/application/auth/sign_up_form/bloc/sign_up_form_bloc.dart';
import 'package:apart_forest/domain/core/value_validators.dart';
import 'package:apart_forest/infrastructure/auth/auth_failure_or_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apart_forest/main.dart' as main;
import 'package:fluttertoast/fluttertoast.dart';

class SignUpAforeForm extends StatelessWidget {

  bool usenick;

  @override
  Widget build(BuildContext context) {
    String nickname;
    String searchApt;
    return BlocConsumer<SignUpFormBloc, SignUpFormState> (
      listener: (context, state) {
        print(state);
        if (state.authFailureOrSuccess == AuthFailureOrSuccess.success()) {
          showSnackBar(context, SnackBar(
            backgroundColor: Colors.blue,
            content: Text('Success'),
          ));
        } else if (state.authFailureOrSuccess == AuthFailureOrSuccess.emailAlreadyInUse()) {
          showSnackBar(context, SnackBar(
            backgroundColor: Colors.red,
            content: Text('Email Already In Use'),
          ));
        } else if (state.authFailureOrSuccess == AuthFailureOrSuccess.invalidEmailAndPassword()) {
          showSnackBar(context, SnackBar(
            backgroundColor: Colors.red,
            content: Text('Invalid Email And Password'),
          ));
        } else if (state.authFailureOrSuccess == AuthFailureOrSuccess.serverError()) {
          showSnackBar(context, SnackBar(
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

                        contentPadding: EdgeInsets.only(left: 5, bottom: 5, top: 5, right: 5),
                      ),
                      autocorrect: false,
                      autofocus: false,

                      onChanged: (value) => nickname = value,
                      // onChanged: (value) {
                      //   nickname = value.toString();
                      // },
                      // 닉네임 확인 절차 필요(아래 이메일 체크 예시)
                      // onChanged: (value) => context
                      //     .bloc<SignUpFormBloc>()
                      //     .add(SignUpFormEvent.emailChange(value)),
                      // validator: (_) => validateEmailAddress(
                      //     context.bloc<SignUpFormBloc>().state.emailAddress)
                      //     ? null
                      //     : "Invalid Email",
                    ),
                    MaterialButton (
                        onPressed: (){
                          checkNickname(nickname);
                          // main.getUsers();
                          FocusScope.of(context).unfocus();
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
                            '중복확인',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.add_business_rounded),
                        labelText: '주거 아파트',
                        hintText: '아파트명을 입력하세요.',
                        suffixIcon: IconButton (
                          icon: Icon(Icons.search),
                          onPressed: () {
                            // main.postSearchApart(searchApt);
                          },
                        ), //검색 아이콘 추가
                        contentPadding: EdgeInsets.only(left: 5, bottom: 5, top: 5, right: 5),
                      ),
                      autocorrect: false,
                      autofocus: false,
                      onChanged: (value) => {
                        searchApt = value,
                        main.postSearchApart(searchApt),
                      }
                      // onChanged: (value) {
                      //   searchApt = value.toString();
                      // },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        main.postSearchApart(searchApt);
                        // main.postSetApart("A13579501");
                        FocusScope.of(context).unfocus();
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
    Scaffold.of(context).showSnackBar(snackBar);
  }
}

void checkNickname(String nickname) async{
  await main.postcheckNick(nickname);
  if(main.g_duplicateName){
    await flutterToast();
  }else{
    await main.postSetNick(nickname);
  }
}

void flutterToast() async{
  await Fluttertoast.showToast(
      msg: "중복된 닉네임 입니다.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}