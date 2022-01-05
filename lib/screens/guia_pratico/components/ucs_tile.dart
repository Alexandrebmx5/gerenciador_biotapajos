import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/models/ucs_trails/ucs.dart';
import 'package:gerenciador_aquifero/screens/guia_pratico/components/new_ucs_screen.dart';

class UcsTile extends StatelessWidget {

  UcsTile(this.ucs);

  final Ucs ucs;

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
                Text('Title: ', style: TextStyle(color: bgColor)),
                Text('${ucs.title}', style: TextStyle(color: bgColor, fontWeight: FontWeight.bold))
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NewUcsScreen(ucs: ucs)));
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
        content: Text('Confirmar a exclusão de ${ucs.title}?'),
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
              ucs.delete(ucs);
            },
            child: Text('Sim', style: TextStyle(color: Colors.red),),
          ),
        ],
      ),
    );
  }
}
