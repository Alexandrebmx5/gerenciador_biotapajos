import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerenciador_aquifero/models/user/user.dart';
import 'package:gerenciador_aquifero/repository/user_repository.dart';
import 'package:mobx/mobx.dart';

part 'user_manager_store.g.dart';

class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  _UserManagerStore() {
    _loadCurrentUser();
  }

  @observable
  UserUser user;

  @action
  void setUser(UserUser value) => user = value;

  @computed
  bool get isLoggedIn => user != null;

  Future<void> _loadCurrentUser({User firebaseUser}) async {
    final User currentUser = firebaseUser ?? auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('admins').doc(currentUser.uid).get();
      user = UserUser.fromDocument(docUser);

      //user.saveToken();
      setUser(user);
    }
  }

  Future<void> logout() async {
    UserRepository().signOut();
    setUser(null);
  }
}
