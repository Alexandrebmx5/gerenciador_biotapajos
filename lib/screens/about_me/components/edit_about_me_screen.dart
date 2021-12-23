import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/models/about_me/about_me_historic.dart';
import 'package:gerenciador_aquifero/screens/about_me/components/image_filed_about.dart';
import 'package:gerenciador_aquifero/stores/about_me_store.dart';
import 'package:gerenciador_aquifero/stores/edit_about_me_store.dart';
import 'package:mobx/mobx.dart';

class EditAboutMeScreen extends StatefulWidget {
  EditAboutMeScreen(this.aboutMeHistoric);

  final AboutMeHistoric aboutMeHistoric;

  @override
  _EditAboutMeScreenState createState() => _EditAboutMeScreenState(aboutMeHistoric);
}

class _EditAboutMeScreenState extends State<EditAboutMeScreen> {

  _EditAboutMeScreenState(AboutMeHistoric aboutMeHistoric)
      : editing = aboutMeHistoric != null,
        store = EditAboutMeStore(aboutMeHistoric: aboutMeHistoric);

  bool editing;

  final EditAboutMeStore store;

  @override
  void initState() {
    super.initState();

    when((_) => store.saveAbout == true, () {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Dados atualizados com sucesso!'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          border: InputBorder.none,
          labelText: label,
          labelStyle: TextStyle(color: Colors.black));
    }

    final _fieldStyle = TextStyle(color: Colors.black, fontSize: 16);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Nossa história e conheça o IAA', style: TextStyle(color: secondaryColor)),
        backgroundColor: primaryColor,
        actions: [
          Observer(builder: (_) {
            return Padding(
              padding:
              const EdgeInsets.only(right: 20, bottom: 10, top: 10),
              child: ElevatedButton(
                  onPressed: store.sendPressed,
                  style: ElevatedButton.styleFrom(primary: bgBlue),
                  child: Text('Salva')),
            );
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Observer(
          builder: (_){
            if (store.loading)
              return Padding(
                padding: const EdgeInsets.all(100),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(primaryColor)),
                      SizedBox(height: 5),
                      Text(
                        'Salvando',
                        style: _fieldStyle,
                      )
                    ],
                  ),
                ),
              );
            else
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: defaultPadding, top: defaultPadding),
                    child: Row(
                      children: [
                        Text(
                          'Escolher imagens:',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  ImagesFieldAbout(store),
                  Row(
                    children: [
                      Observer(builder: (_) {
                        return Container(
                          margin: EdgeInsets.only(left: 16, top: 16),
                          width: MediaQuery.of(context).size.width * 0.44,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100]),
                          child: TextFormField(
                            initialValue: store.pt ?? '',
                            onChanged: store.setPt,
                            expands: false,
                            maxLines: 6,
                            style: _fieldStyle,
                            decoration: _buildDecoration('Nossa História em PT'),
                            //validator: validateTitle,
                          ),
                        );
                      }),
                      Observer(builder: (_) {
                        return Container(
                          margin: EdgeInsets.only(left: 16, top: 16),
                          width: MediaQuery.of(context).size.width * 0.44,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100]),
                          child: TextFormField(
                            initialValue: store.en ?? '',
                            onChanged: store.setPt,
                            expands: false,
                            maxLines: 6,
                            style: _fieldStyle,
                            decoration: _buildDecoration('Nossa História em EN'),
                            //validator: validateTitle,
                          ),
                        );
                      }),
                    ],
                  ),
                  Row(
                    children: [
                      Observer(builder: (_) {
                        return Container(
                          margin: EdgeInsets.only(left: 16, top: 16),
                          width: MediaQuery.of(context).size.width * 0.44,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100]),
                          child: TextFormField(
                            initialValue: store.iaaPt ?? '',
                            onChanged: store.setIaaPt,
                            expands: false,
                            maxLines: 6,
                            style: _fieldStyle,
                            decoration: _buildDecoration('Conheça o IAA em PT'),
                            //validator: validateTitle,
                          ),
                        );
                      }),
                      Observer(builder: (_) {
                        return Container(
                          margin: EdgeInsets.only(left: 16, top: 16),
                          width: MediaQuery.of(context).size.width * 0.44,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100]),
                          child: TextFormField(
                            initialValue: store.iaaEn ?? '',
                            onChanged: store.setIaaEn,
                            expands: false,
                            maxLines: 6,
                            style: _fieldStyle,
                            decoration: _buildDecoration('Conheça o IAA em EN'),
                            //validator: validateTitle,
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              );
          },
        ),
      ),
    );
  }
}
