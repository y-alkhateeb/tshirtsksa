import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tshirtsksa/feature/image_editer_pro/bloc/image_editor_step_bloc.dart';

class ImageEditorUtils{
  final BuildContext context;
  final ImageEditorStepBloc imageEditorStepBloc;
  final imagePicker = ImagePicker();

  ImageEditorUtils({this.context, this.imageEditorStepBloc});
  void openPhotoBottomSheetsToAddBaseImageOrSticker(ImageEditorStepEvent event(
      File baseImage,
      int height,
      int width
      )) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return  Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 10.9, color: Colors.grey[400])
          ]),
          height: 170,
          child:  Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child:  Text("Select Image Options"),
              ),
              Divider(
                height: 1,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    /// from Gallery
                    Container(
                      child: Column(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.photo_library),
                              onPressed: () async {
                                final pickedFile = await imagePicker.getImage(
                                    source: ImageSource.gallery);
                                if (pickedFile != null) {
                                  final _imageFromPicker = File(pickedFile.path);
                                  var decodedImage =
                                  await decodeImageFromList(
                                      _imageFromPicker.readAsBytesSync());
                                  // _controller.clear();
                                  imageEditorStepBloc.add(event(
                                    _imageFromPicker,
                                    decodedImage.height,
                                    decodedImage.width,
                                  ));
                                  Navigator.pop(context);
                                }
                              }),
                          const SizedBox(width: 10),
                          Text("Open Gallery")
                        ],
                      ),
                    ),
                    SizedBox(width: 24),
                    /// from Camera
                    Container(
                      child: Column(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.camera_alt),
                              onPressed: () async {
                                final pickedFile = await imagePicker.getImage(
                                    source: ImageSource.camera);
                                if (pickedFile != null) {
                                  final _imageFromPicker = File(pickedFile.path);
                                  var decodedImage =
                                  await decodeImageFromList(
                                      _imageFromPicker.readAsBytesSync());
                                  // _controller.clear();
                                  imageEditorStepBloc.add(event(
                                    _imageFromPicker,
                                    decodedImage.height,
                                    decodedImage.width,
                                  ));
                                  Navigator.pop(context);
                                }
                              }),
                          SizedBox(width: 10),
                          Text("Open Camera")
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}