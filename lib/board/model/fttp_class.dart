class NetworkSingleton {
  String accessToken;
  String refreshToken;
  String providerUserId;
  String cookie;
  bool isUser;
  bool setName;
  bool duplicateName;

  static final NetworkSingleton _instance = NetworkSingleton._internal();
  factory NetworkSingleton() {
    return _instance;
  }
  NetworkSingleton._internal() {
    print('NetworkSingleton was created.');
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
}
