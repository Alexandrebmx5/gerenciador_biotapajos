import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/screens/guia_pratico/components/list_ucs.dart';
import 'package:gerenciador_aquifero/screens/guia_pratico/pdf_tile.dart';

class MenusGuiaScreen extends StatefulWidget {
  @override
  _MenusGuiaScreenState createState() => _MenusGuiaScreenState();
}

class _MenusGuiaScreenState extends State<MenusGuiaScreen> {

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
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ListUcs()));
              },
              title: Text('Conheça as Ucs', style: TextStyle(color: bgColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: bgColor),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.white,
            child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>PdfTile()));
              },
              title: Text('Trilhas ecológicas', style: TextStyle(color: bgColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: bgColor),
            ),
          ),
        ],
      ),
    );
  }
}
