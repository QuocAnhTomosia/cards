import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yugi_oh_cards/bloc/sign_up/bloc/user_sign_up_bloc.dart';
import 'package:yugi_oh_cards/commons/password_input.dart';
import 'package:yugi_oh_cards/commons/text_input.dart';
import 'dart:async';
import 'dart:io';

import 'package:yugi_oh_cards/cubit/image_cubit.dart';
import 'package:yugi_oh_cards/models/sign_up_model.dart';

class AvatarPicker extends StatefulWidget {
  const AvatarPicker({Key? key}) : super(key: key);

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  XFile? imageFile;
  //imageError de xu ly error
  dynamic _pickImageError;
  _getFromGallery() async {
    try {
      final imagePicker =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      // ignore: use_build_context_synchronously, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      context.read<ImageCubit>().emit(File(imagePicker!.path));
      setState(() {
        imageFile = imagePicker;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: _getFromGallery,
          child: imageFile != null
              ? Image.file(
                  fit: BoxFit.cover,
                  File(imageFile!.path),
                  height: 150.0,
                  width: 100.0,
                )
              : Image.network(
                  'https://st2.depositphotos.com/1833015/8776/i/450/depositphotos_87766636-stock-photo-dog-breed-welsh-corgi-pembroke.jpg'),
        ));
  }
}

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _reEnterPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AvatarPicker(),
            TextInputWidget(
              text: "Enter your name",
              controller: _emailController,
            ),
            TextInputWidget(
              text: "Enter your email",
              controller: _name,
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
            BlocBuilder<UserSignUpBloc, UserSignUpState>(
              builder: (context, state) {
                return ElevatedButton(
                    onPressed: () {
                      context.read<UserSignUpBloc>().add(UserSignUpSubmit(
                          info: SignUpInfo(
                              name: _name.text,
                              email: _emailController.text,
                              image: File(context.read<ImageCubit>().state.path),
                              phoneNumber: _phone.text,
                              password: _password.text)));
                    },
                    child: Text(tr("submit")));
              },
            ),
          ],
        ),
      ),
    );
  }
}
