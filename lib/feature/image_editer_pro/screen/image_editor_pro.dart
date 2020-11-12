import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tshirtsksa/core/common/app_colors.dart';
import 'package:tshirtsksa/core/common/dimens.dart';
import 'package:tshirtsksa/core/common/gaps.dart';
import 'package:tshirtsksa/feature/image_editer_pro/bloc/image_editor_step_bloc.dart';
import '../modules/all_emojies.dart';
import '../modules/bottombar_container.dart';
import '../modules/colors_picker.dart';
import '../modules/emoji.dart';
import '../modules/text.dart';
import '../modules/textview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:signature/signature.dart';



List fontSize = [];
var howMuchWidgetIs = 0;
List multiWidGet = [];
Color currentColors = Colors.white;
var opacity = 0.0;
SignatureController _controller =
    SignatureController(penStrokeWidth: 5, penColor: Colors.green);

class TShirtEditor extends StatefulWidget {
  @override
  _TShirtEditorState createState() => _TShirtEditorState();
}

var slider = 0.0;

class _TShirtEditorState extends State<TShirtEditor> {
  final ImageEditorStepBloc imageEditorStepBloc = ImageEditorStepBloc();
  final imagePicker = ImagePicker();
  double _editorBoxWidth = 300;
  double _editorBoxHeight = 300;

