import 'package:apart_forest/pages/sign_in/sign_in_page.dart';
import 'package:apart_forest/pages/sign_up_afore/sign_up_afore_page.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff347af0),
      backgroundColor: Colors.lightGreen,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              Image.asset('assets/images/logo.png'),
              SizedBox(
                width: 20,
                height: 20,
              ),
              Text(
                '아숲',
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                '아파트 프라이빗 커뮤니티',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white70.withOpacity(0.70),
                ),
              ),
//              Spacer(),
//               SizedBox(
//                 height: 200,
//               ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                     if(false){ // 카카오톡 - 아숲 연동 완료
                    }else{
                       return SignUpAforePage(); // 카카오톡 - 아숲 회원가입
                    }
                  }));
                },
                child: Container(
                    child: Column(
                      children: <Widget>[
                    Image.asset('assets/images/kakao_login_medium_wide.png'),
                  ]),
                ),
              ),
              // MaterialButton(
              //   onPressed: () {
              //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              //       return SignInPage();
              //     }));
              //   },
              //   color: Colors.white,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(18.0),
              //     side: BorderSide(
              //       color: Color(0xff347af0),
              //     ),
              //   ),
                // child: Container(
                //   width: 160,
                //   height: 40,
                //   alignment: Alignment.center,
                //   child: Text(
                //     'Login Start',
                //     style: TextStyle(
                //       color: Color(0xff347af0),
                //     ),
                //   ),
                // ),
              //),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return SignInPage(); // 다른 이메일로 로그인
                  }));
                },
                child: Container(
                  child: Column(
                      children: <Widget>[
                      Text(
                        '다른 이메일로 시작하기',
                        style: TextStyle(
                          shadows: [

                            Shadow(
                                color: Colors.white,
                                offset: Offset(0, -5))
                          ],
                          color: Colors.transparent,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
