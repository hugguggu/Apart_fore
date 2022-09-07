// lib/widget/bottom_bar.dart
import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Container(
        height: 75,
        child: const TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
                size: 26,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.map,
                size: 26,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.question_answer,
                size: 26,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.person,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
