import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/models/about_me/collaborators/collaborators.dart';
import 'package:gerenciador_aquifero/screens/about_me/components/collaborators/new_colaborators_screen.dart';

class CollaboratorsTile extends StatelessWidget {

  CollaboratorsTile(this.collaborators);

  final Collaborators collaborators;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text('Nome: ', style: TextStyle(color: bgColor)),
                Text('${collaborators.name}', style: TextStyle(color: bgColor, fontWeight: FontWeight.bold))
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: primaryColor
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NewCollaboratorsScreen(collaborators: collaborators)));
                    },
                    child: Text('Editar'),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red
                    ),
                    onPressed: () {
                      delete(context);
                    },
                    child: Text('Remover'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void delete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Excluir'),
        content: Text('Confirmar a exclusão de ${collaborators.name}?'),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: Text('Não', style: TextStyle(color: Theme.of(context).primaryColor,),),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              collaborators.delete(collaborators);
            },
            child: Text('Sim', style: TextStyle(color: Colors.red),),
          ),
        ],
      ),
    );
  }
}
