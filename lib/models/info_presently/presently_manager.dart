import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gerenciador_aquifero/models/info_presently/presently.dart';

class PresentlyManager with ChangeNotifier {

  StreamSubscription _subscription;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  update(){
    allPresently.clear();

    _subscription?.cancel();
    _listenToPresently();
  }

  final List<Presently> allPresently = [];

  bool loading = false;

  String _search = '';

  String get search => _search;
  void setSearch(String value){
    _search = value;
    notifyListeners();
  }

  List<Presently> get filteredPresently{
    final List<Presently> filteredPresently = [];

    if(search.isEmpty){
      filteredPresently.addAll(allPresently);
    } else {
      filteredPresently.addAll(allPresently.where((u) => u.title.toLowerCase().contains(search.toLowerCase())));
    }

    return filteredPresently.toList();
  }

  void _listenToPresently(){
    loading = true;
    _subscription = firestore.collection('presently').snapshots().listen(
            (event) {

          for(final change in event.docChanges){
            switch (change.type) {
              case DocumentChangeType.added:
                allPresently.add(Presently.fromDocument(change.doc));
                break;
              case DocumentChangeType.modified:
                allPresently.removeWhere((l) => l.id == change.doc.id);
                allPresently.add(Presently.fromDocument(change.doc));
                break;
              case DocumentChangeType.removed:
                allPresently.removeWhere((l) => l.id == change.doc.id);
                break;
            }
          }
          notifyListeners();
        });


    loading = false;
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

}