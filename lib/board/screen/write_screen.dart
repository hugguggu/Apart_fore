import 'package:apart_forest/board/model/Upload_Contents_model.dart';
import 'package:apart_forest/board/model/article_model.dart';
import 'package:apart_forest/board/model/network_singleton.dart';
import 'package:apart_forest/board/model/post_item_singlton.dart';
import 'package:apart_forest/board/widget/write_img_carousel.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';
import 'package:image_picker/image_picker.dart';

class WriteScreen extends StatefulWidget {
  final int category_modify;
  final String title_modify;
  final String content_modify;

  const WriteScreen(
      {Key key, this.category_modify, this.title_modify, this.content_modify})
      : super(key: key);

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  int selectedDropdown = 0;
  final titleTextFieldController = TextEditingController();
  final contentTextFieldController = TextEditingController();

  PickedFile _picker;
  List<PickedFile> _imagePath = [];

  @override
  Widget build(BuildContext context) {
    if (widget.category_modify != null &&
        widget.title_modify != null &&
        widget.content_modify != null) {
      selectedDropdown = widget.category_modify;
      titleTextFieldController.text = widget.title_modify;
      contentTextFieldController.text = widget.content_modify;
    }
    return Scaffold(
      appBar: AppBar(
        // iconTheme: Icons.,
        title: const Text('새 글쓰기'),
        leading: IconButton(
          onPressed: () {
            if (selectedDropdown == 0 &&
                titleTextFieldController.text.isEmpty &&
                contentTextFieldController.text.isEmpty) {
              Navigator.pop(context);
            } else {
              _showdBackDialog(context)
                  .then((value) => (value) ? Navigator.pop(context) : null);
            }
          },
          icon: const Icon(Icons.backspace),
        ),
        actions: <Widget>[
          MaterialButton(
            // textColor: Colors.white,
            onPressed: () {
              if (selectedDropdown == 0) {
                _showdTextFieldDialog(context, 0);
              } else if (titleTextFieldController.text.isEmpty) {
                _showdTextFieldDialog(context, 1);
              } else if (contentTextFieldController.text.isEmpty) {
                _showdTextFieldDialog(context, 2);
              } else {
                _showdSaveDialog(context)
                    .then((value) => (value) ? Navigator.pop(context) : null);
              }
            },
            child: const Text(
              "저장",
              style: TextStyle(fontSize: 16, color: Colors.redAccent),
            ),
            // shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              DropdownButton(
                value: PostItem().getCategoryList()[selectedDropdown],
                items: PostItem().getCategoryList().map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (dynamic value) {
                  setState(() {
                    // selectedDropdown = value;
                    selectedDropdown =
                        PostItem().getCategoryList().indexOf(value);
                  });
                },
              ),
            ],
          ),
          Container(
            height: 1.0,
            width: double.maxFinite,
            color: Colors.blueAccent,
          ),
          TextField(
            decoration: const InputDecoration(labelText: '제목을 입력하세요'),
            controller: titleTextFieldController,
            maxLines: 1,
          ),
          Expanded(
            child: TextField(
              controller: contentTextFieldController,
              decoration: const InputDecoration(labelText: '내용을 입력하세요'),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              expands: true, // <-- SEE HERE
            ),
          ),
          Container(
            height: 1.0,
            width: double.maxFinite,
            color: Colors.blue[100],
          ),
          //  이미지 슬라이드 영역
          if (_picker != null)
            WriteScreenImageCarousel(
              listImagePath: _imagePath,
            ),
          Container(
            height: 1.0,
            width: double.maxFinite,
            color: Colors.blue[100],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add your onPressed code here!
          _getImgFromGallery();
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.image),
      ),
    );
  }

  Future<dynamic> _showdSaveDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        // title: Text('글쓰기'),
        content: const Text('작성한 글을 게시하겠습니까?'),
        actions: [
          ElevatedButton(
            child: const Text('확인'),
            onPressed: () {
              // var formData = FormData.fromMap({'image': await MultipartFile.fromFile(sendData)});

              // Future<String> res = NetworkSingleton().imgUpload(_imagePath[0]);
              List<Content> contestList = [];
              UploadContentsModel send_format = UploadContentsModel(
                  category: selectedDropdown,
                  title: titleTextFieldController.text,
                  contents: contestList);
              // send_format.contents = contestList;

              Content contents = Content(
                  contentType: 'TXT', content: contentTextFieldController.text);
              send_format.contents.add(contents);

              if (_imagePath.isEmpty) {
                NetworkSingleton().posting2(send_format);
                PostItem().addLoadPostItem();
                Navigator.pop(context, true);
              }
              _imagePath.forEach((element) {
                Future<String> res = NetworkSingleton().imgUpload(element);
                res.then((val) {
                  Content contents = Content(contentType: 'IMG', content: val);
                  send_format.contents.add(contents);
                  print(send_format.toJson() as Map);
                }).catchError((error) {
                  print('error: $error');
                });
              });

              // NetworkSingleton().posting2(
              //     // NetworkSingleton().posting(
              //     selectedDropdown,
              //     titleTextFieldController.text,
              //     contentTextFieldController.text,
              //     null);
            },
          ),
          ElevatedButton(
            child: const Text('취소'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showdTextFieldDialog(BuildContext context, int code) {
    String txt;
    if (code == 0) {
      txt = '카테고리를 지정해 주세요';
    } else if (code == 1) {
      txt = '글의 제목을 작성해 주세요';
    } else if (code == 2) {
      txt = '글의 내용을 작성해 주세요';
    } else {
      txt = '알수없는 오류';
    }
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(txt),
        actions: [
          ElevatedButton(
            child: const Text('확인'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showdBackDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('작성중이던 내용이 있습니다.\n취소하시겠습니까?'),
        actions: [
          ElevatedButton(
            child: const Text('확인'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          ElevatedButton(
            child: const Text('취소'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      ),
    );
  }

  Future _getImgFromGallery() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _imagePath.add(image);
      _picker = image;
    });
  }
}
