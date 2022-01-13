import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gerenciador_aquifero/models/info_presently/infos.dart';

class InfosManager with ChangeNotifier {

  StreamSubscription _subscription;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  update(){
    allInfos.clear();

    _subscription?.cancel();
    _listenToInfos();
  }

  final List<Infos> allInfos = [];

  bool loading = false;

  String _search = '';

  String get search => _search;
  void setSearch(String value){
    _search = value;
    notifyListeners();
  }

  List<Infos> get filteredInfos {
    final List<Infos> filteredInfos = [];

    if(search.isEmpty){
      filteredInfos.addAll(allInfos);
    } else {
      filteredInfos.addAll(allInfos.where((u) => u.title.toLowerCase().contains(search.toLowerCase())));
    }

    return filteredInfos.toList();
  }

  void _listenToInfos(){
    loading = true;
    _subscription = firestore.collection('infos').snapshots().listen(
            (event) {

          for(final change in event.docChanges){
            switch (change.type) {
              case DocumentChangeType.added:
                allInfos.add(Infos.fromDocument(change.doc));
                break;
              case DocumentChangeType.modified:
                allInfos.removeWhere((l) => l.id == change.doc.id);
                allInfos.add(Infos.fromDocument(change.doc));
                break;
              case DocumentChangeType.removed:
                allInfos.removeWhere((l) => l.id == change.doc.id);
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