// lib/widget/bottom_bar.dart
import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Container(
        height: 50,
        child: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: Colors.transparent,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.reorder,
                size: 16,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.map,
                size: 16,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.chat_bubble,
                size: 16,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.person,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
