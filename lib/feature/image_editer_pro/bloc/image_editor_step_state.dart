part of 'image_editor_step_bloc.dart';

abstract class ImageEditorStepState extends Equatable {
  const ImageEditorStepState();
}

/// First state of bloc
class ImageEditorFirstStepInitialState extends ImageEditorStepState {
  const ImageEditorFirstStepInitialState();

  @override
  List<Object> get props => [];
}

class InsertImageState extends ImageEditorStepState {
  final File baseImage;
  final int height;
  final int width;

  const InsertImageState({
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

class PaintImageState extends ImageEditorStepState{
  final File baseImage;
  final int height;
  final int width;
  const PaintImageState({
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


class EmojiImageState extends ImageEditorStepState{

  final File baseImage;
  final int height;
  final int width;

  const EmojiImageState({
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


class TextImageState extends ImageEditorStepState{
  final File baseImage;
  final int height;
  final int width;
  const TextImageState({
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

class ImageLayerState extends ImageEditorStepState{
  final File baseImage;
  final int height;
  final int width;
  final File layerImage;

  const ImageLayerState({
    @required this.layerImage,
    @required this.baseImage,
    @required this.height,
    @required this.width,
  });

  @override
  List<Object> get props => [
    layerImage,
    baseImage,
    height,
    width,
  ];
}