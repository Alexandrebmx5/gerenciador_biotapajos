import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/screens/base/base_screen.dart';
import 'package:gerenciador_aquifero/stores/login_store.dart';
import 'package:gerenciador_aquifero/stores/user_manager_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginStore loginStore = LoginStore();

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  void initState() {
    super.initState();

    when((_) => userManagerStore.user != null, () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => BaseScreen()),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/fundo.png'),
          fit: BoxFit.cover
        )
      ),
      child: SafeArea(
        child: Center(child: Observer(builder: (_) {
          if (loginStore.loading)
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(secondaryColor),
            );
          else
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                width: 400,
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Container(
                          height: 100,
                          width: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/logo.png'))),
                        ),
                      ),
                      Observer(builder: (_) {
                        return Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: TextFormField(
                              onChanged: loginStore.setEmail,
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  errorText: loginStore.emailError,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: primaryColor,
                                  ),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(color: bgColor)),
                            ));
                      }),
                      Observer(builder: (_) {
                        return Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: TextFormField(
                              onChanged: loginStore.setPassword,
                              autocorrect: false,
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  errorText: loginStore.passwordError,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: primaryColor,
                                  ),
                                  hintStyle: TextStyle(color: bgColor),
                                  hintText: 'Senha'),
                            ));
                      }),
                      Observer(builder: (_) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: loginStore.recoverPassword,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Text(
                                  'Esqueceu sua senha?',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Principal'),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                      Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ButtonBar(
                              children: [
                                Observer(builder: (_) {
                                  return SizedBox(
                                    height: 44,
                                    width: 100,
                                    // ignore: deprecated_member_use
                                    child: RaisedButton(
                                      disabledColor: primaryColor,
                                      color: primaryColor,
                                      elevation: 8,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                      ),
                                      onPressed: loginStore.loginPressed,
                                      child: const Text('ENTRAR', style: TextStyle(color: Colors.white),),
                                    ),
                                  );
                                })
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
        })),
      ),
    );
  }
}
