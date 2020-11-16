import 'dart:io';

import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  final File file;

  const ImageView({Key key, this.file}) : super(key: key);
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  double _scaleValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onScaleUpdate: (scaleValue){
            setState(() {
              _scaleValue = scaleValue.scale;
            });
          },
          child: Transform.scale(
            scale: _scaleValue??1,
            child: Image.file(
                widget.file,
              isAntiAlias: true,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
