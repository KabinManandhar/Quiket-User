import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../control/routes.dart';

class SplashScreenQuiket extends StatefulWidget {
  @override
  _SplashScreenQuiketState createState() => _SplashScreenQuiketState();
}

class _SplashScreenQuiketState extends State<SplashScreenQuiket> {
  @override
  void initState() {
    super.initState();

    //secureStorage.deleteAll();

    Timer(Duration(seconds: 1), () async {
      Navigator.pushReplacementNamed(context, navigationRoute);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: Center(
        child: Hero(
          child: SvgPicture.asset(
            'assets/images/Logo.svg',
            height: 300,
            width: 300,
            color: Colors.grey[700],
          ),
          tag: 'svg',
        ),
      ),
    );
  }
}
