import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'image_editor_step_event.dart';

part 'image_editor_step_state.dart';

class ImageEditorStepBloc
    extends Bloc<ImageEditorStepEvent, ImageEditorStepState> {
  ImageEditorStepBloc() : super(ImageEditorFirstStepInitialAddImageState());

  List<File> _listOfEditingImage= List<File>();
  List<int> _height = List<int>();
  List<int> _width = List<int>();
  @override
  Stream<ImageEditorStepState> mapEventToState(
    ImageEditorStepEvent event,
  ) async* {

    if (event is AddImageEvent) {
      _listOfEditingImage.add(event.baseImage);
      _height.add(event.height);
      _width.add(event.width);
      yield InsertImageState(
        baseImage: event.baseImage,
        height: event.height,
        width: event.width,
      );
    }
    else if (event is ExitEditImageEvent){
      yield InsertImageState(
        baseImage: _listOfEditingImage.last,
        height: _height.last,
        width: _width.last,
      );
    }
    else if(event is SaveEditImageEvent){
      _listOfEditingImage.add(event.baseImage);
      _height.add(event.height);
      _width.add(event.width);
      yield InsertImageState(
        baseImage: _listOfEditingImage.last,
        height: _height.last,
        width: _width.last,
      );
    }
    else if(event is AddTextImageEvent){
      yield TextImageState(
        baseImage: _listOfEditingImage.last,
        height: _height.last,
        width: _width.last,
      );
    }
    else if(event is AddEmojiImageEvent){
      yield EmojiImageState(
        baseImage: _listOfEditingImage.last,
        height: _height.last,
        width: _width.last,
      );
    }
    else if(event is AddPainterImageEvent){
      yield PaintImageState(
        baseImage: _listOfEditingImage.last,
        height: _height.last,
        width: _width.last,
      );
    }
    else if(event is AddStickerLayerEvent){
      yield StickerImageState(
        layerImage: event.baseImage,
        baseImage: _listOfEditingImage.last,
        height: _height.last,
        width: _width.last,
      );
    }
  }
}
