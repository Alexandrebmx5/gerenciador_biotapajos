import 'package:flutter/cupertino.dart';

class PdfFiles {
  String _file_url;
  String _id;

  PdfFiles({@required String file_url, String id}) {
    this._file_url = file_url;
    this._id = id;
  }

  String get file_url => _file_url;

  String get id => _id;

  set file_url(String file_url) {
    _file_url = file_url;
  }

  set id(String id) {
    _id = id;
  }
}