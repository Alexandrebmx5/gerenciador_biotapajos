import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/models/info_presently/presently.dart';
import 'package:gerenciador_aquifero/screens/info_and_atualidades/components/new_atualidades_screen.dart';

class AtualidadesTile extends StatelessWidget {

  AtualidadesTile(this.presently);

  final Presently presently;

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
                Text('${presently.title}', style: TextStyle(color: bgColor, fontWeight: FontWeight.bold))
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NewAtualidadesScreen(presently: presently)));
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
        content: Text('Confirmar a exclusão de ${presently.title}?'),
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
              presently.delete(presently);
            },
            child: Text('Sim', style: TextStyle(color: Colors.red),),
          ),
        ],
      ),
    );
  }
}
