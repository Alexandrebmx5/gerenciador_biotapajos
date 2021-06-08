import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class UserUser extends ChangeNotifier {
  UserUser.fromDocument(DocumentSnapshot document) {
    id = document.id;
    nameUser = document.data()['nameUser'] as String;
    userName = document.data()['apelido'] as String;
    email = document.data()['email'] as String;
    created = document.data()['created'] as Timestamp;
  }

  final FirebaseStorage storage = FirebaseStorage.instance;

  Reference get storageRef => storage.ref().child('admins').child(id);

  String id, userName, nameUser, email, password, newPass, idEmpresa;

  Timestamp created;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('admins/$id');

  CollectionReference get tokensReference => firestoreRef.collection('tokens');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'nameUser': nameUser,
      'apelido': userName,
      'email': email,
      'created': FieldValue.serverTimestamp(),
    };
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> save() async {
    loading = true;

    if (id == null) {
      final doc = await firestoreRef.collection('admins').add(toMap());
      id = doc.id;
    } else {
      await firestoreRef.update(toMap());
    }
    loading = false;
  }

  // Future<void> saveToken() async {
  //   final token = await FirebaseMessaging.instance.getToken();
  //   tokensReference.doc(token).set({
  //     'token': token,
  //     'updateAt': FieldValue.serverTimestamp(),
  //     'platform': Platform.operatingSystem
  //   });
  // }

  UserUser(
      {this.id,
      this.userName,
      this.nameUser,
      this.email,
      this.password,
      this.newPass,
      this.created});

  @override
  String toString() {
    return 'UserUser{id: $id, userName: $userName, nameUser: $nameUser, email: $email, created: $created}';
  }
}
