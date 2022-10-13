class contentModel {
  // "contentType":"TXT","content":"hello2"
  String contentType;
  String content;

  contentModel({
    this.contentType,
    this.content,
  });
  factory contentModel.fromJson(Map<String, dynamic> json) {
    return contentModel(
      contentType: json['contentType'] as String,
      content: json['content'] as String,
    );
  }
}

class articleModel {
  int id = 0;
  String aptKaptCode = '';
  int userId = 0;
  String nickname = '';
  int category = 0;
  String title = '';
  String content = '';
  int views = 0;
  String likes = '0';
  String iLike = null;
  String createdAt = '';
  String updatedAt = '';
  List<contentModel> contents = [];

  articleModel({
    this.id,
    this.aptKaptCode,
    this.userId,
    this.nickname,
    this.category,
    this.title,
    this.content,
    this.views,
    this.likes,
    this.iLike,
    this.createdAt,
    this.updatedAt,
    this.contents,
  });

  factory articleModel.fromJson(Map<String, dynamic> json) {
    Iterable list = json['contents'];

    List<contentModel> contents;
    if (list.isNotEmpty) {
      contents =
          list.map<contentModel>((i) => contentModel.fromJson(i)).toList();
    } else {
      print('else');
    }

    return articleModel(
      id: json['id'] as int,
      aptKaptCode: json['aptKaptCode'] as String,
      userId: json['userId'] as int,
      nickname: json['nickname'] as String,
      category: json['category'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      views: json['views'] as int,
      likes: json['likes'] as String,
      iLike: json['iLike'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      contents: contents,
    );
  }
}
