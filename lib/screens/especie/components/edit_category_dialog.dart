import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/blocs/category_bloc.dart';
import 'package:gerenciador_aquifero/common/constants.dart';

class EditCategoryDialog extends StatefulWidget {
  final DocumentSnapshot category;

  EditCategoryDialog({this.category});

  @override
  _EditCategoryDialogState createState() =>
      _EditCategoryDialogState(category: category);
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  final CategoryBloc _categoryBloc;
  final TextEditingController _controller;

  final TextEditingController _controller1;

  _EditCategoryDialogState({DocumentSnapshot category})
      : _categoryBloc = CategoryBloc(category),
        _controller = TextEditingController(
            text: category != null ? category.data()['pt'] : ''),
        _controller1 = TextEditingController(
          text: category != null ? category.data()['en'] : ''
        );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: GestureDetector(
                  onTap: () async {
                    FilePickerResult result = await FilePicker.platform.pickFiles();

                    if (result != null) {
                      Uint8List fileBytes = result.files.first.bytes;

                      _categoryBloc.setImage(fileBytes);
                    }
                  },
                  child: StreamBuilder(
                      stream: _categoryBloc.outImage,
                      builder: (context, snapshot) {
                        if (snapshot.data != null)
                          return Icon(Icons.assignment_turned_in_sharp);
                        else
                          return Icon(Icons.image);
                      }),
                ),
                title: StreamBuilder<String>(
                    stream: _categoryBloc.outTitle,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: _controller,
                        onChanged: _categoryBloc.setTitle,
                        decoration: InputDecoration(
                            errorText: snapshot.hasError ? snapshot.error : null,
                            hintText: 'nome em português'),
                      );
                    }),
                subtitle: StreamBuilder<String>(
                    stream: _categoryBloc.outTitleEn,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: _controller1,
                        onChanged: _categoryBloc.setTitleEn,
                        decoration: InputDecoration(
                            errorText: snapshot.hasError ? snapshot.error : null,
                            hintText: 'nome em inglês'),
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  StreamBuilder<bool>(
                      stream: _categoryBloc.outDelete,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return Container();
                        return TextButton(
                          child: Text('Excluir'),
                          style: TextButton.styleFrom(primary: Colors.red),
                          onPressed: snapshot.data
                              ? () {
                                  _categoryBloc.delete();
                                  Navigator.of(context).pop();
                                }
                              : null,
                        );
                      }),
                  StreamBuilder<bool>(
                      stream: _categoryBloc.submitValid,
                      builder: (context, snapshot) {
                        return TextButton(
                          child: Text('Salvar'),
                          style: TextButton.styleFrom(primary: bgColor),
                          onPressed: snapshot.hasData
                              ? () async {
                                  await _categoryBloc.saveData();
                                  Navigator.of(context).pop();
                                }
                              : null,
                        );
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
