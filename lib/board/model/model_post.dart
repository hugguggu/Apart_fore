class Post {
  final String title;
  final String bodyText;
  final List<String> keyword;
  final String writer;
  final int viewer;
  final List<String> comment;
  final String writeTime;
  final bool blind;
  final int visit;

  Post.fromMap(
    Map<String, dynamic> map,
  )   : title = map['title'],
        keyword = map['keyword'],
        writer = map['writer'],
        viewer = map['viewer'],
        comment = map['comment'],
        bodyText = map['bodyText'],
        writeTime = map['writeTime'],
        blind = map['blind'],
        visit = map['visit'];

  @override
  String toString() => "Post<$title:$bodyText>";
}