  TextEditingController heightTextController;
  TextEditingController widthTextController;

  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
    var points = _controller.points;
    _controller =
        SignatureController(penStrokeWidth: 5, penColor: color, points: points);
  }

  List<Offset> offsets = [];
  Offset offset1 = Offset.zero;
  Offset offset2 = Offset.zero;
  final scaf = GlobalKey<ScaffoldState>();
  var openBottomSheet = false;
  List<Offset> _points = <Offset>[];
  List type = [];
  List alignment = [];

  final GlobalKey container = GlobalKey();
  final GlobalKey globalKey =  GlobalKey();
  ScreenshotController screenshotController = ScreenshotController();
  Timer timePrediction;
  void timers() {
    Timer.periodic(Duration(milliseconds: 10), (tim) {
      setState(() {});
      timePrediction = tim;
    });
  }

  @override
  void dispose() {
    timePrediction.cancel();
    imageEditorStepBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    /// initialize height and width for edit box
    heightTextController =  TextEditingController(text: "$_editorBoxHeight");
    widthTextController=  TextEditingController(text: "$_editorBoxWidth");

    timers();
    _controller.clear();
    type.clear();
    fontSize.clear();
    offsets.clear();
    multiWidGet.clear();
    howMuchWidgetIs = 0;
    super.initState();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _editorBoxHeight = MediaQuery.of(context).size.height/2.3;
    _editorBoxWidth = MediaQuery.of(context).size.width/2;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
          key: scaf,
          body: Center(
            child: Screenshot(
              controller: screenshotController,
              child: BlocBuilder(
                cubit: imageEditorStepBloc,
                  builder: (context, state) {
                  if(state is ImageEditorFirstStepInitialState){
                    return InkWell(
                      onTap: (){
                        openPhotoBottomSheets();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo_outlined,
                              color: AppColors.primaryColorDark,
                              size: MediaQuery.of(context).size.width/3,
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
                  if(state is InsertImageState){
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: RepaintBoundary(
                          key: globalKey,
                          child: Stack(
                            children: <Widget>[
                              state.baseImage != null
                                  ? InteractiveViewer(
                                    child: Image.file(
                                state.baseImage,
                                height: state.height.toDouble(),
                                width: state.width.toDouble(),
                                fit: BoxFit.contain,
                              ),
                                  )
                                  : Container(),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: _editorBoxWidth,
                                  height: _editorBoxHeight,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          width: _editorBoxWidth,
                                          height: _editorBoxHeight,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 0.2,),
                                          ),
                                          child: GestureDetector(
                                            /// TODO not used !
                                            // onPanUpdate: (DragUpdateDetails details) {
                                            //   setState(() {
                                            //     RenderBox object = context.findRenderObject();
                                            //     Offset _localPosition = object.globalToLocal(details.globalPosition);
                                            //     _points =  List.from(_points)..add(_localPosition);
                                            //   });
                                            // },
                                            // onPanEnd: (DragEndDetails details) {
                                            //   _points.add(null);
                                            // },
                                            child: Painter(
                                              editorBoxHeight: _editorBoxHeight,
                                              editorBoxWidth: _editorBoxWidth,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Stack(
                                        children: multiWidGet.asMap().entries.map((f) {
                                          return type[f.key] == 1
                                              ? EmojiView(
                                            left: offsets[f.key].dx,
                                            top: offsets[f.key].dy,
                                            ontap: () {
                                              scaf.currentState
                                                  .showBottomSheet((context) {
                                                return Sliders(
                                                  size: f.key,
                                                  sizevalue: fontSize[f.key].toDouble(),
                                                );
                                              });
                                            },
                                            onpanupdate: (details) {
                                              setState(() {
                                                offsets[f.key] = Offset(
                                                    offsets[f.key].dx + details.delta.dx,
                                                    offsets[f.key].dy + details.delta.dy);
                                              });
                                            },
                                            value: f.value.toString(),
                                            fontsize: fontSize[f.key].toDouble(),
                                            align: TextAlign.center,
                                          )
                                              : type[f.key] == 2
                                              ? TextView(
                                            left: offsets[f.key].dx,
                                            top: offsets[f.key].dy,
                                            ontap: () {
                                              scaf.currentState
                                                  .showBottomSheet((context) {
                                                return Sliders(
                                                  size: f.key,
                                                  sizevalue:
                                                  fontSize[f.key].toDouble(),
                                                );
                                              });
                                            },
                                            onpanupdate: (details) {
                                              setState(() {
                                                offsets[f.key] = Offset(
                                                    offsets[f.key].dx +
                                                        details.delta.dx,
                                                    offsets[f.key].dy +
                                                        details.delta.dy);
                                              });
                                            },
                                            value: f.value.toString(),
                                            fontsize: fontSize[f.key].toDouble(),
                                            align: TextAlign.center,
                                          )
                                              :  Container();
                                        }).toList(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    );
                  }
                  else return InkWell(
                    onTap: (){
                      openPhotoBottomSheets();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo_outlined,
                            color: AppColors.primaryColorDark,
                            size: MediaQuery.of(context).size.width/3,
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
              ),
            ),
          ),
          bottomNavigationBar: openBottomSheet
              ?  Container()
              : Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(blurRadius: 4)]),
                  height: 70,
                  child:  ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      BottomBarContainer(
                        colors: Colors.white,
                        icons: FontAwesomeIcons.brush,
                        onTap: () {
                          // raise the [showDialog] widget
                          showDialog(
                              context: context,
                              child: AlertDialog(
                                title: const Text('Pick a color!'),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: pickerColor,
                                    onColorChanged: changeColor,
                                    showLabel: true,
                                    pickerAreaHeightPercent: 0.8,
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: const Text('Got it'),
                                    onPressed: () {
                                      setState(() => currentColor = pickerColor);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));
                        },
                      ),
                      BottomBarContainer(
                        icons: Icons.text_fields,
                        onTap: () async {
                          final value = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TextEditor()));
                          if (value.toString().isEmpty) {
                            print("true");
                          } else {
                            type.add(2);
                            fontSize.add(20);
                            offsets.add(Offset.zero);
                            multiWidGet.add(value);
                            howMuchWidgetIs++;
                          }
                        },
                      ),
                      BottomBarContainer(
                        icons: FontAwesomeIcons.eraser,
                        onTap: () {
                          _controller.clear();
                          type.clear();
                          fontSize.clear();
                          offsets.clear();
                          multiWidGet.clear();
                          howMuchWidgetIs = 0;
                        },
                      ),
                      BottomBarContainer(
                        icons: Icons.photo,
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ColorPiskersSlider();
                              });
                        },
                      ),
                      BottomBarContainer(
                        icons: FontAwesomeIcons.smile,
                        onTap: () {
                          Future getemojis = showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Emojies();
                              });
                          getemojis.then((value) {
                            if (value != null) {
                              type.add(1);
                              fontSize.add(20);
                              offsets.add(Offset.zero);
                              multiWidGet.add(value);
                              howMuchWidgetIs++;
                            }
                          });
                        },
                      ),
                      BottomBarContainer(
                        icons: FontAwesomeIcons.boxes,
                        onTap: (){
                          showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title:  Text("Select Height Width"),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () => Navigator.pop(context),
                                      textColor: Colors.red,
                                      child: Text("Cancel"),
                                    ),
                                    FlatButton(
                                        onPressed: () {
                                          setState(() {
                                            _editorBoxHeight = double.parse(heightTextController.text??0);
                                            _editorBoxWidth = double.parse(widthTextController.text??0);
                                          });
                                          Navigator.pop(context);
                                        },
                                        child:  Text("Done"))
                                  ],
                                  content:  SingleChildScrollView(
                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Define Height"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextField(
                                            controller: heightTextController,
                                            keyboardType:
                                            TextInputType.numberWithOptions(),
                                            decoration: InputDecoration(
                                                hintText: 'Height',
                                                contentPadding:
                                                EdgeInsets.only(left: 10),
                                                border: OutlineInputBorder())),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("Define Width"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextField(
                                            controller: widthTextController,
                                            keyboardType:
                                            TextInputType.numberWithOptions(),
                                            decoration: InputDecoration(
                                                hintText: 'Width',
                                                contentPadding:
                                                EdgeInsets.only(left: 10),
                                                border: OutlineInputBorder())),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                      BottomBarContainer(
                        icons: Icons.clear,
                        onTap: (){
                          _controller.points.clear();
                          setState(() {});
                        },
                      ),
                      BottomBarContainer(
                        icons: Icons.camera,
                        onTap: (){
                          openPhotoBottomSheets();
                        },
                      ),
                      BottomBarContainer(
                        icons: Icons.save_alt,
                        onTap: (){
                          File _imageFile;
                          _imageFile = null;
                          screenshotController
                              .capture(
                              delay: Duration(milliseconds: 500), pixelRatio: 1.5)
                              .then((File image) async {
                            //print("Capture Done");
                            setState(() {
                              _imageFile = image;
                            });
                            final paths = await getExternalStorageDirectory();
                            image.copy(paths.path +
                                '/' +
                                DateTime.now().millisecondsSinceEpoch.toString() +
                                '.png');
                            Navigator.pop(context, image);
                          }).catchError((onError) {
                            print(onError);
                          });
                        },
                      ),
                    ],
                  ),
                )
      ),
    );
  }

  void openPhotoBottomSheets() {
    openBottomSheet = true;
    setState(() {});
    Future<void> future = showModalBottomSheet<void>(
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
                                  _controller.clear();
                                  imageEditorStepBloc.add(
                                    AddImageEvent(
                                      baseImage: _imageFromPicker,
                                      height: decodedImage.height,
                                      width: decodedImage.width,
                                    ),
                                  );
                                }
                                Navigator.pop(context);
                              }),
                          SizedBox(width: 10),
                          Text("Open Gallery")
                        ],
                      ),
                    ),
                    SizedBox(width: 24),
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
                                  _controller.clear();
                                  imageEditorStepBloc.add(
                                      AddImageEvent(
                                        baseImage: _imageFromPicker,
                                        height: decodedImage.height,
                                        width: decodedImage.width,
                                      ),
                                  );
                                }
                                Navigator.pop(context);
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
    future.then((void value) => _closeModal(value));
  }

  void _closeModal(void value) {
    openBottomSheet = false;
    setState(() {});
  }
}

