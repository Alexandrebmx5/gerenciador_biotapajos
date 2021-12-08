import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gerenciador_aquifero/models/suggestions/suggestions.dart';
import 'package:rxdart/rxdart.dart';

class SuggestionsBloc extends BlocBase {

  final _suggestionsController = BehaviorSubject<List>();


  Stream<List> get outSuggestions => _suggestionsController.stream;

  List<Suggestions> _suggestions = [];

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SuggestionsBloc(){
    _addSuggestionsListener();
  }

  void onChangedSearch(String search){
    if(search.trim().isEmpty){
      _suggestionsController.add(_suggestions.toList());
    } else {
      _suggestionsController.add(_filter(search.trim()));
    }
  }

  List<Suggestions> _filter(String search){
    List<Suggestions> filteredUsers = List.from(_suggestions.toList());
    filteredUsers.retainWhere((user){
      return user.name.toUpperCase().contains(search.toUpperCase());
    });
    return filteredUsers.toList();
  }

  void _addSuggestionsListener(){
    _firestore.collection('suggestions').snapshots().listen((snapshot){
      snapshot.docChanges.forEach((change){
        switch (change.type) {
          case DocumentChangeType.added:
            _suggestions.add(Suggestions.fromDocument(change.doc));
            _suggestionsController.add(_suggestions.toList());
            break;
          case DocumentChangeType.modified:
            _suggestions.removeWhere((l) => l.id == change.doc.id);
            _suggestions.add(Suggestions.fromDocument(change.doc));
            _suggestionsController.add(_suggestions.toList());
            break;
          case DocumentChangeType.removed:
            _suggestions.removeWhere((l) => l.id == change.doc.id);
            _suggestionsController.add(_suggestions.toList());
            break;
        }
      });
    });
  }

  @override
  // ignore: must_call_super
  void dispose() {
    _suggestionsController.close();
  }
}