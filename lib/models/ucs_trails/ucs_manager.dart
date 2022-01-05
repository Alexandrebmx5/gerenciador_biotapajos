import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gerenciador_aquifero/models/ucs_trails/ucs.dart';

class UcsManager with ChangeNotifier {

  StreamSubscription _subscription;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  update(){
    allUcs.clear();

    _subscription?.cancel();
    _listenToUcs();
  }

  final List<Ucs> allUcs = [];

  bool loading = false;

  String _search = '';

  String get search => _search;
  void setSearch(String value){
    _search = value;
    notifyListeners();
  }

  List<Ucs> get filteredUcs {
    final List<Ucs> filteredUcs = [];

    if(search.isEmpty){
      filteredUcs.addAll(allUcs);
    } else {
      filteredUcs.addAll(allUcs.where((u) => u.title.toLowerCase().contains(search.toLowerCase())));
    }

    return filteredUcs.toList();
  }

  void _listenToUcs(){
    loading = true;
    _subscription = firestore.collection('ucs').snapshots().listen(
            (event) {

          for(final change in event.docChanges){
            switch (change.type) {
              case DocumentChangeType.added:
                allUcs.add(Ucs.fromDocument(change.doc));
                break;
              case DocumentChangeType.modified:
                allUcs.removeWhere((l) => l.id == change.doc.id);
                allUcs.add(Ucs.fromDocument(change.doc));
                break;
              case DocumentChangeType.removed:
                allUcs.removeWhere((l) => l.id == change.doc.id);
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