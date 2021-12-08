import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/blocs/pdf_bloc.dart';
import 'package:gerenciador_aquifero/common/constants.dart';

class AddPdf extends StatefulWidget {
  final DocumentSnapshot pdf;

  AddPdf({this.pdf});

  @override
  _AddPdfState createState() =>
      _AddPdfState(pdf: pdf);
}

class _AddPdfState extends State<AddPdf> {
  final PdfBloc _pdfBloc;

  final TextEditingController _controller;

  _AddPdfState({DocumentSnapshot pdf})
      : _pdfBloc = PdfBloc(pdf),
        _controller = TextEditingController(
            text: pdf != null ? pdf.data()['descricao'] : '');

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
                title: GestureDetector(
                  onTap: () async {
                    FilePickerResult result = await FilePicker.platform.pickFiles();

                    if (result != null) {
                      Uint8List fileBytes = result.files.first.bytes;

                      _pdfBloc.setImage(fileBytes);
                    }
                  },
                  child: StreamBuilder(
                      stream: _pdfBloc.outPdf,
                      builder: (context, snapshot) {
                        if (snapshot.data != null)
                          return Text('Arquivo Selecionado');
                        else
                          return Text('Selecionar arquivo');
                      }),
                ),
                subtitle: StreamBuilder<String>(
                    stream: _pdfBloc.outTitle,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: _controller,
                        onChanged: _pdfBloc.setTitle,
                        decoration: InputDecoration(
                            errorText: snapshot.hasError ? snapshot.error : null,
                            hintText: 'Descrição'),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    StreamBuilder<bool>(
                        stream: _pdfBloc.submitValid,
                        builder: (context, snapshot) {
                          return TextButton(
                            child: Text('Salvar'),
                            style: TextButton.styleFrom(primary: bgColor),
                            onPressed: snapshot.hasData
                                ? () async {
                              await _pdfBloc.saveData();
                              Navigator.of(context).pop();
                            }
                                : null,
                          );
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
