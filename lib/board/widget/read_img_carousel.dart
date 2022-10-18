import 'package:apart_forest/board/model/article_model.dart';
import 'package:apart_forest/board/model/network_singleton.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ReadScreenImageCarousel extends StatefulWidget {
  final List<Content> contentList;
  const ReadScreenImageCarousel({Key key, this.contentList}) : super(key: key);
  // final articleModel post;

  @override
  State<ReadScreenImageCarousel> createState() =>
      _ReadScreenImageCarouselState();
}

class _ReadScreenImageCarouselState extends State<ReadScreenImageCarousel> {
  int _currentPage = 0;
  CarouselController carouselController = CarouselController();
  List<Content> imgList = [];
  @override
  void initState() {
    super.initState();
    widget.contentList.forEach((element) {
      if (element.contentType == "IMG") {
        imgList.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        // width: 450,
        height: 160,

        child: Stack(
          children: [
            Center(
              child: CarouselSlider(
                carouselController: carouselController,
                options: CarouselOptions(onPageChanged: (index, reason) {
                  setState(() {
                    _currentPage = index;
                  });
                }),
                items: imgList.map((i) {
                  if (i.contentType == "IMG") {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(NetworkSingleton()
                              .getImagAddress(imgList[_currentPage].content)),
                        );
                      },
                    );
                  }
                }).toList(),
              ),
            ),
            if (imgList.length > 1)
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    // Use the controller to change the current page
                    carouselController.previousPage();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
            if (imgList.length > 1)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    // Use the controller to change the current page
                    carouselController.nextPage();
                  },
                  icon: const Icon(Icons.arrow_forward),
                ),
              ),
            if (imgList.length > 1)
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: makeIndicator(imgList, _currentPage),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

List<Widget> makeIndicator(List list, int _currentPage) {
  List<Widget> result = [];

  for (var i = 0; i < list.length; i++) {
    result.add(Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == i ? Colors.red : Colors.black26,
      ),
    ));
  }

  return result;
}
