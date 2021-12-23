import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/screens/about_me/components/edit_about_me_screen.dart';

class AboutMeTile extends StatefulWidget {
  @override
  _AboutMeTileState createState() => _AboutMeTileState();
}

class _AboutMeTileState extends State<AboutMeTile> {
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
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>EditAboutMeScreen()));
              },
              title: Text('Nossa Historia e conheça o IAA', style: TextStyle(color: bgColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: bgColor),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.white,
            child: ListTile(
              onTap: (){},
              title: Text('Conheça nossa equipe', style: TextStyle(color: bgColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: bgColor),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.white,
            child: ListTile(
              onTap: (){},
              title: Text('Colaboradores', style: TextStyle(color: bgColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: bgColor),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.white,
            child: ListTile(
              onTap: (){},
              title: Text('Instituições parceiras', style: TextStyle(color: bgColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: bgColor),
            ),
          )
        ],
      ),
    );
  }
}
