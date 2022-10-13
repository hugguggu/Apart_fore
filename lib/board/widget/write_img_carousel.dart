import 'dart:io';

import 'package:apart_forest/board/model/network_singleton.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';

class WriteScreenImageCarousel extends StatefulWidget {
  final List<PickedFile> listImagePath;

  const WriteScreenImageCarousel({Key key, this.listImagePath})
      : super(key: key);
  // List<String> testList = ['NEWS 1', 'NEWS 2', 'NEWS 3', 'NEWS 4'];

  @override
  State<WriteScreenImageCarousel> createState() =>
      WritedScreenImageCarouselState();
}

class WritedScreenImageCarouselState extends State<WriteScreenImageCarousel> {
  int _currentPage = 0;
  CarouselController carouselController = CarouselController();
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
                items: widget.listImagePath.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        // child: Image.file(File(i.path)),
                        child: Image.file(File(i.path)),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: makeIndicator(widget.listImagePath, _currentPage),
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
