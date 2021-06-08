// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

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
          builder: (_) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(onPressed: _getImgFile, child: Text('Escolher imagem')),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ));
  }

  Future<void> _getImgFile() async {
    html.File infos = await ImagePickerWeb.getImage(outputType: ImageType.file);
    if(infos == null) return;
    final image = File(infos.relativePath);
    onImageSelected(image);
  }
}
