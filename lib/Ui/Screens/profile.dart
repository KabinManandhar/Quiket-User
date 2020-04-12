// import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:testawwpp/control/style.dart';
// import 'package:testawwpp/models/organizer_model.dart';
// import 'package:testawwpp/resources/authProvider.dart';

// class ProfileScreen extends StatelessWidget {
//   final int eventId;
//   final _auth = AuthProvider();

//   ProfileScreen({this.eventId});

//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _auth.getOrganizerProfile(),
//       builder: (context, AsyncSnapshot<OrganizerModel> snapshot) {
//         if (snapshot.hasData) {
//           OrganizerModel organizer = snapshot.data;
//           return Scaffold(
//             resizeToAvoidBottomInset: true,
//             resizeToAvoidBottomPadding: true,
//             body: GestureDetector(
//               onTap: () {
//                 FocusScope.of(context).requestFocus(FocusNode());
//               },
//               child: CustomScrollView(slivers: <Widget>[
//                 SliverAppBar(
//                   elevation: 0,
//                   expandedHeight: 200.0,
//                   floating: true,
//                   pinned: true,
//                   flexibleSpace: FlexibleSpaceBar(
//                     background: organizer.picture == null
//                         ? Icon(MaterialIcons.image)
//                         : Image.network(
//                             "http://192.168.100.70:8000" + organizer.picture,
//                             fit: BoxFit.cover,
//                           ),
//                   ),
//                 ),
//                 SliverFillRemaining(
//                   child: Container(
//                     margin: EdgeInsets.all(20.0),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           nameField(organizer.name),
//                           Container(height: 30),
//                           emailField(organizer.email),
//                           Container(height: 30),
//                           phoneNoField(organizer.phoneNo),
//                           Container(height: 30),
//                           descriptionField(organizer.description),
//                           Container(height: 30),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ]),
//             ),
//           );
//         } else {
//           return Container();
//         }
//       },
//     );
//   }

//   nameField(name) {
//     return Text(
//       name,
//       style: titleText,
//     );
//   }

//   emailField(email) {
//     return Text(
//       'Email:' + email,
//       style: labelTextStyle,
//     );
//   }

//   phoneNoField(phoneNo) {
//     return Text(
//       'Phone No:' + phoneNo,
//       style: labelTextStyle,
//     );
//   }

//   descriptionField(description) {
//     return description == null
//         ? Container()
//         : Text(
//             'Description:' + description,
//             style: labelTextStyle,
//           );
//   }
// }
