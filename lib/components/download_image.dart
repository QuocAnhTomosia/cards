import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class MyDiaLog extends StatelessWidget {
  final String imgLink;
  final BuildContext parentContext;
  const MyDiaLog({
    Key? key,
    required this.imgLink,
    required this.parentContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Download'),
      content: const Text('Do you want to download this picture'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            // Saved with this method.

            Permission permissions = Platform.isAndroid == true
                ? Permission.storage
                : Permission.photos;
            PermissionStatus permissionStatus = await permissions.request();
            if (permissionStatus.isGranted) {
              var imageId = await ImageDownloader.downloadImage(imgLink);
              if (imageId == null) {
                return;
              } else if (permissionStatus.isPermanentlyDenied) {
                openAppSettings();
              }
              // ignore: use_build_context_synchronously
              Navigator.pop(context, 'Cancel');
            }
          },
          child: const Text('Download'),
        ),
      ],
    );
  }
}
