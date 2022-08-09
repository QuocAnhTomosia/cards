import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';

// ignore: must_be_immutable
class MyDiaLog extends StatelessWidget {
  late String imgLink;
  late BuildContext parentContext;
  MyDiaLog({Key? key, required imgLink, required parentContext})
      : super(key: key) {
    imgLink = imgLink;
    parentContext = parentContext;
  }

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
            var imageId = await ImageDownloader.downloadImage(imgLink);

            if (imageId == null) {
              return;
            }
            // Below is a method of obtaining saved image information.
            // ignore: use_build_context_synchronously
            Navigator.pop(context, 'Cancel');
          },
          child: const Text('Download'),
        ),
      ],
    );
  }
}
