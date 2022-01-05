import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/models/about_me/team/team_manager.dart';
import 'package:gerenciador_aquifero/screens/about_me/components/team/new_team_screen.dart';
import 'package:gerenciador_aquifero/screens/about_me/components/team/team_tile.dart';
import 'package:provider/provider.dart';

class ListTeam extends StatefulWidget {
  @override
  _ListTeamState createState() => _ListTeamState();
}

class _ListTeamState extends State<ListTeam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('Conheça nossa equipe'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 10, top: 10),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => NewTeamScreen()));
                  },
                  style: ElevatedButton.styleFrom(primary: bgBlue),
                  child: Text('Novo')),
            )
          ]),
      body: Consumer<TeamManager>(builder: (_, teamManager, __) {
        final filteredTeam = teamManager.filteredTeam;
        if (filteredTeam.isEmpty)
          return Center(
              child: Text(
            'Nenhum dado encontrado!',
            style: TextStyle(color: bgColor),
          ));
        return ListView.builder(
            itemCount: filteredTeam.length,
            itemBuilder: (_, index) {
              return TeamTile(filteredTeam[index]);
            });
      }),
    );
  }
}
