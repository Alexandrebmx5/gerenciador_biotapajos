import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gerenciador_aquifero/models/especie/especie.dart';

class EspecieManager extends ChangeNotifier {

  StreamSubscription _subscription;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  update(){
    allEspecies.clear();

    _subscription?.cancel();
    _getEspecies();
  }

  final List<Especie> allEspecies = [];

  bool loading = false;

  void _getEspecies(){
    loading = true;

    _subscription = firestore.collection('species').snapshots().listen(
            (event) {

          for(final change in event.docChanges){
            switch (change.type) {
              case DocumentChangeType.added:
                allEspecies.add(Especie.fromDocument(change.doc));
                break;
              case DocumentChangeType.modified:
                allEspecies.removeWhere((l) => l.id == change.doc.id);
                allEspecies.add(Especie.fromDocument(change.doc));
                break;
              case DocumentChangeType.removed:
                allEspecies.removeWhere((l) => l.id == change.doc.id);
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