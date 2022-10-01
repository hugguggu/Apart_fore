import 'dart:convert';
import 'dart:io';
import 'package:apart_forest/board/model/Apart_model.dart';
import 'package:apart_forest/board/model/article_model.dart';
import 'package:apart_forest/board/model/user_info_singleton.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class NetworkSingleton extends HttpOverrides {
  String _accessToken;
  String _refreshToken;
  String _providerUserId;
  String _cookie;
  bool _isUser;
  bool _setName;
  bool _duplicateName;
  String _aptName;

  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }

  // final String _serverAddress = 'http://61.77.114.199:8680';
  final String _serverAddress = 'https://test.melius0.shop';
  // final String _serverAddress = 'http://test.melius0.shop:8680';

  static final NetworkSingleton _instance = NetworkSingleton._internal();
  factory NetworkSingleton() {
    return _instance;
  }
  NetworkSingleton._internal() {
    // print('NetworkSingleton was created.');
  }

  void setAccessToken(String value) {
    _accessToken = value;
  }

  String getAccessToken() {
    return _accessToken;
  }

  void setRefreshToken(String value) {
    _refreshToken = value;
  }

  String getRefreashToken() {
    return _refreshToken;
  }

  void setProviderUserId(String value) {
    _providerUserId = value;
  }

  String getpProviderUserId() {
    return _providerUserId;
  }

  void setCookie(String value) {
    _cookie = value;
  }

  String getCookie() {
    return _cookie;
  }

  bool getIsUser() {
    return _isUser;
  }

  bool getSetName() {
    return _setName;
  }

  bool getDuplicateName() {
    return _duplicateName;
  }

  String getAptName() {
    return _aptName;
  }

  Future<http.Response> signOut() async {
    var url = Uri.parse(
      '$_serverAddress/auth/signout',
    );

    var response = await http.delete(
      url,
      headers: {"Content-Type": "application/json", "Cookie": _cookie},
    );

    print("${response.headers}");
    print("${response.statusCode}");
    print("${response.body}");

    return response;
  }

  Future<http.Response> signDelete() async {
    var url = Uri.parse(
      '$_serverAddress/auth/delete',
    );

    var response = await http.delete(
      url,
      headers: {"Cookie": _cookie},
    );

    return response;
  }

  Future<http.Response> postSetNick(String nickname) async {
    var url = Uri.parse(
      '$_serverAddress/users/set-nickname',
    );

    Map data = {
      'nickname': nickname,
    };
    //encode Map to JSON
    var body = json.encode(data);

// TODO : post example
    var response = await http.post(url,
        headers: {"Content-Type": "application/json", "Cookie": _cookie},
        body: body);
    print('Set nickname : ' + nickname);
    print("${response.headers}");
    print("${response.statusCode}");
    print("${response.body}");

    if (response.body == "OK") {
      _setName = true;
    } else {
      _setName = false;
    }

    return response;
  }

  Future<http.Response> postcheckNick(String nickname) async {
    var url = Uri.parse(
      '$_serverAddress/users/check-nickname',
    );

    Map data = {
      'nickname': nickname,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json", "Cookie": _cookie},
        body: body);
    print('Check nickname : ' + nickname);
    print("${response.headers}");
    print("${response.statusCode}");
    print("${response.body}");

    if (response.body == "true") {
      _duplicateName = true;
    } else {
      _duplicateName = false;
    }

    return response;
  }

// 로그인 요청, receive cookie
  Future<http.Response> postSignin() async {
    var url = Uri.parse(
      '$_serverAddress/auth/signin/kakao',
    );

    Map data = {
      'accessToken': _accessToken,
      'refreshToken': _refreshToken,
      'providerUserId': _providerUserId,
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

    NetworkSingleton().setAccessToken(_accessToken);
    NetworkSingleton().setRefreshToken(_refreshToken);
    NetworkSingleton().setProviderUserId(_providerUserId);
    NetworkSingleton().setCookie(cookie);

    return response;
  }

  Future<http.Response> getSession() async {
    var url = Uri.parse(
      '$_serverAddress/auth/session',
    );
    http.Response response;
    try {
      response = await http.get(
        url,
        headers: {
          "Cookie": _cookie,
        },
      );
    } catch (e) {
      // print(e.error);
      return null;
    }

    print("***  Headers ****" + "${response.headers}");
    print("***  statusCode ****" + "${response.statusCode}");
    print("***  body ****" + "${response.body}");

    String responseBody = utf8.decode(response.bodyBytes);
    // Map<String, dynamic> data = json.decode(response.body);
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
      '$_serverAddress/users',
    );
    // GET
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Cookie": _cookie,
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
      _isUser = true;
    } else {
      _isUser = false;
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
      '$_serverAddress/users/set-kapt-code',
    );

    Map data = {
      'kaptCode': kaptCode,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json", "Cookie": _cookie},
        body: body);
    print("${response.headers}");
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<List<Apart>> postSearchApart(String search) async {
    var url = Uri.parse(
      '$_serverAddress/apts/search',
    );

    Map data = {
      'keyword': search,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json", "Cookie": _cookie},
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
      '$_serverAddress/article-apt',
    );

    Map data = {
      'category': category,
      'title': title,
      'content': content,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json", "Cookie": _cookie},
        body: body);
    return response;
  }

  Future<List<dynamic>> getPostingList(int itemNumPerPage, int page) async {
    var url = Uri.parse(
      '$_serverAddress/article-apt?page=$page&num=$itemNumPerPage',
    );
    var response;
    try {
      response = await http.get(
        url,
        headers: {
          "Cookie": _cookie,
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

  // Future<Map<String, dynamic>> getArticleDetail(int id) async {
  Future<article_apt> getArticleDetail(int id) async {
    var url = Uri.parse(
      // '$_serverAddress/article-apt/$id',
      '$_serverAddress/article-apt/$id',
    );
    http.Response response;
    try {
      response = await http.get(
        url,
        headers: {
          "Cookie": _cookie,
        },
      );
    } catch (e) {
      // print(e.error);
      return null;
    }
    // String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> data = json.decode(response.body);
    return article_apt.fromJson(data);
  }

  Future<http.Response> checkLike(int articleID) async {
    var url = Uri.parse(
      '$_serverAddress/article-apt/like/$articleID',
    );

    var response = await http.post(url, headers: {"Cookie": _cookie});
    return response;
  }

  Future<http.Response> deleteLike(int articleID) async {
    var url = Uri.parse(
      '$_serverAddress/article-apt/like/$articleID',
    );

    var response = await http.delete(
      url,
      headers: {"Cookie": _cookie},
    );

    return response;
  }

  Future<http.Response> addViewNumber(int articleID) async {
    var url = Uri.parse(
      '$_serverAddress/article-apt/views/$articleID',
    );

    var response;
    try {
      response = await http.put(
        url,
        headers: {
          "Cookie": _cookie,
        },
      );
    } catch (e) {
      // print(e.error);
      return null;
    }

    return response;
  }
}

class NoCheckCertificateHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
