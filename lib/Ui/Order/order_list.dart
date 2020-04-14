import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../blocs/getBlocs/Order/getOrderBlocProvider.dart';
import '../../control/style.dart';
import '../../models/order_model.dart';
import '../../widgets/loadingTicketContainer.dart';
import '../../widgets/softText.dart';

class OrderList extends StatefulWidget {
  final int orderId;
  bool value = false;

  OrderList({this.orderId});

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  Widget build(context) {
    final bloc = GetOrderBlocProvider.of(context);

    return StreamBuilder(
      stream: bloc.orders,
      builder: (context, AsyncSnapshot<Map<int, Future<OrderModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingTicketContainer();
        }

        return FutureBuilder(
          future: snapshot.data[widget.orderId],
          builder: (context, AsyncSnapshot<OrderModel> orderSnapshot) {
            if (!orderSnapshot.hasData) {
              return LoadingTicketContainer();
            }

            return buildTile(context, orderSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, OrderModel order) {
    if (order.status == null && order.id == null) {
      return Column(
        children: <Widget>[
          LoadingTicketContainer(),
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExpansionTile(
          onExpansionChanged: (value) {
            setState(() {
              widget.value = value;
            });
          },
          leading: widget.value
              ? Icon(SimpleLineIcons.arrow_up)
              : Icon(SimpleLineIcons.arrow_down),
          title: Text(
            order.eventName,
            style: titleText,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                order.ticketName,
                style: labelTextSmallStyle,
              )
            ],
          ),
          trailing: Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: order.status == 0 ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          children: <Widget>[
            QrImage(
              data: order.qrCode,
              version: 7,
              size: 320,
              gapless: false,
              embeddedImage: AssetImage('assets/images/Logo.png'),
              embeddedImageStyle: QrEmbeddedImageStyle(
                size: Size(150, 150),
              ),
            ),
            SoftText(
              label: "Go to Event",
              onClick: () =>
                  Navigator.pushNamed(context, '/showEvent/${order.eventId}'),
            )
          ],
        ),
      ],
    );
  }
}
