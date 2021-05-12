import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Size preferredSize;

  const MyAppBar({Key key, this.title})
      : this.preferredSize = const Size.fromHeight(70.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(title),
      toolbarHeight: 70,
      leadingWidth: 80,
      leading: Container(
        margin: const EdgeInsets.only(left: 10.0),
        child: CircleAvatar(
          backgroundColor: Colors.black,
          backgroundImage: NetworkImage(
            'https://news.wirefly.com/sites/phonedog.com/files/blog/main_image/2016/06/newnetflixiconlarge.png',
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: CircleAvatar(
            minRadius: 25,
            backgroundColor: Colors.red,
            child: Text(
              "C",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
