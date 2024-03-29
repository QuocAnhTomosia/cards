import 'package:flutter/material.dart';
import 'package:yugi_oh_cards/views/home_view/cards_buy_view.dart';
import 'package:yugi_oh_cards/views/search_view/search_view.dart';
import 'package:yugi_oh_cards/views/sign_up_view/sign_up_view.dart';

import '../views/login_view/login_view.dart';
import '../views/home_view/home_page_view.dart';
import '../views/settings_view/settings_view.dart';
import '../views/start_view/start_view.dart';

class NamedRouter {
  static Map<String, WidgetBuilder> routes = {
    '/sign_up': ((context) => SignUpView()),
    '/start_view': ((context) => const StartView()),
    '/home_page': (context) => HomePageview(),
    '/log_in': (context) => LoginView(),
    '/search': ((context) => SearchWiew()),
    '/settings': ((context) => SettingsView()),
    '/cards_buy': (context) => const CardsBuyViews(),
  };
}
