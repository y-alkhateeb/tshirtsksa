import 'package:flutter/material.dart';

class BottomBarContainer extends StatelessWidget {
  final Color colors;
  final Function onTap;
  final IconData icons;

  const BottomBarContainer(
      {Key key, this.onTap, this.icons, this.colors})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width / 5,
      color: colors,
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                icons,
                color: Colors.grey,
              ),
              SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
