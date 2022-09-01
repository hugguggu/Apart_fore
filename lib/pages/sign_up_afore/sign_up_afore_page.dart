import 'package:apart_forest/application/auth/sign_up_form/bloc/sign_up_form_bloc.dart';
import 'package:apart_forest/injection.dart';
import 'package:apart_forest/pages/sign_up/widgets/sign_up_form.dart';
import 'package:apart_forest/pages/sign_up_afore/widgets/sign_up_afore_form.dart';
import 'package:apart_forest/pages/start/start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpAforePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffe0e9f8),
        title: Text(
          '아숲 회원가입',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // 뒤로가기 아이콘 생성
          onPressed: () {
            Navigator.pop(context);
            // 아이콘 버튼 실행
            // Navigator.push(context, MaterialPageRoute(builder: (context) => StartPage()))
            // .then((value) {
            //   setState((){});
            // });
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            //   return StartPage();
            // }));
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Color(0xffe0e9f8),
          child: CustomScrollView(
            reverse: true,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/logo.png'),
                    Expanded(
                      child: BlocProvider(
                        create: (_) => getIt<SignUpFormBloc>(),
                        child: SignUpAforeForm(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
