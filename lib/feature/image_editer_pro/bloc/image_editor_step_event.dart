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

class SaveEditImageEvent extends ImageEditorStepEvent {
  final File baseImage;
  final int height;
  final int width;

  const SaveEditImageEvent({
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

class AddTextImageEvent extends ImageEditorStepEvent {
  @override
  List<Object> get props => [];

}