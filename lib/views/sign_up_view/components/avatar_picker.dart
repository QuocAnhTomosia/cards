import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yugi_oh_cards/components/constant.dart';
import 'package:yugi_oh_cards/cubit/image_cubit.dart';

class AvatarPicker extends StatefulWidget {
  const AvatarPicker({Key? key}) : super(key: key);

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  XFile? imageFile;
  //imageError de xu ly error

  _getFromGallery() async {
    if (Platform.isAndroid) {
      PermissionStatus permissions = await Permission.storage.request();

      if (permissions.isGranted) {
        final imagePicker =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        // ignore: use_build_context_synchronously, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
        context.read<ImageCubit>().emit(File(imagePicker!.path));
        setState(() {
          imageFile = imagePicker;
        });
      } else if (permissions.isDenied) {
      } else if (permissions.isPermanentlyDenied) {
        openAppSettings();
      }
    } else {
      PermissionStatus permissions = await Permission.photos.request();
      if (permissions.isGranted) {
        final imagePicker =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        // ignore: use_build_context_synchronously, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
        context.read<ImageCubit>().emit(File(imagePicker!.path));
        setState(() {
          imageFile = imagePicker;
        });
      } else if (permissions.isLimited) {
        openAppSettings();
      } else if (permissions.isRestricted) {
        openAppSettings();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50, // Image radius
          backgroundImage: imageFile != null
              ? FileImage(
                  File(imageFile!.path),
                ) as ImageProvider
              : AssetImage(Constant().avatarImage),
        ),
        ElevatedButton(
            onPressed: _getFromGallery,
            child: const Text("Choose your Avatar")),
      ],
    );
  }
}
