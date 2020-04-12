import 'package:flutter/material.dart';

typedef void ButtonClickListener();

class SoftButton extends StatefulWidget {
  final icon;
  final bool opacity;
  final double radius;
  final ButtonClickListener onClick;
  final MainAxisAlignment mainAxisAlignment;
  final double height;
  final double width;
  final double iconSize;
  final double fontSize;

  SoftButton(
      {Key key,
      this.opacity = true,
      this.icon,
      this.radius = 62,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.height = 60,
      this.onClick,
      this.width = 60,
      this.fontSize = 30,
      this.iconSize = 20})
      : super(key: key);

  @override
  _SoftButtonState createState() => _SoftButtonState();
}

class _SoftButtonState extends State<SoftButton> {
  bool tapCheck = false;
  List<Color> clicked = [
    Colors.grey[700],
    Colors.grey[600],
    Colors.grey[500],
    Colors.grey[200],
  ];
  List<Color> unclicked = [
    Colors.grey[200],
    Colors.grey[300],
    Colors.grey[400],
    Colors.grey[500],
  ];
  List<double> forClicked = [0, 0.1, 0.3, 1];
  List<double> forUnclicked = [0.1, 0.3, 0.8, 1];
  Color buttonColor = Colors.grey[300];
  Color lightShadow = Colors.white;
  Color darkShadow = Colors.grey[600];
  double offset = 4.0;
  double inset = -4.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        setState(() {
          tapCheck = !tapCheck;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          widget.onClick();
          tapCheck = !tapCheck;
        });
      },
      onTapCancel: () {
        setState(() {
          tapCheck = false;
        });
      },
      child: Stack(children: <Widget>[
        AnimatedOpacity(
          opacity: widget.opacity ? 1 : 0,
          duration: Duration(milliseconds: 400),
          child: AnimatedContainer(
            width: widget.width,
            height: widget.height,
            padding: EdgeInsets.all(20),
            child: widget.icon != null
                ? IconButton(
                    padding: EdgeInsets.all(0),
                    color: Colors.grey[700],
                    iconSize: tapCheck ? widget.iconSize - 1 : widget.iconSize,
                    icon: Icon(
                      widget.icon,
                    ),
                    onPressed: null,
                  )
                : Icon(null),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.radius),
                color: buttonColor,
                boxShadow: [
                  BoxShadow(
                      color: tapCheck ? lightShadow : darkShadow,
                      offset: Offset(offset, offset),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                  BoxShadow(
                      color: tapCheck ? darkShadow : lightShadow,
                      offset: Offset(inset, inset),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                ],
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: tapCheck ? clicked : unclicked,
                    stops: tapCheck ? forClicked : forUnclicked)),
            duration: Duration(milliseconds: 150),
          ),
        ),
        // Opacity(
        //   opacity: widget.opacity ? 1 : 0,
        //   child: AnimatedContainer(
        //       child: Container(),
        //       width: widget.width + 10,
        //       height: widget.height + 10,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(widget.radius),
        //         color: buttonColor,
        //         boxShadow: [
        //           BoxShadow(
        //               color: buttonColor,
        //               offset: Offset(10, 10),
        //               blurRadius: 15.0,
        //               spreadRadius: 1.0),
        //           BoxShadow(
        //               color: buttonColor,
        //               offset: Offset(-10, -10),
        //               blurRadius: 15.0,
        //               spreadRadius: 1.0),
        //         ],
        //       ),
        //       duration: Duration(milliseconds: 300)),
        // ),
      ]),
    );
  }
}
