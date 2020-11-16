import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tshirtsksa/feature/image_editer_pro/bloc/image_editor_step_bloc.dart';
import 'box_image_clipper.dart';

class ImageView extends StatefulWidget {
  final File file;
  final Size sizeOfBoxImage;
  final Offset offsetOfBoxImage;
  final ImageEditorStepBloc imageEditorStepBloc;

  const ImageView({Key key, this.file, this.sizeOfBoxImage, this.offsetOfBoxImage, this.imageEditorStepBloc}) : super(key: key);
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  double _scaleValue;
  final ScreenshotController screenshotBoxController = ScreenshotController();
  GlobalKey _containerKey = GlobalKey();
  @override
  void initState() {
    screenshotBoxController.capture(pixelRatio: 5,delay: Duration(milliseconds: 200)).then((value) {
      widget.imageEditorStepBloc.add(SaveImageInGallery(value));
    }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: Colors.white,
          child: Stack(
            children: [
              Screenshot(
                controller: screenshotBoxController,
                containerKey: _containerKey,
                child: ClipPath(
                  key: _containerKey,
                  clipper: BoxImageClipper(
                    widget.sizeOfBoxImage,
                    widget.offsetOfBoxImage,
                    MediaQuery.of(context).viewPadding.top,
                  ),
                  child: Image.file(
                      widget.file,
                    isAntiAlias: true,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}