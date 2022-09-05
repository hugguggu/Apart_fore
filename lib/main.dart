import 'dart:io';

import 'package:apart_forest/injection.dart';
import 'package:apart_forest/pages/sign_in/sign_in_page.dart';
import 'package:apart_forest/pages/sign_up_afore/sign_up_afore_page.dart';
import 'package:apart_forest/pages/start/start_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
  Firebase.initializeApp().whenComplete(() {

  });
  KakaoSdk.init(nativeAppKey: 'beab66ed5facd342394656e8af2684f6');
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Apart Private community',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: StartPage(),
    );
  }
}


String g_accessToken;
String g_refreshToken;
String g_providerUserId;
String g_cookie;
bool g_isUser;
bool g_setName;
bool g_duplicateName;

String getCookie(){
  return g_cookie;
}

void setCookie(String strCookie) {
  g_cookie = strCookie;
  print('쿠키 설정 완료 SetCookie ');
  print('g_cookie : ${g_cookie}');
}


Future<http.Response> signOut() async {
  var url = Uri.parse(
    'http://61.77.114.199:8680/auth/signout',
  );

  var response = await http.delete(url,
      headers: {"Content-Type": "application/json", "Cookie": g_cookie},
  );

  print("${response.headers}");
  print("${response.statusCode}");
  print("${response.body}");

  return response;
}

Future<http.Response> getUsers() async {
  var url = Uri.parse(
    'http://61.77.114.199:8680/users',
  );
  // GET
  var response = await http.get(url,
      headers: {"Content-Type": "application/json", "Cookie": g_cookie.toString(),},
  );
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  // int strNickname = response.body['nickname'] as int;
  //
  //
  // if(response.body['nickname'] != null){
  //   g_isUser = true;
  // }else g_isUser = false;

  return response;
}

Future<http.Response> postSetApart(String kaptCode) async {
  var url = Uri.parse(
    'http://61.77.114.199:8680/users/set-kapt-code',
  );

  Map data = {
    'kaptCode': kaptCode,
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(url,
      headers: {"Content-Type": "application/json", "Cookie": g_cookie},
      body: body
  );
  print("${response.headers}");
  print("${response.statusCode}");
  print("${response.body}");
  return response;
}

//
// Future<http.Response> postSearchApart(String search) async {
//   var url = Uri.parse(
//     'http://61.77.114.199:8680/apts/get-list',
//   );
//
//   Map data = {
//     'keyword': search,
//   };
//   //encode Map to JSON
//   var body = json.encode(data);
//
//   var response = await http.post(url,
//       headers: {"Content-Type": "application/json", "Cookie": g_cookie},
//       body: body
//   );
//   print("${response.headers}");
//   print("${response.statusCode}");
//   print("${response.body}");
//   return response;
// }

Future<List<Apart>> postSearchApart(String search) async {
  var url = Uri.parse(
    'http://61.77.114.199:8680/apts/get-list',
  );

  Map data = {
    'keyword': search,
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(url,
      headers: {"Content-Type": "application/json", "Cookie": g_cookie},
      body: body
  );
  print("${response.headers}");
  print("${response.statusCode}");
  print("${response.body}");

  return parseApart(response.body);
}

List<Apart> parseApart(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Apart>((json) => Apart.fromJson(json)).toList();
}

class Apart {
  final String kaptCode;
  final String kaptName;
  final String bjdCode;
  final String as1;
  final String as2;
  final String as3;

  Apart({this.kaptCode, this.kaptName, this.bjdCode, this.as1, this.as2, this.as3});

  factory Apart.fromJson(Map<String, dynamic> json) {
    return Apart(
      kaptCode: json['kaptCode'] as String,
      kaptName: json['kaptName'] as String,
      bjdCode: json['bjdCode'] as String,
      as1: json['as1'] as String,
      as2: json['as2'] as String,
      as3: json['as3'] as String,
    );
  }
}

Future<http.Response> postSetNick(String nickname) async {
  var url = Uri.parse(
    'http://61.77.114.199:8680/users/set-nickname',
  );

  Map data = {
    'nickname': nickname,
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(url,
      headers: {"Content-Type": "application/json", "Cookie": g_cookie},
      body: body
  );
  print('Set nickname : '+ nickname);
  print("${response.headers}");
  print("${response.statusCode}");
  print("${response.body}");

  if(response.body == "OK"){
    g_setName = true;
  }else g_setName = false;

  return response;
}

Future<http.Response> postcheckNick(String nickname) async {
  var url = Uri.parse(
    'http://61.77.114.199:8680/users/check-nickname',
  );

  Map data = {
    'nickname': nickname,
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(url,
      headers: {"Content-Type": "application/json", "Cookie": g_cookie},
      body: body
  );
  print('Check nickname : '+ nickname);
  print("${response.headers}");
  print("${response.statusCode}");
  print("${response.body}");

  if(response.body == "true"){
    g_duplicateName = true;
  }else g_duplicateName = false;

  return response;
}

// 로그인 요청, receive cookie
Future<http.Response> postSignin() async {
  var url = Uri.parse(
    'http://61.77.114.199:8680/auth/signin/kakao',
  );

  Map data = {
    'accessToken': g_accessToken,
    'refreshToken': g_refreshToken,
    'providerUserId': g_providerUserId,
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );
  print("${response.headers}");
  print("${response.statusCode}");
  print("${response.body}");

  String cookie = response.headers['set-cookie'];
  setCookie(cookie);
  return response;
}

Future<AccessTokenInfo> get_user_access_token() async {
  try {
    AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
    print('토큰 정보 보기 성공 : '
        '\n: ${tokenInfo}');
    return tokenInfo;
  } catch (error) {
    print('토큰 정보 보기 실패 $error');
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
                onTap: () async{
                  void checkKakao() async{
                    if (await isKakaoTalkInstalled()) {
                      try {
                        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
                        isKakaoLogin = true;
                        print('카카오톡으로 로그인 성공');
                        print('accessToken : ');
                        print(token.accessToken);
                        g_accessToken = token.accessToken;
                        print('refreshToken : ');
                        print(token.refreshToken);
                        g_refreshToken = token.refreshToken;

                        User user = await UserApi.instance.me();
                        g_providerUserId = user.id.toString();
                        print('providerUserId : ');
                        print(g_providerUserId);

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
                          g_accessToken = token.accessToken;
                          print('refreshToken : ');
                          print(token.refreshToken);
                          g_refreshToken = token.refreshToken;

                          User user = await UserApi.instance.me();
                          g_providerUserId = user.id.toString();
                          print('providerUserId : ');
                          print(g_providerUserId);
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
                        g_accessToken = token.accessToken;
                        print('refreshToken : ');
                        print(token.refreshToken);
                        g_refreshToken = token.refreshToken;

                        User user = await UserApi.instance.me();
                        g_providerUserId = user.id.toString();
                        print('providerUserId : ');
                        print(g_providerUserId);
                        isKakaoLogin = true;
                      } catch (error) {
                        print('카카오계정으로 로그인 실패 $error');
                        isKakaoLogin = false;
                      }
                    }
                  }
                  await checkKakao();

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    if(isKakaoLogin){ // 카카오톡 - 아숲 연동 완료
                      postSignin();
                      getUsers();
                      // if(getUsers()){
                      //
                      // }else{
                      //
                      // }
                      return SignUpAforePage(); // 카카오톡 - 아숲 회원가입
                    }else{
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
              SizedBox(
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
}

