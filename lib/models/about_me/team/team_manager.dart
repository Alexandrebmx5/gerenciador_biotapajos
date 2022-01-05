import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gerenciador_aquifero/models/about_me/team/team.dart';

class TeamManager with ChangeNotifier {

  StreamSubscription _subscription;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  update(){
    allTeam.clear();

    _subscription?.cancel();
    _listenToTeam();
  }

  final List<Team> allTeam = [];

  bool loading = false;

  String _search = '';

  String get search => _search;
  void setSearch(String value){
    _search = value;
    notifyListeners();
  }

  List<Team> get filteredTeam {
    final List<Team> filteredTeam = [];

    if(search.isEmpty){
      filteredTeam.addAll(allTeam);
    } else {
      filteredTeam.addAll(allTeam.where((u) => u.name.toLowerCase().contains(search.toLowerCase())));
    }

    return filteredTeam.toList();
  }

  void _listenToTeam(){
    loading = true;
    _subscription = firestore.collection('name_team').snapshots().listen(
            (event) {

          for(final change in event.docChanges){
            switch (change.type) {
              case DocumentChangeType.added:
                allTeam.add(Team.fromDocument(change.doc));
                break;
              case DocumentChangeType.modified:
                allTeam.removeWhere((l) => l.id == change.doc.id);
                allTeam.add(Team.fromDocument(change.doc));
                break;
              case DocumentChangeType.removed:
                allTeam.removeWhere((l) => l.id == change.doc.id);
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