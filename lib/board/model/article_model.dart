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

class article_apt {
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

  article_apt({
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

  factory article_apt.fromJson(Map<String, dynamic> json) {
    Iterable list = json['contents'];

    List<contentModel> contents;
    if (list.isNotEmpty) {
      contents =
          list.map<contentModel>((i) => contentModel.fromJson(i)).toList();
    } else {
      print('else');
    }

    return article_apt(
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


// "{"id":53,"aptKaptCode":"T00000001","userId":9,"nickname":"rafahel","category":1,"title":"ytryrtyrt","content":null,"views":55,"likes":"1","iLike":null,"createdAt":"2022-10-02T07:17:22.000Z","updatedAt":"2022-10-02T07:17:22.000Z","contents":[{"contentType":"TXT","content":"hello1"},{"contentType":"TXT","content":"hello2"}]}"