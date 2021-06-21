import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class SuggestionsBloc extends BlocBase {

  final _suggestionsController = BehaviorSubject<List>();


  Stream<List> get outSuggestions => _suggestionsController.stream;

  Map<String, Map<String, dynamic>> _suggestions = {};

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SuggestionsBloc(){
    _addSuggestionsListener();
  }

  void onChangedSearch(String search){
    if(search.trim().isEmpty){
      _suggestionsController.add(_suggestions.values.toList());
    } else {
      _suggestionsController.add(_filter(search.trim()));
    }
  }

  List<Map<String, dynamic>> _filter(String search){
    List<Map<String, dynamic>> filteredUsers = List.from(_suggestions.values.toList());
    filteredUsers.retainWhere((user){
      return user['name'].toUpperCase().contains(search.toUpperCase());
    });
    return filteredUsers;
  }

  void _addSuggestionsListener(){
    _firestore.collection('suggestions').snapshots().listen((snapshot){
      snapshot.docChanges.forEach((change){

        String uid = change.doc.id;

        switch(change.type){
          case DocumentChangeType.added:
            _suggestions[uid] = change.doc.data();
            _subscribeToOrders(uid);
            break;
          case DocumentChangeType.modified:
            _suggestions[uid].addAll(change.doc.data());
            _suggestionsController.add(_suggestions.values.toList());
            break;
          case DocumentChangeType.removed:
            _suggestions.remove(uid);
            _suggestionsController.add(_suggestions.values.toList());
            break;
        }
      });
    });
  }

  void _subscribeToOrders(String uid){
    _suggestions[uid]['suggestions'] = _firestore.collection('users').doc(uid)
        .snapshots().listen((orders)async {

      _suggestionsController.add(_suggestions.values.toList());
    });
  }

  Map<String, dynamic> getUser(String uid){
    return _suggestions[uid];
  }

  @override
  // ignore: must_call_super
  void dispose() {
    _suggestionsController.close();
  }
}