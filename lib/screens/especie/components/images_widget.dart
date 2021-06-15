import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';

class ImagesWidget extends FormField<List> {

  ImagesWidget({
    BuildContext context,
    FormFieldSetter<List> onSaved,
    FormFieldSetter<List> validator,
    List initialValue,
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
              height: 124,
              padding: EdgeInsets.only(top: 16, bottom: 8),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: state.value.map<Widget>((i){
                  return Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      child: i is String ? Image.network(i, fit: BoxFit.cover,):
                          Image.memory(i, fit: BoxFit.cover,),
                      onLongPress: (){
                        state.didChange(state.value..remove(i));
                      },
                    ),
                  );
                }).toList()..add(
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(50),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      height: 100,
                      width: 100,
                      child: Icon(Icons.camera_enhance, color: Colors.grey,),
                    ),
                      onTap: () async {
                        FilePickerResult result = await FilePicker.platform.pickFiles();

                        if (result != null) {
                          Uint8List fileBytes = result.files.first.bytes;
                          state.didChange(state.value..add(fileBytes));
                        }
                      }
                  )
                )
              ),
            ),
            state.hasError ? Text(
              state.errorText,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12
              ),
            ) : Container()
          ],
        ),
      );
    }
  );
}
