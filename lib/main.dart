import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:yugi_oh_cards/bloc/favorites/bloc/favorites_bloc.dart';
import 'package:yugi_oh_cards/bloc/log_in/bloc/log_in_bloc.dart';
import 'package:yugi_oh_cards/bloc/shopping_cart/bloc/shopping_cart_bloc.dart';
import 'package:yugi_oh_cards/bloc/sign_up/bloc/user_sign_up_bloc.dart';
import 'package:yugi_oh_cards/cubit/image_cubit.dart';
import 'package:yugi_oh_cards/cubit/unique_id_cubit.dart';
import 'package:yugi_oh_cards/routes/route_names.dart';

import 'bloc/cards_searching/cards_searching_bloc.dart';
import 'bloc/home_bloc/bloc/home_bloc.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(); //
  runApp(
    EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const [
          Locale('en'),
          Locale('vi'),
          Locale('fr'),
        ],
        child: const YugiOh()),
  );
  FlutterNativeSplash.remove();
}

class YugiOh extends StatelessWidget {
  const YugiOh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UniqueIdCubit>(create: (context) =>UniqueIdCubit()),
        BlocProvider<ShoppingCartBloc>(create: (context) => ShoppingCartBloc()),
        BlocProvider<FavoritesBloc>(create: (context) =>FavoritesBloc()),
        BlocProvider<HomeBloc>(create: ((context) => HomeBloc())),
        BlocProvider<LogInBloc>(create: ((context) => LogInBloc())),
        BlocProvider<UserSignUpBloc>(create: ((context) => UserSignUpBloc())),
        BlocProvider<ImageCubit>(
            create: (BuildContext context) => ImageCubit()),
        BlocProvider<CardsSearchingBloc>(
          create: (BuildContext context) => CardsSearchingBloc(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        initialRoute: '/start_view',
        routes: NamedRouter.routes,
      ),
    );
  }
}
