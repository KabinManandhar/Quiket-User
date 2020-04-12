import 'package:flutter/material.dart';
import 'package:testawwpp/Ui/Event/event_card.dart';

class HomeScreen extends StatefulWidget {
  final id;
  final token;

  const HomeScreen({Key key, this.id, this.token}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'Explore',
          ),
          elevation: 0,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 200,
        child: EventCard(),
      ),
    );
  }
}
