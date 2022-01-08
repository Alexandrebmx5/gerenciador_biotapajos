import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/stores/new_subespecie_store.dart';

class SoundWidget extends StatelessWidget {

  SoundWidget(this.store);

  final NewSubEspecieStore store;

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Observer(builder: (_){
                      return ElevatedButton(
                        child: Container(
                            child: store.sound.isEmpty ? Text('Selecione um som', style: TextStyle(color: Colors.black),) : Text('Selecionado', style: TextStyle(color: Colors.black))
                        ),
                        onPressed: () async {
                          FilePickerResult result = await FilePicker.platform.pickFiles();
                          if (result != null) {
                            Uint8List fileBytes = result.files.first.bytes;
                            String name = result.files.first.name;
                            store.setSoundName(name);
                            store.setSound(fileBytes);
                          }
                        },
                      );
                    }),
                  ),
                  if(store.sound.isNotEmpty)...[
                    Container(
                      padding: EdgeInsets.only(top: 16, bottom: 8, left: 10),
                      child: Observer(builder: (_){
                        return ElevatedButton(
                          child: Icon(Icons.remove_circle),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red
                          ),
                          onPressed: () {
                            store.setSoundName(null);
                            store.setSound('');
                          },
                        );
                      }),
                    ),
                  ]
                ],
              )
            ]));
  }
}
