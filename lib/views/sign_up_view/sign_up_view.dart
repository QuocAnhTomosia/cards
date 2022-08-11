import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yugi_oh_cards/bloc/sign_up/bloc/user_sign_up_bloc.dart';
import 'package:yugi_oh_cards/components/constant.dart';
import 'package:yugi_oh_cards/components/password_input.dart';
import 'package:yugi_oh_cards/components/text_input.dart';
import 'dart:io';

import 'package:yugi_oh_cards/cubit/image_cubit.dart';

import 'components/avatar_picker.dart';

// sua thanh Inherited

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _reEnterPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Constant.decoration,
        title: Text(tr("Sign up")),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            const AvatarPicker(),
            TextInputWidget(
              text: "Enter your name",
              controller: _name,
            ),
            TextInputWidget(
              text: "Enter your email",
              controller: _emailController,
            ),
            TextInputWidget(
              text: "Enter your phoneNumber",
              controller: _phone,
            ),
            PassWordWidget(
              hintText: 'enter your password',
              passwordController: _password,
            ),
            PassWordWidget(
                hintText: 're enter your password',
                passwordController: _reEnterPassword),
            BlocListener<UserSignUpBloc, UserSignUpState>(
              child: ElevatedButton(
                onPressed: (() {
                  context.read<UserSignUpBloc>().add(UserSignUpSubmit(
                      name: _name.text,
                      email: _emailController.text,
                      phoneNumber: _phone.text,
                      password: _password.text,
                      image: File(context.read<ImageCubit>().state.path)));
                }),
                child: SizedBox(
                    width: size.width * 0.15,
                    child: Center(child: Text(tr("submit")))),
              ),
              listener: (context, state) {
                switch (state.status) {
                  case SignUpStatus.submit:
                    {
                      Navigator.pushNamed(context, '/log_in');
                    }
                    break;
                  case SignUpStatus.error:
                    {
                      showDialog(
                          context: context,
                          builder: ((context) => AlertDialog(
                                title: const Text("please check Sign up Info"),
                                content: Text(state.error),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              )));
                    }
                    break;
                  default:
                    {}
                    break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
