import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerenciador_aquifero/models/user/user.dart';
import 'package:gerenciador_aquifero/stores/user_manager_store.dart';
import 'package:get_it/get_it.dart';

class UserRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  UserUser user;

  Future<void> loadCurrentUser({User firebaseUser}) async {
    final User currentUser = firebaseUser ?? auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('admins').doc(currentUser.uid).get();
      user = UserUser.fromDocument(docUser);

      //user.saveToken();
    }
  }

  // ignore: missing_return
  Future<UserUser> signIn({String email, String password}) async {
    final UserCredential result = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    await loadCurrentUser(firebaseUser: result.user);

    GetIt.I<UserManagerStore>().setUser(user);
  }

  // ignore: missing_return
  Future<UserUser> signUp(UserUser user) async {
    final UserCredential result = await auth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);

    user.id = result.user.uid;
    this.user = user;

    await user.saveData();

    await loadCurrentUser(firebaseUser: result.user);

    //user.saveToken();

    GetIt.I<UserManagerStore>().setUser(user);
  }

  void signOut() {
    auth.signOut();
    user = null;
  }

  void recoverPass(String email) {
    auth.sendPasswordResetEmail(email: email);
  }

  Future<void> save(UserUser user) async {
    await user.save();
  }

  Future<void> update(UserUser user) async {
    await user.save();
  }
}
