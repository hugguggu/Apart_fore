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
  });

  factory article_apt.fromJson(Map<String, dynamic> json) {
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
    );
  }
}
