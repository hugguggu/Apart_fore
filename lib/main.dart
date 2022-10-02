import 'dart:io';

import 'package:apart_forest/board/model/network_singleton.dart';
import 'package:apart_forest/board/screen/main_screen.dart';
import 'package:apart_forest/injection.dart';
import 'package:apart_forest/pages/sign_in/sign_in_page.dart';
import 'package:apart_forest/pages/sign_up_afore/sign_up_afore_page.dart';
import 'package:apart_forest/pages/start/start_page.dart';
import 'package:apart_forest/pages/welcome/welcome_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:get/get.dart';

// 1. 액세스토큰 리플레시토큰 유저아이디 넘겨주기 << http 통신으로
// 2. 중복확인 버튼을 누르면 닉네임 넘겨주기
// 3. 아파트명 입력할때마다 넘겨주기
// 4. 이메일 말고 둘러보기처럼 게스트로
// http://61.77.114.199:8680/
// POST : http://61.77.114.199:8680/auth/signin/kakao
// accessToken / refreshToken / providerUserId << json 형태로

// 카카오톡 연동 -> 닉네임 여부 -> 닉네임 등록안되있으면 회원가입 절차 진행, 아니면 메인페이지(게시판)
// 닉네임 유효성검사 필요, 최수 2자, 공백 안되고 특수문자안되고
// 중복하기 일단 빼고 가입하기하면 내부적으로 확인되게
// 테스트

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final locale = WidgetsBinding.instance.window.locales[0];
  // await Messages.delegate.load(locale);
  Firebase.initializeApp().whenComplete(() {});
  KakaoSdk.init(nativeAppKey: 'beab66ed5facd342394656e8af2684f6');
  HttpOverrides.global =
      NoCheckCertificateHttpOverrides(); // 생성된 HttpOverrides 객체 등록
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apart Private community',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  bool isKakaoLogin = false;

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
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  _kakaoLogin(context);
                },
                child: Container(
                  child: Column(children: <Widget>[
                    Image.asset('assets/images/kakao_login_medium_wide.png'),
                  ]),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              /*
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    get_user_access_token();
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
              */
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _kakaoLogin(BuildContext context) async {
    await checkKakao();

    if (isKakaoLogin) {
      // await signDel();
      await NetworkSingleton().postSignin();
      await NetworkSingleton().getUsers();
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      if (isKakaoLogin) {
        // 카카오톡 - 아숲 연동 완료
        if (NetworkSingleton().getIsUser()) {
          if (NetworkSingleton().getFirstLogin()) {
            return WelcomePage(); // 웰컴페이지
          } else {
            return MainScreen();
          }
        } else {
          return SignUpAforePage(); // 카카오톡 - 아숲 회원가입
        }
      }
    }));
  }

  Future<void> logoutKakao() async {
    if (await isKakaoTalkInstalled()) {
      try {
        UserIdResponse token = await UserApi.instance.logout();
        isKakaoLogin = false;
        print('카카오톡으로 로그아웃');
      } catch (error) {
        print('카카오톡으로 로그아웃 실패 $error');
        isKakaoLogin = true;
      }
    } else {
      try {
        UserIdResponse token = await UserApi.instance.logout();
        print('카카오계정으로 로그아웃');
        isKakaoLogin = false;
      } catch (error) {
        print('카카오계정으로 로그아웃 실패 $error');
        isKakaoLogin = true;
      }
    }
  }

  Future<void> checkKakao() async {
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        isKakaoLogin = true;
        print('카카오톡으로 로그인 성공');
        print('accessToken : ');
        print(token.accessToken);
        // g_accessToken = token.accessToken;
        NetworkSingleton().setAccessToken(token.accessToken);
        print('refreshToken : ');
        print(token.refreshToken);
        // g_refreshToken = token.refreshToken;
        NetworkSingleton().setRefreshToken(token.refreshToken);

        User user = await UserApi.instance.me();
        // g_providerUserId = user.id.toString();
        NetworkSingleton().setProviderUserId(user.id.toString());
        print('providerUserId : ');
        print(NetworkSingleton().getpProviderUserId());
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');
        isKakaoLogin = false;
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          isKakaoLogin = true;
          print('카카오계정으로 로그인 성공');
          print('accessToken : ');
          print(token.accessToken);
          // g_accessToken = token.accessToken;
          NetworkSingleton().setAccessToken(token.accessToken);
          print('refreshToken : ');
          print(token.refreshToken);
          NetworkSingleton().setRefreshToken(token.refreshToken);

          User user = await UserApi.instance.me();
          NetworkSingleton().setProviderUserId(user.id.toString());
          print('providerUserId : ');
          print(NetworkSingleton().getpProviderUserId());
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
          isKakaoLogin = false;
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
        print('accessToken : ');
        print(token.accessToken);
        NetworkSingleton().setAccessToken(token.accessToken);
        print('refreshToken : ');
        print(token.refreshToken);
        NetworkSingleton().setRefreshToken(token.refreshToken);

        User user = await UserApi.instance.me();
        NetworkSingleton().setProviderUserId(user.id.toString());
        print('providerUserId : ');
        print(NetworkSingleton().getpProviderUserId());
        isKakaoLogin = true;
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
        isKakaoLogin = false;
      }
    }
  }
}
