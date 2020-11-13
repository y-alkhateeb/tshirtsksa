import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'image_editor_step_event.dart';

part 'image_editor_step_state.dart';

class ImageEditorStepBloc
    extends Bloc<ImageEditorStepEvent, ImageEditorStepState> {
  ImageEditorStepBloc() : super(ImageEditorFirstStepInitialState());

  List<File> _listOfEditingImage= List<File>();
  int _height;
  int _width;
  @override
  Stream<ImageEditorStepState> mapEventToState(
    ImageEditorStepEvent event,
  ) async* {

    if (event is AddImageEvent) {
      _listOfEditingImage.add(event.baseImage);
      _height = event.height;
      _width = event.height;
      yield InsertImageState(
        baseImage: event.baseImage,
        height: event.height,
        width: event.height,
      );
    }
    else if (event is ExitEditImageEvent){
      yield InsertImageState(
        baseImage: _listOfEditingImage.last,
        height: _height,
        width: _height,
      );
    }
    else if(event is SaveEditImageEvent){
      _listOfEditingImage.add(event.baseImage);
      _height = event.height;
      _width = event.height;
      yield InsertImageState(
        baseImage: _listOfEditingImage.last,
        height: _height,
        width: _height,
      );
    }
    else if(event is AddTextImageEvent){
      yield TextImageState(
        baseImage: _listOfEditingImage.last,
        height: _height,
        width: _height,
      );
    }
  }
}
