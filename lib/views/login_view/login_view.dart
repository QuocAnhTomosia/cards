import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yugi_oh_cards/bloc/favorites/bloc/favorites_bloc.dart';
import 'package:yugi_oh_cards/bloc/home_bloc/bloc/home_event.dart';
import 'package:yugi_oh_cards/bloc/log_in/bloc/log_in_bloc.dart';
import 'package:yugi_oh_cards/bloc/shopping_cart/bloc/shopping_cart_bloc.dart';
import 'package:yugi_oh_cards/components/constant.dart';
import 'package:yugi_oh_cards/components/password_input.dart';
import 'package:yugi_oh_cards/components/text_input.dart';

import '../../bloc/home_bloc/bloc/home_bloc.dart';
import '../../bloc/log_in/bloc/log_in_state.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Constant.decoration,
          title: const Text("Login "),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        body: Column(
          children: <Widget>[
            TextInputWidget(
              text: "Enter your email",
              controller: _emailController,
            ),
            PassWordWidget(
              hintText: "Enter your password",
              passwordController: _passwordController,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/sign_up');
              },
              child: const SizedBox(
                  width: 80, child: Center(child: Text("Sign up"))),
            ),
            BlocListener<LogInBloc, LogInState>(
              listener: (context, state) {
                if (state.status == LogInStatus.success) {
                  context.read<HomeBloc>().add(const HomeSubmit());
                  context
                      .read<FavoritesBloc>()
                      .add(FavoritesLoad(ids: state.myUser!.favorites));
                  context
                      .read<ShoppingCartBloc>()
                      .add(ShoppingCartLoad(state.myUser!.orderList));
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/home_page", (route) => false);
                }
                if (state.status == LogInStatus.error) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Error happend"),
                            content: Text(state.message!),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Cancel');
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          ));
                  context.read<LogInBloc>().add(const LogInReset());
                }
              },
              child: ElevatedButton(
                  onPressed: () async {
                    context.read<LogInBloc>().add(LogInSubmit(
                        email: _emailController.text,
                        password: _passwordController.text));
                  },
                  child: SizedBox(
                      width: 80, child: Center(child: Text(tr("submit"))))),
            ),
          ],
        ));
  }
}
