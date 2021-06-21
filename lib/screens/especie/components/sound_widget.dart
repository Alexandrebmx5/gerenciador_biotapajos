import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';

class SoundWidget extends FormField<String> {

  SoundWidget({
    BuildContext context,
    FormFieldSetter<String> onSaved,
    FormFieldSetter<String> validator,
    String initialValue,
    bool autoValidate = false,
  }): super(
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
      // ignore: deprecated_member_use
      autovalidate: autoValidate,
      builder: (state) {
        return Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 16, bottom: 8),
                child: ElevatedButton(
                          child: Container(
                            child: state.value == null ? Text('Selecione um som', style: TextStyle(color: Colors.black),) : Text('Selecionado', style: TextStyle(color: Colors.black))
                          ),
                          onPressed: () async {
                            FilePickerResult result = await FilePicker.platform.pickFiles();

                            if (result != null) {
                              Uint8List fileBytes = result.files.first.bytes;
                              state.didChange(fileBytes.toString());
                            }
                          },
                        ),
          )
        ]));
      }
  );
}
