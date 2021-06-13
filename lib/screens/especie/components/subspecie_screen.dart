import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/blocs/subspecies_bloc.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/screens/especie/validator/subspecie_validator.dart';


class SubspecieScreen extends StatefulWidget {

  final String specieId;
  final DocumentSnapshot subspecie;

  SubspecieScreen({this.specieId, this.subspecie});

  @override
  _SubspecieScreenState createState() => _SubspecieScreenState(specieId, subspecie);
}

class _SubspecieScreenState extends State<SubspecieScreen> with SubspecieValidator {

  final SubspeciesBloc _subspeciesBloc;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  _SubspecieScreenState(String specieId, DocumentSnapshot subspecie):
        _subspeciesBloc = SubspeciesBloc(specieId: specieId, subspecies: subspecie);

  @override
  Widget build(BuildContext context) {
    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey)
      );
    }

    final _fieldStyle = TextStyle(
        color: Colors.white,
        fontSize: 16
    );

    return Scaffold(
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
                    onPressed: snapshot.data ? null : saveSubspecie
                );
              }
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column()
            ),
          )
        ],
      ),
    );
  }

  void saveSubspecie() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();

      // ignore: deprecated_member_use
      _scaffoldkey.currentState.showSnackBar(
          SnackBar(content: Text("Salvando...", style: TextStyle(color: Colors.white),),
            duration: Duration(minutes: 1),
            backgroundColor: Colors.pinkAccent,
          )
      );

      bool success = await _subspeciesBloc.saveSubspecies();

      // ignore: deprecated_member_use
      _scaffoldkey.currentState.removeCurrentSnackBar();

      // ignore: deprecated_member_use
      _scaffoldkey.currentState.showSnackBar(
          SnackBar(content: Text(success ? "Produto salvo!" : "Erro ao salvar produto!", style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.pinkAccent,
          )
      );
    }
  }
}