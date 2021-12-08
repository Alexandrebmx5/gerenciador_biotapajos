import 'dart:async';
import 'dart:typed_data';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class PdfBloc extends BlocBase {

  final FirebaseStorage storage = FirebaseStorage.instance;

  // ignore: non_constant_identifier_names
  final _pt_titleController = BehaviorSubject<String>();
  final _pdfController = BehaviorSubject();
  final _deleteController = BehaviorSubject<bool>();

  Stream get outPdf => _pdfController.stream;
  Stream<bool> get outDelete => _deleteController.stream;

  Stream<String> get outTitle => _pt_titleController.stream.transform(
      StreamTransformer<String, String>.fromHandlers(
          handleData: (title, sink) {
            if (title.isEmpty)
              sink.addError("Insira uma descrição");
            else
              sink.add(title);
          }));

  Stream<bool> get submitValid =>
      Rx.combineLatest2(outTitle, outPdf, (a, b) => true);

  DocumentSnapshot pdf;

  Uint8List image;
  // ignore: non_constant_identifier_names
  String pt_title;

  PdfBloc(this.pdf) {
    if (pdf != null) {
      _pdfController.add(pdf.data()['file_url']);
      _deleteController.add(true);
    } else {
      _deleteController.add(false);
    }
  }

  void setImage(Uint8List fileBytes) {
    image = fileBytes;
    _pdfController.add(fileBytes);
  }

  void setTitle(String title) {
    this.pt_title = title;
    _pt_titleController.add(title);
  }

  void delete() {
    pdf.reference.delete();
  }

  Future saveData() async {
    if (image == null && pdf != null)
      return;

    Map<String, dynamic> dataToUpdate = {};

    final filePath = '$pt_title.pdf';

    if (image != null) {
      final UploadTask task = storage.refFromURL('gs://appbiotapajos-3d160.appspot.com/pdf')
          .child(filePath)
          .putData(image);
      final TaskSnapshot snapshot = await task;
      final String url = await snapshot.ref.getDownloadURL();
      dataToUpdate['file_url'] = url;
    }

    if (pdf == null || pt_title != pdf.data()["descricao"]) {
      dataToUpdate["descricao"] = pt_title;
    }

    if (pdf == null) {
      final doc = await FirebaseFirestore.instance
          .collection("pdf")
          .add(dataToUpdate);

      DocumentReference firestoreRef = FirebaseFirestore.instance
          .collection('pdf')
          .doc(doc.id);

      await firestoreRef.update({'id': doc.id});

    } else {
      await pdf.reference.update(dataToUpdate);
    }
  }

  @override
  // ignore: must_call_super
  void dispose() {
    _pdfController.close();
    _deleteController.close();
  }
}
