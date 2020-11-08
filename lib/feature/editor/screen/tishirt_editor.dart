import 'package:flutter/material.dart';
import 'package:tshirtsksa/core/common/app_colors.dart';

class TShirtEditor extends StatefulWidget {
  @override
  _TShirtEditorState createState() => _TShirtEditorState();
}

class _TShirtEditorState extends State<TShirtEditor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Expanded(
              child: Container(
                color: Colors.red,
              ),
          ),
          Container(
            height: kToolbarHeight,
            width: double.maxFinite,
            color: Colors.white24,
            child: ListView(
              children: [
                IconButton(
                    icon: Icon(Icons.image),
                    onPressed: (){},
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: (){},
                ),
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: (){},
                ),
                IconButton(
                  icon: Icon(Icons.text_fields),
                  onPressed: (){},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
