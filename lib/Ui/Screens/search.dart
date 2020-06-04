import 'package:flutter/material.dart';

import '../../control/style.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'Search',
          ),
          elevation: 0,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 200,
        child: Center(
          child: Text(
            'This section is currently under development. It will be available on the next update.',
            style: labelTextSmallStyle,
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
