import 'package:flutter/material.dart';
import 'package:testawwpp/Ui/Event/showEvent.dart';
import 'package:testawwpp/Ui/Screens/navigation_screen.dart';
import 'package:testawwpp/Ui/Screens/tickets.dart';
import 'package:testawwpp/Ui/Ticket/ticket_screen.dart';
import 'package:testawwpp/Ui/credentials/login_screen.dart';
import 'package:testawwpp/Ui/credentials/register_screen.dart';
import 'package:testawwpp/Ui/credentials/splash_screen.dart';

const String homeRoute = '/home';
const String registerRoute = '/register';
const String loginRoute = '/login';
const String profileRoute = '/home/profile';
const String navigationRoute = '/navigation';

const String splashRoute = "/";
const String menuRoute = '/home/menu';
const String createEventRoute = '/home/createEvent';
const String createTicketRoute = '/home/createTicket';

MaterialPageRoute routes(RouteSettings settings) {
  switch (settings.name) {
    case splashRoute:
      return MaterialPageRoute(builder: (context) => SplashScreenQuiket());
      break;
    case loginRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());
      break;
    case registerRoute:
      return MaterialPageRoute(builder: (context) => RegisterScreen());
      break;
    case navigationRoute:
      return MaterialPageRoute(builder: (context) => NavigationScreen());
      break;
    default:
      return MaterialPageRoute(builder: (context) {
        final routing = settings.name;
        //Nav Screen
        if (routing.startsWith('/showEvent/')) {
          var value = routing.replaceFirst('/showEvent/', '');
          int eventId = int.parse(value);
          return ShowEvent(
            eventId: eventId,
          );
        }
        if (routing.startsWith('/showTicket/')) {
          var value = routing.replaceFirst('/showTicket/', '');
          int eventId = int.parse(value);
          return TicketBuyScreen(
            eventId: eventId,
          );
        } else {
          return null;
        }
      });
  }
}
