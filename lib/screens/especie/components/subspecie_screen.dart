import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/blocs/subspecies_bloc.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/screens/especie/components/images_widget.dart';
import 'package:gerenciador_aquifero/screens/especie/components/sound_widget.dart';


class SubspecieScreen extends StatefulWidget {

  final String specieId;
  final DocumentSnapshot subspecie;

  SubspecieScreen({this.specieId, this.subspecie});

  @override
  _SubspecieScreenState createState() => _SubspecieScreenState(specieId, subspecie);
}

class _SubspecieScreenState extends State<SubspecieScreen> {

  final SubspeciesBloc _subspeciesBloc;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  _SubspecieScreenState(String specieId, DocumentSnapshot subspecie):
        _subspeciesBloc = SubspeciesBloc(specieId: specieId, subspecies: subspecie);

  @override
  Widget build(BuildContext context) {
    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          border: InputBorder.none,
          labelText: label,
          labelStyle: TextStyle(color: Colors.black)
      );
    }

    final _fieldStyle = TextStyle(
        color: Colors.black,
        fontSize: 16
    );

    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: StreamBuilder<bool>(
            stream: _subspeciesBloc.outCreated,
            initialData: false,
            builder: (context, snapshot) {
              return Text(snapshot.data ? 'Editar Espécie' : 'Criar Espécie', style: TextStyle(color: secondaryColor),);
            }
        ),
        actions: [
          StreamBuilder<bool>(
            stream: _subspeciesBloc.outCreated,
            initialData: false,
            builder: (context, snapshot){
              if(snapshot.data)
                return StreamBuilder<bool>(
                    stream: _subspeciesBloc.outLoading,
                    initialData: false,
                    builder: (context, snapshot) {
                      return IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: snapshot.data ? null : (){
                            _subspeciesBloc.deleteProduct();
                            Navigator.of(context).pop();
                          }
                      );
                    }
                );
              else return Container();
            },
          ),
          StreamBuilder<bool>(
              stream: _subspeciesBloc.outLoading,
              initialData: false,
              builder: (context, snapshot) {
                return IconButton(
                    icon: Icon(Icons.save),
                    onPressed: snapshot.data ? null : (){
                      _subspeciesBloc.saveSubspecies();
                      Navigator.of(context).pop();
                    }
                );
              }
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: StreamBuilder<Map>(
                    stream: _subspeciesBloc.outData,
                    builder: (context, snapshot){
                      if(!snapshot.hasData) return Container();
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
                                      color: Colors.black,
                                      fontSize: 12
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ImagesWidget(
                            context: context,
                            initialValue: snapshot.data['img'],
                            onSaved: _subspeciesBloc.saveImages,
                            //validator: validateImages,
                          ),
                          SoundWidget(
                            context: context,
                            initialValue: snapshot.data['sound'],
                            onSaved: _subspeciesBloc.saveSound,
                            //validator: validateImages,
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 16),
                                width: MediaQuery.of(context).size.width * 0.41,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  initialValue: snapshot.data['nome'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Nome'),
                                  onChanged: _subspeciesBloc.saveNome,
                                  //validator: validateTitle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16),
                                width: MediaQuery.of(context).size.width * 0.41,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  initialValue: snapshot.data['nome_en'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Nome em inglês'),
                                  onChanged: _subspeciesBloc.saveNomeEn,
                                  //validator: validateTitle,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  expands: false,
                                  maxLines: 6,
                                  initialValue: snapshot.data['reproduction'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Reprodução'),
                                  onChanged: _subspeciesBloc.saveReproductions,
                                  //validator: validateTitle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  expands: false,
                                  maxLines: 6,
                                  initialValue: snapshot.data['reproduction_en'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Reprodução em inglês'),
                                  onChanged: _subspeciesBloc.saveReproductionsEn,
                                  //validator: validateTitle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  expands: false,
                                  maxLines: 6,
                                  initialValue: snapshot.data['youKnow'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Você sabe?'),
                                  onChanged: _subspeciesBloc.saveYouknow,
                                  //validator: validateTitle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  expands: false,
                                  maxLines: 6,
                                  initialValue: snapshot.data['youKnow_en'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Você sabe em inglês'),
                                  onChanged: _subspeciesBloc.saveYouknowEn,
                                  //validator: validateTitle,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  initialValue: snapshot.data['specie'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Espécie'),
                                  onChanged: _subspeciesBloc.saveSpecie,
                                  //validator: validateTitle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  initialValue: snapshot.data['specie_en'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Espécie em inglês'),
                                  onChanged: _subspeciesBloc.saveSpecieEn,
                                  //validator: validateTitle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  initialValue: snapshot.data['subspecie'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Sub Espécie'),
                                  onChanged: _subspeciesBloc.saveSubspecie,
                                  //validator: validateTitle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  initialValue: snapshot.data['subspecie_en'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Sub Espécie em inglês'),
                                  onChanged: _subspeciesBloc.saveSubspecieEn,
                                  //validator: validateTitle,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  initialValue: snapshot.data['scientificName'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Nome científico'),
                                  onChanged: _subspeciesBloc.saveScientificName,
                                  //validator: validateTitle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  initialValue: snapshot.data['scientificName_en'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Nome científico em inglês'),
                                  onChanged: _subspeciesBloc.saveScientificNameEn,
                                  //validator: validateTitle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  initialValue: snapshot.data['locations'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Localização'),
                                  onChanged: _subspeciesBloc.saveLocations,
                                  //validator: validateTitle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  initialValue: snapshot.data['locations_en'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Localização em inglês'),
                                  onChanged: _subspeciesBloc.saveLocationsEn,
                                  //validator: validateTitle,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  initialValue: snapshot.data['howKnow'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Tamanho'),
                                  onChanged: _subspeciesBloc.saveKnowKnow,
                                  //validator: validateTitle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  initialValue: snapshot.data['howKnow_en'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Tamanho em inglês'),
                                  onChanged: _subspeciesBloc.saveKnowKnowEn,
                                  //validator: validateTitle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  initialValue: snapshot.data['color'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Cor predominante'),
                                  onChanged: _subspeciesBloc.saveColor,
                                  //validator: validateTitle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  initialValue: snapshot.data['color_en'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Cor predominante em inglês'),
                                  onChanged: _subspeciesBloc.saveColorEn,
                                  //validator: validateTitle,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  initialValue: snapshot.data['active'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Ativa'),
                                  onChanged: _subspeciesBloc.saveActive,
                                  //validator: validateTitle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  initialValue: snapshot.data['active_en'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Ativa em inglês'),
                                  onChanged: _subspeciesBloc.saveActiveEn,
                                  //validator: validateTitle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  initialValue: snapshot.data['lat'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Latidade'),
                                  onChanged: _subspeciesBloc.saveLat,
                                  //validator: validateTitle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]
                                ),
                                child: TextFormField(
                                  initialValue: snapshot.data['long'],
                                  style: _fieldStyle,
                                  decoration: _buildDecoration('Longitude'),
                                  onChanged: _subspeciesBloc.saveLong,
                                  //validator: validateTitle,
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
                StreamBuilder<bool>(
                    stream: _subspeciesBloc.outLoading,
                    initialData: false,
                    builder: (context, snapshot) {
                      return IgnorePointer(
                        ignoring: !snapshot.data,
                        child: Container(
                          color: snapshot.data ? Colors.black54 : Colors.transparent,
                        ),
                      );
                    }
                )
              ],
            )
          )
        ],
      ),
    );
  }

  void saveProduct() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();

      // ignore: deprecated_member_use
      _scaffoldkey.currentState.showSnackBar(
          SnackBar(content: Text("Salvando espécie...", style: TextStyle(color: Colors.black),),
            duration: Duration(seconds: 10),
            backgroundColor: primaryColor,
          )
      );

      bool success = await _subspeciesBloc.saveSubspecies();

      // ignore: deprecated_member_use
      _scaffoldkey.currentState.removeCurrentSnackBar();

      // ignore: deprecated_member_use
      _scaffoldkey.currentState.showSnackBar(
          SnackBar(content: Text(success ? "Espécie salva!" : "Erro ao salvar espécie!", style: TextStyle(color: Colors.black),),
            backgroundColor: primaryColor,
          )
      );
    }
  }
}