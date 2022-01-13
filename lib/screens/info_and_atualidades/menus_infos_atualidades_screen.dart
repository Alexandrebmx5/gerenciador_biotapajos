import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/screens/info_and_atualidades/components/list_atualidades.dart';
import 'package:gerenciador_aquifero/screens/info_and_atualidades/components/list_infos.dart';

class MenusInfosAtualidadesScreen extends StatefulWidget {
  @override
  _MenusInfosAtualidadesScreenState createState() => _MenusInfosAtualidadesScreenState();
}

class _MenusInfosAtualidadesScreenState extends State<MenusInfosAtualidadesScreen> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Card(
            elevation: 4,
            color: Colors.white,
            child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ListInfos()));
              },
              title: Text('Informes', style: TextStyle(color: bgColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: bgColor),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.white,
            child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ListAtualidades()));
              },
              title: Text('Atualidades', style: TextStyle(color: bgColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: bgColor),
            ),
          ),
        ],
      ),
    );
  }
}
