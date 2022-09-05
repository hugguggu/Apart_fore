import 'package:apart_forest/board/model/model_post.dart';
import 'package:apart_forest/board/screen/board_screen.dart';
import 'package:apart_forest/board/widget/bottom_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  // const MainScreen({Key? key}) : super(key: key);

  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blueAccent,
        accentColor: Colors.orangeAccent,
        focusColor: Colors.orangeAccent,
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              BoardScreen(),
              // Container(
              //   child: Center(
              //     child: Text('HOME'),
              //   ),
              // ),
              Container(
                child: Center(
                  child: Text('MAP'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('more'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('etc'),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}
