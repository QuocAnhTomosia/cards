import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';

class MyDiaLog extends StatelessWidget {
  late String img_link;
  late BuildContext parentContext;
  MyDiaLog({Key? key, required img_link, required parentContext})
      : super(key: key) {
    this.img_link = img_link;
    this.parentContext = parentContext;
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
            try {
              // Saved with this method.
              var imageId = await ImageDownloader.downloadImage(this.img_link);

              if (imageId == null) {
                return;
              }
              // Below is a method of obtaining saved image information.
              var fileName = await ImageDownloader.findName(imageId);
              var path = await ImageDownloader.findPath(imageId);
              var size = await ImageDownloader.findByteSize(imageId);
              var mimeType = await ImageDownloader.findMimeType(imageId);
              Navigator.pop(context, 'Cancel');
            } catch (error) {
              print(error);
            }
          },
          child: const Text('Download'),
        ),
      ],
    );
  }
}