import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {

  ImageDialog({@required this.image, @required this.onDelete});

  final dynamic image;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(image is Uint8List)
            Container(
                height: 200,
                width: 200,
                child: Image.memory(image))
          else Container(
              height: 200,
              width: 200,
              child: Image.network(image)),
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
              onDelete();
            },
            child: Text('Excluir', style: TextStyle(color: Colors.red),),
          )
        ],
      ),
    );
  }
}
