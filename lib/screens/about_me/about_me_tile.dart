import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/screens/about_me/components/collaborators/list_collaborators.dart';
import 'package:gerenciador_aquifero/screens/about_me/components/edit_about/edit_about_me_screen.dart';
import 'package:gerenciador_aquifero/screens/about_me/components/partner_institutions/edit_partner_institutions.dart';
import 'package:gerenciador_aquifero/screens/about_me/components/team/list_team.dart';
import 'package:gerenciador_aquifero/stores/about_me_store.dart';

class AboutMeTile extends StatefulWidget {
  @override
  _AboutMeTileState createState() => _AboutMeTileState();
}

class _AboutMeTileState extends State<AboutMeTile> {

  final AboutMeStore aboutMeStore = AboutMeStore();

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
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>EditAboutMeScreen(aboutMeStore.aboutMeHistoric)));
              },
              title: Text('Nossa Historia e conheça o IAA', style: TextStyle(color: bgColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: bgColor),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.white,
            child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ListTeam()));
              },
              title: Text('Conheça nossa equipe', style: TextStyle(color: bgColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: bgColor),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.white,
            child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ListCollaborators()));
              },
              title: Text('Colaboradores', style: TextStyle(color: bgColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: bgColor),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.white,
            child: ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>EditPartnerInstitutionsScreen(aboutMeStore.partnerInstitutions)));
              },
              title: Text('Instituições parceiras', style: TextStyle(color: bgColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: bgColor),
            ),
          )
        ],
      ),
    );
  }
}
