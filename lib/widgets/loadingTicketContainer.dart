import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'softContainer.dart';

class LoadingTicketContainer extends StatelessWidget {
  Widget build(context) {
    return buildContainer(context);
  }
}

Widget buildContainer(BuildContext context) {
  return Center(
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.white,
      child: Column(
        children: <Widget>[
          Divider(
            height: 20.0,
          ),
          SoftContainer(
            onClick: () {},
            height: 100,
            width: MediaQuery.of(context).size.width - 70,
          ),
          Divider(
            height: 20.0,
          ),
        ],
      ),
    ),
  );
}
