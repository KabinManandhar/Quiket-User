import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:testawwpp/widgets/softContainer.dart';

class LoadingContainer extends StatelessWidget {
  Widget build(context) {
    return buildContainer(context);
    // return Column(
    //   children: [
    //     ListTile(
    //       title: buildContainer(),
    //       subtitle: buildContainer(),
    //     ),
    //     Divider(height: 8.0),
    //   ],
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
            onClick: () {
              print('wassup');
            },
            height: 230,
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
