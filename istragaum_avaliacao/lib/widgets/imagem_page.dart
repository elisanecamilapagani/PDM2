import 'package:flutter/material.dart';

import 'dart:io';

class ImagePage extends StatelessWidget {
  final String id;
  ImagePage(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Istragaum',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Billabong',
            fontSize: 35,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: Colors.black26,
            height: 1,
          ),
          preferredSize: Size.fromHeight(1),
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.file(
          File(id),
          height: 1000,
          width: 1000,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
