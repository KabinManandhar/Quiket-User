import 'package:flutter/material.dart';

import '../Bookmark/bookmark_card.dart';

class BookmarkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'Bookmarks',
          ),
          elevation: 0,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 200,
        child: BookmarkCard(),
      ),
    );
  }
}
