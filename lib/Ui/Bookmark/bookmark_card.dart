import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:testawwpp/Ui/Bookmark/bookmark_list.dart';
import 'package:testawwpp/blocs/getBlocs/Event/getEventBlocProvider.dart';
import 'package:testawwpp/widgets/refresh.dart';

class BookmarkCard extends StatefulWidget {
  @override
  _BookmarkCardState createState() => _BookmarkCardState();
}

class _BookmarkCardState extends State<BookmarkCard>
    with AutomaticKeepAliveClientMixin<BookmarkCard> {
  @override
  Widget build(BuildContext context) {
    final bloc = GetEventBlocProvider.of(context);
    return StreamBuilder(
      stream: bloc.getEventIds,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SpinKitChasingDots(
              color: Colors.grey[700],
              size: 50.0,
            ),
          );
        }
        return Refresh(
          child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index) {
                bloc.getEvent(snapshot.data[index]);
                return BookmarkList(eventId: snapshot.data[index]);
              }),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
