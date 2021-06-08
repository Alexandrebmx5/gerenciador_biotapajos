import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerenciador_aquifero/helpers/firebase.error.dart';
import 'package:gerenciador_aquifero/helpers/extensions.dart';
import 'package:gerenciador_aquifero/repository/user_repository.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email.isEmailValid();
  String get emailError =>
      email == null || emailValid ? null : 'E-mail inválido';

  @observable
  String password;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get passwordValid => password != null && password.length >= 4;
  String get passwordError =>
      password == null || passwordValid ? null : 'Senha inválida';

  @computed
  Function get loginPressed =>
      emailValid && passwordValid && !loading ? _login : null;

  @computed
  Function get recoverPassword => _recover;

  @observable
  bool loading = false;

  @observable
  String error;

  @action
  Future<void> _login() async {
    loading = true;
    error = null;

    try {
      await UserRepository().signIn(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      error = getErrorString(e.code);
    }

    loading = false;
  }

  @action
  Future<void> _recover() async {
    loading = true;
    error = null;

    if (email != null) {
      UserRepository().recoverPass(email);
    } else {
      error = 'Coloque seu email!';
    }

    loading = false;
  }
}
