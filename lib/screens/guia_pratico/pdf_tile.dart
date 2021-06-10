import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/models/pdf/pdfFiles.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfTile extends StatefulWidget {
  @override
  _PdfTileState createState() => _PdfTileState();
}

class _PdfTileState extends State<PdfTile> {

  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  List<PdfFiles> _pdfs = [];
  Stream _stream;
  Stream _initStream() {
    return _db.collection('pdf').snapshots();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stream = _initStream();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox();
            } else {
              _pdfs.clear();
              if (snapshot.hasData) {
                snapshot.data.docs.forEach((element) {
                  PdfFiles pdfFiles =
                  PdfFiles(file_url: element.data()['file_url'], id: element.data()['id']);
                  _pdfs.add(pdfFiles);
                });

                return _listView(pdfs: _pdfs);
              } else {
                return SizedBox();
              }
            }
          },
        ));
  }

  _listView({List<PdfFiles> pdfs}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: ListView.builder(
          itemCount: pdfs.length,
          itemBuilder: (context, index) {
            String fullPath =
                _storage.refFromURL(pdfs[index].file_url).fullPath;
            String name = fullPath.split('/').last;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  Icons.file_present,
                  color: primaryColor,
                ),
                title: Text(name, style: TextStyle(color: bgColor)),
                onTap: () {
                  launchURL(url: pdfs[index].file_url);
                },
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red
                  ),
                  child: Text('Excluir'),
                  onPressed: () async {
                    DocumentReference firestoreRef = FirebaseFirestore.instance
                        .collection('pdf')
                        .doc(pdfs[index].id);

                    await firestoreRef.delete();
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void launchURL({String url}) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}