class UserInfo {
  static final UserInfo _instance = UserInfo._internal();

  factory UserInfo() {
    return _instance;
  }

  UserInfo._internal() {}

  int id;
  String nickName;
  String createAt;
  String deleteAt;
  String aptKaptCode;
  String kaptName;

  void setId(int value) {
    id = value;
  }

  int getId() {
    return id;
  }

  void setNickName(String value) {
    nickName = value;
  }

  String getNickName() {
    return nickName;
  }

  void setCreateAt(String value) {
    createAt = value;
  }

  String getCreateAt() {
    return createAt;
  }

  void setDeleteAt(String value) {
    deleteAt = value;
  }

  String getDeleteAt() {
    return deleteAt;
  }

  void setAptKaptCode(String value) {
    aptKaptCode = value;
  }

  String getAptKaptCode() {
    return aptKaptCode;
  }

  void setKaptName(String value) {
    kaptName = value;
  }

  String getKaptName() {
    return kaptName;
  }
}