class Painter extends StatefulWidget {
  final double editorBoxHeight;
  final double editorBoxWidth;

  const Painter({
    Key key,
    @required this.editorBoxHeight,
    @required this.editorBoxWidth,
  }) : super(key: key);
  @override
  _PainterState createState() => _PainterState();
}

class _PainterState extends State<Painter> {
  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print("Value changed"));
  }

  @override
  Widget build(BuildContext context) {
    return Signature(
            controller: _controller,
            height: widget.editorBoxHeight,
            width: widget.editorBoxWidth,
            backgroundColor: Colors.transparent,
        );
  }
}

class Sliders extends StatefulWidget {
  final int size;
  final sizevalue;
  const Sliders({Key key, this.size, this.sizevalue}) : super(key: key);
  @override
  _SlidersState createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> {
  @override
  void initState() {
    slider = widget.sizevalue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child:  Text("Slider Size"),
            ),
            Divider(
              height: 1,
            ),
             Slider(
                value: slider,
                min: 0.0,
                max: 100.0,
                onChangeEnd: (v) {
                  setState(() {
                    fontSize[widget.size] = v.toInt();
                  });
                },
                onChanged: (v) {
                  setState(() {
                    slider = v;
                    print(v.toInt());
                    fontSize[widget.size] = v.toInt();
                  });
                }),
          ],
        ));
  }
}

class ColorPiskersSlider extends StatefulWidget {
  @override
  _ColorSliderState createState() => _ColorSliderState();
}

class _ColorSliderState extends State<ColorPiskersSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 260,
      color: Colors.white,
      child:  Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child:  Text("Slider Filter Color"),
          ),
          Divider(
            height: 1,
          ),
          SizedBox(height: 20),
           Text("Slider Color"),
          SizedBox(height: 10),
          BarColorPicker(
              width: 300,
              thumbColor: Colors.white,
              cornerRadius: 10,
              pickMode: PickMode.Color,
              colorListener: (int value) {
                setState(() {
                  //  currentColor = Color(value);
                });
              }),
          SizedBox(height: 20),
           Text("Slider Opicity"),
          SizedBox(height: 10),
          Slider(value: 0.1, min: 0.0, max: 1.0, onChanged: (v) {})
        ],
      ),
    );
  }
}
