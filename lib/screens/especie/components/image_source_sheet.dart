// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:io';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker_web_redux/image_picker_web_redux.dart';
import 'package:flutter/material.dart';

class ImageSourceSheet extends StatefulWidget {
  final Function(File) onImageSelected;

  ImageSourceSheet({this.onImageSelected});

  @override
  _ImageSourceSheetState createState() => _ImageSourceSheetState(onImageSelected: onImageSelected);
}

class _ImageSourceSheetState extends State<ImageSourceSheet> {

  final Function(File) onImageSelected;

  _ImageSourceSheetState({this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
        builder: (_) =>
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(onPressed: getMultipleImageInfos,
                    child: Text('Escolher imagem')),
                SizedBox(
                  height: 50,
                ),
              ],
            ));
  }



  html.File _cloudFile;
  var _fileBytes;
  Image _imageWidget;

  Future<void> getMultipleImageInfos() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    String mimeType = mime(Path.basename(mediaData.fileName));
    html.File mediaFile =
    new html.File(mediaData.data, mediaData.fileName, {'type': mimeType});

    if (mediaFile != null) {
      setState(() {
        _cloudFile = mediaFile;
        _fileBytes = mediaData.data;
        _imageWidget = Image.memory(mediaData.data);
      });

      final image = File(mediaFile.name);

      onImageSelected(image);
    }
  }
}
