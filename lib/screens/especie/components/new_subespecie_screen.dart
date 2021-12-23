import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/common/responsive.dart';
import 'package:gerenciador_aquifero/models/especie/especie.dart';
import 'package:gerenciador_aquifero/models/especie/subespecie.dart';
import 'package:gerenciador_aquifero/screens/especie/components/image_field_subespecie.dart';
import 'package:gerenciador_aquifero/screens/especie/components/sound_widget.dart';
import 'package:gerenciador_aquifero/stores/new_subespecie_store.dart';
import 'package:mobx/mobx.dart';

class NewSubspecieScreen extends StatefulWidget {
  final Especie especie;
  final SubEspecie subEspecie;

  NewSubspecieScreen({this.especie, this.subEspecie});

  @override
  _NewSubspecieScreenState createState() =>
      _NewSubspecieScreenState(subEspecie);
}

class _NewSubspecieScreenState extends State<NewSubspecieScreen> {
  _NewSubspecieScreenState(SubEspecie subEspecie)
      : editing = subEspecie != null,
        store = NewSubEspecieStore(subEspecie: subEspecie ?? SubEspecie());

  final NewSubEspecieStore store;

  bool editing;

  @override
  void initState() {
    super.initState();
    when((_) => store.saveSub, () {
      if (editing) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Salvo com sucesso!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: primaryColor,
        ));
      } else {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Salvo com sucesso!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: primaryColor,
        ));
      }
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

    store.setGroup(widget.especie.pt);
    store.setGroupEn(widget.especie.en);

    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          title: Text(editing ? 'Editar Espécie' : 'Criar Espécie',
              style: TextStyle(color: secondaryColor)),
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
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Observer(
              builder: (_) {
                if (store.loading)
                  return Padding(
                    padding: const EdgeInsets.all(100),
                    child: Column(
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
                  );
                if (Responsive.isDesktop(context))
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Padding(
                      padding: const EdgeInsets.only(left: defaultPadding),
                      child: Row(
                        children: [
                          Text(
                            'Escolher imagens:',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    ImagesFieldSubEspecie(store),
                    SoundWidget(store),
                    Row(
                      children: [
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.41,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.specie ?? '',
                              onChanged: store.setSpecie,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Espécie'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.41,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.specieEn ?? '',
                              onChanged: store.setSpecieEn,
                              style: _fieldStyle,
                              decoration:
                              _buildDecoration('Espécie em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        })
                      ],
                    ),
                    Row(
                      children: [
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.reproductions ?? '',
                              onChanged: store.setReproductions,
                              expands: false,
                              maxLines: 6,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Reprodução'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.reproductionsEn ?? '',
                              onChanged: store.setReproductionsEn,
                              expands: false,
                              maxLines: 6,
                              style: _fieldStyle,
                              decoration:
                                  _buildDecoration('Reprodução em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.youKnow ?? '',
                              onChanged: store.setYouKnow,
                              expands: false,
                              maxLines: 6,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Você sabe?'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.youKnowEn ?? '',
                              onChanged: store.setYouKnowEn,
                              expands: false,
                              maxLines: 6,
                              style: _fieldStyle,
                              decoration:
                                  _buildDecoration('Você sabe em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        })
                      ],
                    ),
                    Row(
                      children: [
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              enabled: false,
                              initialValue: widget.especie.pt ?? '',
                              style: _fieldStyle,
                              decoration: _buildDecoration('Grupo'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              enabled: false,
                              initialValue: widget.especie.en ?? '',
                              style: _fieldStyle,
                              decoration: _buildDecoration('Grupo em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.nome ?? '',
                              onChanged: store.setNome,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Nome popular'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.nomeEn ?? '',
                              onChanged: store.setNomeEn,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Nome popular em inglês'),
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
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.family ?? '',
                              onChanged: store.setFamily,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Família'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.familyEn ?? '',
                              onChanged: store.setFamilyEn,
                              style: _fieldStyle,
                              decoration:
                                  _buildDecoration('Família em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.locations ?? '',
                              onChanged: store.setLocations,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Distribuição'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.locationsEn,
                              onChanged: store.setLocationsEn,
                              style: _fieldStyle,
                              decoration:
                                  _buildDecoration('Distribuição em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        })
                      ],
                    ),
                    Row(
                      children: [
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.howKnow ?? '',
                              onChanged: store.setHowKnow,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Tamanho'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.howKnowEn ?? '',
                              onChanged: store.setHowKnowEn,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Tamanho em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.color ?? '',
                              onChanged: store.setColor,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Cor predominante'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.colorEn ?? '',
                              onChanged: store.setColorEn,
                              style: _fieldStyle,
                              decoration: _buildDecoration(
                                  'Cor predominante em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        })
                      ],
                    ),
                    Row(
                      children: [
                        Observer(builder: (_) {
                          return Container(
                            margin:
                                EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.specieSimilar ?? '',
                              onChanged: store.setSpecieSimilar,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Espécie similar'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin:
                                EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.specieSimilarEn ?? '',
                              onChanged: store.setSpecieSimilarEn,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Espécie similar em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin:
                            EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.whereLive ?? '',
                              onChanged: store.setWhereLive,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Onde vivem?'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin:
                            EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.whereLiveEn ?? '',
                              onChanged: store.setWhereLiveEn,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Ondem vivem em inglês'),
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
                              margin:
                              EdgeInsets.only(left: 16, top: 16, bottom: 16),
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[100]),
                              child: TextFormField(
                                initialValue: store.activity ?? '',
                                onChanged: store.setActivity,
                                style: _fieldStyle,
                                decoration: _buildDecoration('Atividade'),
                                //validator: validateTitle,
                              ),
                            );
                          }),
                          Observer(builder: (_) {
                            return Container(
                              margin:
                              EdgeInsets.only(left: 16, top: 16, bottom: 16),
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[100]),
                              child: TextFormField(
                                initialValue: store.activityEn ?? '',
                                onChanged: store.setActivityEn,
                                style: _fieldStyle,
                                decoration: _buildDecoration('Atividade em inglês'),
                                //validator: validateTitle,
                              ),
                            );
                          }),
                        ],
                      )
                  ]);
                else
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: defaultPadding),
                          child: Row(
                            children: [
                              Text(
                                'Escolher imagens:',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        ImagesFieldSubEspecie(store),
                        SizedBox(height: 20),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.41,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.specie ?? '',
                              onChanged: store.setSpecie,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Espécie'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.41,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.specieEn ?? '',
                              onChanged: store.setSpecieEn,
                              style: _fieldStyle,
                              decoration:
                              _buildDecoration('Espécie em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.reproductions ?? '',
                              onChanged: store.setReproductions,
                              expands: false,
                              maxLines: 6,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Reprodução'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.reproductionsEn ?? '',
                              onChanged: store.setReproductionsEn,
                              expands: false,
                              maxLines: 6,
                              style: _fieldStyle,
                              decoration:
                                  _buildDecoration('Reprodução em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.youKnow ?? '',
                              onChanged: store.setYouKnow,
                              expands: false,
                              maxLines: 6,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Você sabe?'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.youKnowEn ?? '',
                              onChanged: store.setYouKnowEn,
                              expands: false,
                              maxLines: 6,
                              style: _fieldStyle,
                              decoration:
                                  _buildDecoration('Você sabe em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: widget.especie.pt ?? '',
                              style: _fieldStyle,
                              decoration: _buildDecoration('Grupo'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: widget.especie.en ?? '',
                              style: _fieldStyle,
                              decoration: _buildDecoration('Grupo em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.nome ?? '',
                              onChanged: store.setNome,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Nome'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.nomeEn ?? '',
                              onChanged: store.setNomeEn,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Nome em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.family ?? '',
                              onChanged: store.setFamily,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Família'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.familyEn ?? '',
                              onChanged: store.setFamilyEn,
                              style: _fieldStyle,
                              decoration:
                                  _buildDecoration('Família em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.locations ?? '',
                              onChanged: store.setLocations,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Distribuição'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.locationsEn,
                              onChanged: store.setLocationsEn,
                              style: _fieldStyle,
                              decoration:
                                  _buildDecoration('Distribuição em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.howKnow ?? '',
                              onChanged: store.setHowKnow,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Tamanho'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.howKnowEn ?? '',
                              onChanged: store.setHowKnowEn,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Tamanho em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.color ?? '',
                              onChanged: store.setColor,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Cor predominante'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, top: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.colorEn ?? '',
                              onChanged: store.setColorEn,
                              style: _fieldStyle,
                              decoration: _buildDecoration(
                                  'Cor predominante em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin:
                                EdgeInsets.only(left: 16, top: 16, bottom: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.specieSimilar ?? '',
                              onChanged: store.setSpecieSimilar,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Espécie similar'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin:
                                EdgeInsets.only(left: 16, top: 16, bottom: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.specieSimilarEn ?? '',
                              onChanged: store.setSpecieSimilarEn,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Espécie similar em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin:
                            EdgeInsets.only(left: 16, top: 16, bottom: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.whereLive ?? '',
                              onChanged: store.setWhereLive,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Onde vivem?'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin:
                            EdgeInsets.only(left: 16, top: 16, bottom: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.whereLiveEn ?? '',
                              onChanged: store.setWhereLiveEn,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Ondem vivem em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin:
                            EdgeInsets.only(left: 16, top: 16, bottom: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.activity ?? '',
                              onChanged: store.setActivity,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Atividade'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            margin:
                            EdgeInsets.only(left: 16, top: 16, bottom: 16),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: TextFormField(
                              initialValue: store.activityEn ?? '',
                              onChanged: store.setActivityEn,
                              style: _fieldStyle,
                              decoration: _buildDecoration('Atividade em inglês'),
                              //validator: validateTitle,
                            ),
                          );
                        }),
                      ]);
              },
            ),
          ),
        ]));
  }
}
