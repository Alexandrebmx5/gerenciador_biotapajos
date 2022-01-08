import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/models/about_me/team/team.dart';
import 'package:gerenciador_aquifero/screens/about_me/components/team/image_field_team.dart';
import 'package:gerenciador_aquifero/stores/edit_team_store.dart';
import 'package:mobx/mobx.dart';

class NewTeamScreen extends StatefulWidget {

  NewTeamScreen({this.team});

  final Team team;

  @override
  _NewTeamScreenState createState() => _NewTeamScreenState(team);
}

class _NewTeamScreenState extends State<NewTeamScreen> {

  _NewTeamScreenState(Team team)
      : editing = team != null,
        store = EditTeamStore(team ?? Team());

  bool editing;

  final EditTeamStore store;

  @override
  void initState() {
    super.initState();

    when((_) => store.savedTeam == true, () {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Salvo com sucesso!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ));
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
        title: Text('Equipe', style: TextStyle(color: secondaryColor)),
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
        child: Observer(builder: (_) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: Row(
                      children: [
                        Text(
                          'Escolher uma imagem:',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  ImagesFieldTeam(store),
                  Observer(builder: (_) {
                    return Container(
                      margin: EdgeInsets.only(left: 16, top: 16),
                      width: MediaQuery.of(context).size.width * 0.89,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[100]),
                      child: TextFormField(
                        initialValue: store.name ?? '',
                        onChanged: store.setNome,
                        expands: false,
                        maxLines: 1,
                        style: _fieldStyle,
                        decoration: _buildDecoration('Nome completo'),
                        //validator: validateTitle,
                      ),
                    );
                  }),
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
                            initialValue: store.descriptionPt ?? '',
                            onChanged: store.setDescriptionPt,
                            expands: false,
                            maxLines: 6,
                            style: _fieldStyle,
                            decoration: _buildDecoration('Descrição em PT'),
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
                            initialValue: store.descriptionEn ?? '',
                            onChanged: store.setDescriptionEn,
                            expands: false,
                            maxLines: 6,
                            style: _fieldStyle,
                            decoration: _buildDecoration('Descrição em EN'),
                            //validator: validateTitle,
                          ),
                        );
                      }),
                    ],
                  ),
                ]);
        }),
      ),
    );
  }
}
