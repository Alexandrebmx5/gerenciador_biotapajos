import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gerenciador_aquifero/models/about_me/collaborators/collaborators.dart';

class CollaboratorsManager with ChangeNotifier {

  StreamSubscription _subscription;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  update(){
    allCollaborators.clear();

    _subscription?.cancel();
    _listenToTeam();
  }

  final List<Collaborators> allCollaborators = [];

  bool loading = false;

  String _search = '';

  String get search => _search;
  void setSearch(String value){
    _search = value;
    notifyListeners();
  }

  List<Collaborators> get filteredCollaborators {
    final List<Collaborators> filteredCollaborators = [];

    if(search.isEmpty){
      filteredCollaborators.addAll(allCollaborators);
    } else {
      filteredCollaborators.addAll(allCollaborators.where((u) => u.name.toLowerCase().contains(search.toLowerCase())));
    }

    return filteredCollaborators.toList();
  }

  void _listenToTeam(){
    loading = true;
    _subscription = firestore.collection('collaborators').snapshots().listen(
            (event) {

          for(final change in event.docChanges){
            switch (change.type) {
              case DocumentChangeType.added:
                allCollaborators.add(Collaborators.fromDocument(change.doc));
                break;
              case DocumentChangeType.modified:
                allCollaborators.removeWhere((l) => l.id == change.doc.id);
                allCollaborators.add(Collaborators.fromDocument(change.doc));
                break;
              case DocumentChangeType.removed:
                allCollaborators.removeWhere((l) => l.id == change.doc.id);
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