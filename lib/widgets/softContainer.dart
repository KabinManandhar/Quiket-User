import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../control/style.dart';

typedef void ButtonClickListener();

class SoftContainer extends StatefulWidget {
  final image;
  final bool status;
  final String label;
  final String dateTime;

  final double radius;
  final ButtonClickListener onClick;
  final MainAxisAlignment mainAxisAlignment;
  final double height;
  final double width;
  final double iconSize;
  final double fontSize;

  SoftContainer(
      {Key key,
      this.status = false,
      this.dateTime,
      this.image,
      this.label = '',
      this.radius = 12,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.height = 230,
      this.onClick,
      this.width = 60,
      this.fontSize = 30,
      this.iconSize = 20})
      : super(key: key);

  @override
  _SoftContainerState createState() => _SoftContainerState();
}

class _SoftContainerState extends State<SoftContainer> {
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
        widget.onClick();
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          tapCheck = !tapCheck;
        });
      },
      onTapCancel: () {
        setState(() {
          tapCheck = false;
        });
      },
      child:
          Stack(alignment: AlignmentDirectional.bottomStart, children: <Widget>[
        AnimatedContainer(
          width: widget.width,
          height: widget.height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius),
            child: widget.image != null
                ? Container(
                    height: widget.height - 10,
                    width: widget.width - 10,
                    child: Image.network(
                      "http://192.168.100.70:8000" + widget.image,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(),
          ),
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
                stops: tapCheck ? forClicked : forUnclicked),
          ),
          duration: Duration(milliseconds: 150),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: AutoSizeText(
            widget.label,
            maxLines: 2,
            minFontSize: 15,
            style: labelTextStyle,
            overflow: TextOverflow.ellipsis,
          ),
          height: widget.height - (widget.height / 2) - 50,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(widget.radius),
              bottomRight: Radius.circular(widget.radius),
            ),
            color: Colors.black87,
          ),
        ),
      ]),
    );
  }

  String _buildTime(String dateTime) {
    if (dateTime == null) {
      return 'Finding...';
    } else {
      List<String> splitTime = dateTime.split(' ');
      String time = splitTime[1];
      List<String> timeSplit = time.split(':');
      return timeSplit[0] + ':' + timeSplit[1];
    }
  }

  String _buildDate(String dateTime) {
    if (dateTime == null) {
      return 'Finding...';
    } else {
      List<String> splitDateTime = dateTime.split(' ');
      String date = splitDateTime[0];
      List<String> splitDate = date.split('-');
      int month = int.parse(splitDate[1]);
      String monthName;
      switch (month) {
        case 1:
          monthName = 'Jan';
          break;
        case 2:
          monthName = 'Feb';
          break;
        case 3:
          monthName = 'Mar';
          break;
        case 4:
          monthName = 'Apr';
          break;
        case 5:
          monthName = 'May';
          break;
        case 6:
          monthName = 'Jun';
          break;
        case 7:
          monthName = 'Jul';
          break;
        case 8:
          monthName = 'Aug';
          break;
        case 9:
          monthName = 'Sep';
          break;
        case 10:
          monthName = 'Oct';
          break;
        case 11:
          monthName = 'Nov';
          break;
        case 12:
          monthName = 'Dec';
          break;
      }
      return (monthName + ' ' + splitDate[2] + ', ' + splitDate[0]);
    }
  }
}
