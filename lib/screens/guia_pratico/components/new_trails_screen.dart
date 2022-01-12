import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/models/ucs_trails/trails.dart';
import 'package:gerenciador_aquifero/screens/guia_pratico/components/image_field_trails.dart';
import 'package:gerenciador_aquifero/stores/edit_trails_store.dart';
import 'package:mobx/mobx.dart';

class NewTrailsScreen extends StatefulWidget {

  NewTrailsScreen({this.trails});

  final Trails trails;

  @override
  _NewTrailsScreenState createState() => _NewTrailsScreenState(trails);
}

class _NewTrailsScreenState extends State<NewTrailsScreen> {

  _NewTrailsScreenState(Trails trails)
      : editing = trails != null,
        store = EditTrailsStore(trails ?? Trails());

  bool editing;

  final EditTrailsStore store;

  @override
  void initState() {
    super.initState();

    when((_) => store.saveTrails == true, () {
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
        title: Text('Trilhas', style: TextStyle(color: secondaryColor)),
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
                  ImagesFieldTrails(store),
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
                            initialValue: store.title ?? '',
                            onChanged: store.setTitle,
                            expands: false,
                            maxLines: 1,
                            style: _fieldStyle,
                            decoration: _buildDecoration('Title'),
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
                            initialValue: store.titleEn ?? '',
                            onChanged: store.setTitleEn,
                            expands: false,
                            maxLines: 1,
                            style: _fieldStyle,
                            decoration: _buildDecoration('Title em EN'),
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
                            initialValue: store.paragraphOne ?? '',
                            onChanged: store.setParagraphOne,
                            expands: false,
                            maxLines: 6,
                            style: _fieldStyle,
                            decoration: _buildDecoration('Primeiro parágrafo em PT'),
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
                            initialValue: store.paragraphOneEn ?? '',
                            onChanged: store.setParagraphOneEn,
                            expands: false,
                            maxLines: 6,
                            style: _fieldStyle,
                            decoration: _buildDecoration('Primeiro parágrafo em EN'),
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
                            initialValue: store.paragraphTwo ?? '',
                            onChanged: store.setParagraphTwo,
                            expands: false,
                            maxLines: 6,
                            style: _fieldStyle,
                            decoration: _buildDecoration('Segundo parágrafo em PT'),
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
                            initialValue: store.paragraphTwoEn ?? '',
                            onChanged: store.setParagraphTwoEn,
                            expands: false,
                            maxLines: 6,
                            style: _fieldStyle,
                            decoration: _buildDecoration('Segundo parágrafo em EN'),
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
                            initialValue: store.paragraphThree ?? '',
                            onChanged: store.setParagraphThree,
                            expands: false,
                            maxLines: 6,
                            style: _fieldStyle,
                            decoration: _buildDecoration('Terceiro parágrafo em PT'),
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
                            initialValue: store.paragraphThreeEn ?? '',
                            onChanged: store.setParagraphThreeEn,
                            expands: false,
                            maxLines: 6,
                            style: _fieldStyle,
                            decoration: _buildDecoration('Terceiro parágrafo em EN'),
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
                            initialValue: store.paragraphFour ?? '',
                            onChanged: store.setParagraphFour,
                            expands: false,
                            maxLines: 6,
                            style: _fieldStyle,
                            decoration: _buildDecoration('Quarto parágrafo em PT'),
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
                            initialValue: store.paragraphFourEn ?? '',
                            onChanged: store.setParagraphFourEn,
                            expands: false,
                            maxLines: 6,
                            style: _fieldStyle,
                            decoration: _buildDecoration('Quarto parágrafo em EN'),
                            //validator: validateTitle,
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 30),
                ]);
        }),
      ),
    );
  }
}
