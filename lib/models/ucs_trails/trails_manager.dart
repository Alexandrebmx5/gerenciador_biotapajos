import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gerenciador_aquifero/models/ucs_trails/trails.dart';

class TrailsManager with ChangeNotifier {

  StreamSubscription _subscription;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  update(){
    allTrails.clear();

    _subscription?.cancel();
    _listenToTrails();
  }

  final List<Trails> allTrails = [];

  bool loading = false;

  String _search = '';

  String get search => _search;
  void setSearch(String value){
    _search = value;
    notifyListeners();
  }

  List<Trails> get filteredTrails {
    final List<Trails> filteredTrails = [];

    if(search.isEmpty){
      filteredTrails.addAll(allTrails);
    } else {
      filteredTrails.addAll(allTrails.where((u) => u.title.toLowerCase().contains(search.toLowerCase())));
    }

    return filteredTrails.toList();
  }

  void _listenToTrails(){
    loading = true;
    _subscription = firestore.collection('trails').snapshots().listen(
            (event) {

          for(final change in event.docChanges){
            switch (change.type) {
              case DocumentChangeType.added:
                allTrails.add(Trails.fromDocument(change.doc));
                break;
              case DocumentChangeType.modified:
                allTrails.removeWhere((l) => l.id == change.doc.id);
                allTrails.add(Trails.fromDocument(change.doc));
                break;
              case DocumentChangeType.removed:
                allTrails.removeWhere((l) => l.id == change.doc.id);
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