part of 'image_editor_step_bloc.dart';

abstract class ImageEditorStepEvent extends Equatable {
  const ImageEditorStepEvent();
}

class AddImageEvent extends ImageEditorStepEvent {
  final File baseImage;
  final int height;
  final int width;

  const AddImageEvent({
    @required this.baseImage,
    @required this.height,
    @required this.width,
  });

  @override
  List<Object> get props => [
        baseImage,
        height,
        width,
      ];
}

class ExitEditImageEvent extends ImageEditorStepEvent {

  const ExitEditImageEvent();

  @override
  List<Object> get props => [];
}

class SaveEditImageEvent extends AddImageEvent {

  const SaveEditImageEvent({
    @required File baseImage,
    @required int height,
    @required int width,
  }) : super(baseImage: baseImage, width: width, height: height);

  @override
  List<Object> get props => [
    baseImage,
    height,
    width,
  ];
}

class AddTextImageEvent extends ImageEditorStepEvent {
  const AddTextImageEvent();
  @override
  List<Object> get props => [];
}

class AddEmojiImageEvent extends ImageEditorStepEvent {
  const AddEmojiImageEvent();
  @override
  List<Object> get props => [];
}

class AddPainterImageEvent extends ImageEditorStepEvent {
  const AddPainterImageEvent();
  @override
  List<Object> get props => [];
}

class AddImageLayerEvent extends ImageEditorStepEvent {
  final File baseImage;
  final int height;
  final int width;
  const AddImageLayerEvent({
    @required this.baseImage,
    @required this.height,
    @required this.width,
  });
  @override
  List<Object> get props => [
    baseImage,
    width,
    height
  ];
}