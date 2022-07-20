import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:yugi_oh_cards/providers/lang_provider.dart';
import 'package:yugi_oh_cards/views/search_view.dart';
import 'package:yugi_oh_cards/views/start_view.dart';

import 'bloc/cards_searching_bloc.dart';

void main() => runApp(const YugiOh());

class YugiOh extends StatelessWidget {
  const YugiOh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CardsSearchingBloc>(
          
          create: (BuildContext context) => CardsSearchingBloc(),
        ),
       
      ],
      child: MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => LanguageProvider(current: "en"))],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const StartView(),
            '/search': ((context) => const SearchView())
          },
        ),
      ),
    );
  }
}
