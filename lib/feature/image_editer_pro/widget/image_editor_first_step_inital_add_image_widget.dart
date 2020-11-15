import 'package:flutter/material.dart';
import 'package:tshirtsksa/core/common/app_colors.dart';
import 'package:tshirtsksa/core/common/dimens.dart';
import 'package:tshirtsksa/core/common/gaps.dart';
import 'package:tshirtsksa/feature/image_editer_pro/bloc/image_editor_step_bloc.dart';

import 'image_editor_utils.dart';

class ImageEditorFirstStepInitialAddImageWidget extends StatefulWidget {
  final ImageEditorStepBloc imageEditorStepBloc;

  const ImageEditorFirstStepInitialAddImageWidget({Key key, this.imageEditorStepBloc}) : super(key: key);
  @override
  _ImageEditorFirstStepInitialAddImageWidgetState createState() => _ImageEditorFirstStepInitialAddImageWidgetState();
}

class _ImageEditorFirstStepInitialAddImageWidgetState extends State<ImageEditorFirstStepInitialAddImageWidget> {
  ImageEditorUtils utils;

  @override
  void initState() {
    utils = ImageEditorUtils(
        context: context, imageEditorStepBloc: widget.imageEditorStepBloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        utils.openPhotoBottomSheetsToAddBaseImageOrSticker(
                (image, height, width) =>
                AddImageEvent(
                  baseImage: image,
                  height: height,
                  width: width,
                )
        );
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_a_photo_outlined,
              color: AppColors.primaryColorDark,
              size: MediaQuery
                  .of(context)
                  .size
                  .width / 3,
            ),
            Gaps.vGap32,
            Text(
              "Tap anywhere to open a photo",
              style: TextStyle(
                  color: AppColors.primaryColorDark,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimens.font_sp24
              ),
            ),
          ],
        ),
      ),
    );
  }
}