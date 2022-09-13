import 'package:apart_forest/board/model/network_singleton.dart';
import 'package:flutter/material.dart';

class myPage extends StatelessWidget {
  // const myPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: MaterialButton(
          color: Color(0xff347af0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(
              color: Color(0xff347af0),
            ),
          ),
          onPressed: () {
            NetworkSingleton().signDelete();
          },
          child: const Text('탈퇴'),
        ),
      ),
    );
  }
}
