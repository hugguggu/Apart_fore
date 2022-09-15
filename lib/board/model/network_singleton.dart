import 'dart:convert';

import 'package:apart_forest/board/model/Apart_model.dart';
import 'package:apart_forest/board/model/article_model.dart';
import 'package:apart_forest/board/model/user_info_singleton.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class NetworkSingleton {
  String accessToken;
  String refreshToken;
  String providerUserId;
  String cookie;
  bool isUser;
  bool setName;
  bool duplicateName;
  String aptName;

  final String serverAddress = 'http://61.77.114.199:8680';

  static final NetworkSingleton _instance = NetworkSingleton._internal();
  factory NetworkSingleton() {
    return _instance;
  }
  NetworkSingleton._internal() {
    // print('NetworkSingleton was created.');
  }

  void setAccessToken(String value) {
    accessToken = value;
  }

  String getAccessToken() {
    return accessToken;
  }

  void setRefreshToken(String value) {
    refreshToken = value;
  }

  String getRefreashToken() {
    return refreshToken;
  }

  void setProviderUserId(String value) {
    providerUserId = value;
  }

  String getpProviderUserId() {
    return providerUserId;
  }

  void setCookie(String value) {
    cookie = value;
  }

  String getCookie() {
    return cookie;
  }

  bool getIsUser() {
    return isUser;
  }

  bool getSetName() {
    return setName;
  }

  bool getDuplicateName() {
    return duplicateName;
  }

  String getAptName() {
    return aptName;
  }

  Future<http.Response> signOut() async {
    var url = Uri.parse(
      '$serverAddress/auth/signout',
    );

    var response = await http.delete(
      url,
      headers: {"Content-Type": "application/json", "Cookie": cookie},
    );

    print("${response.headers}");
    print("${response.statusCode}");
    print("${response.body}");

    return response;
  }

  Future<http.Response> signDelete() async {
    var url = Uri.parse(
      '$serverAddress/auth/delete',
    );

    var response = await http.delete(
      url,
      headers: {"Cookie": cookie},
    );

    return response;
  }

  Future<http.Response> postSetNick(String nickname) async {
    var url = Uri.parse(
      '$serverAddress/users/set-nickname',
    );

    Map data = {
      'nickname': nickname,
    };
    //encode Map to JSON
    var body = json.encode(data);

// TODO : post example
    var response = await http.post(url,
        headers: {"Content-Type": "application/json", "Cookie": cookie},
        body: body);
    print('Set nickname : ' + nickname);
    print("${response.headers}");
    print("${response.statusCode}");
    print("${response.body}");

    if (response.body == "OK") {
      setName = true;
    } else
      setName = false;

    return response;
  }

  Future<http.Response> postcheckNick(String nickname) async {
    var url = Uri.parse(
      '$serverAddress/users/check-nickname',
    );

    Map data = {
      'nickname': nickname,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json", "Cookie": cookie},
        body: body);
    print('Check nickname : ' + nickname);
    print("${response.headers}");
    print("${response.statusCode}");
    print("${response.body}");

    if (response.body == "true") {
      duplicateName = true;
    } else
      duplicateName = false;

    return response;
  }

// 로그인 요청, receive cookie
  Future<http.Response> postSignin() async {
    var url = Uri.parse(
      '$serverAddress/auth/signin/kakao',
    );

    Map data = {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'providerUserId': providerUserId,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.headers}");
    print("${response.statusCode}");
    print("${response.body}");

    String cookie = response.headers['set-cookie'];
    setCookie(cookie);

    NetworkSingleton().setAccessToken(accessToken);
    NetworkSingleton().setRefreshToken(refreshToken);
    NetworkSingleton().setProviderUserId(providerUserId);
    NetworkSingleton().setCookie(cookie);

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

  Future<http.Response> getUsers() async {
    var url = Uri.parse(
      '$serverAddress/users',
    );
    // GET
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Cookie": cookie,
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    String responseBody = utf8.decode(response.bodyBytes);
    // List<dynamic> list = jsonDecode(responseBody);
    // dynamic list = jsonDecode(responseBody);
    // print(list[0]['nickname']);

    Map<String, dynamic> json = jsonDecode(responseBody);

    print('Howdy, ${json['nickname']}!');
    String json_nick = json['nickname'];

    if (json_nick != null) {
      isUser = true;
    } else {
      isUser = false;
    }

    UserInfo().setId(json['id']);
    UserInfo().setNickName(json['nickname']);
    UserInfo().setCreateAt(json['createAt']);
    UserInfo().setDeleteAt(json['deleteAt']);
    UserInfo().setAptKaptCode(json['aptKaptCode']);
    UserInfo().setKaptName(json['kaptName']);
    return response;
  }

  Future<http.Response> postSetApart(String kaptCode) async {
    var url = Uri.parse(
      '$serverAddress/users/set-kapt-code',
    );

    Map data = {
      'kaptCode': kaptCode,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json", "Cookie": cookie},
        body: body);
    print("${response.headers}");
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<List<Apart>> postSearchApart(String search) async {
    var url = Uri.parse(
      '$serverAddress/apts/get-list',
    );

    Map data = {
      'keyword': search,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json", "Cookie": cookie},
        body: body);
    print("${response.headers}");
    print("${response.statusCode}");
    print("${response.body}");

    return parseApart(response.body);
  }

  List<Apart> parseApart(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Apart>((json) => Apart.fromJson(json)).toList();
  }

  Future<http.Response> posting(
      int category, String title, String content) async {
    var url = Uri.parse(
      '$serverAddress/article-apt',
    );

    Map data = {
      'category': category,
      'title': title,
      'content': content,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json", "Cookie": cookie},
        body: body);
    return response;
  }

  Future<List<dynamic>> getPostingList() async {
    var url = Uri.parse(
      '$serverAddress/article-apt?page=1&num=20',
    );
    var response;
    try {
      response = await http.get(
        url,
        headers: {
          "Cookie": cookie,
        },
      );
    } catch (e) {
      // print(e.error);
      return null;
    }

    String responseBody = utf8.decode(response.bodyBytes);
    List<dynamic> list = jsonDecode(responseBody);

    return _getPostingL(responseBody);
  }

  List<dynamic> _getPostingL(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<article_apt>((json) => article_apt.fromJson(json))
        .toList();
  }
}
