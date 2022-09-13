class article_apt {
  String aptKaptCode;
  int userId;
  String nickname;
  int category;
  String title;
  String content;
  int views;
  String likes;
  bool iLike;
  String createdAt;
  String updatedAt;

  article_apt({
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
  });

  factory article_apt.fromJson(Map<String, dynamic> json) {
    return article_apt(
      aptKaptCode: json['aptKaptCode'] as String,
      userId: json['userId'] as int,
      nickname: json['nickname'] as String,
      category: json['category'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      views: json['views'] as int,
      likes: json['likes'] as String,
      iLike: json['iLike'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
}
