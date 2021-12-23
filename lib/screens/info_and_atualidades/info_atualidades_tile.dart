import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';

class InfoAtualidadesTile extends StatefulWidget {

  @override
  _InfoAtualidadesTileState createState() => _InfoAtualidadesTileState();
}

class _InfoAtualidadesTileState extends State<InfoAtualidadesTile> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Em construção', style: TextStyle(color: bgColor, fontSize: 22, fontWeight: FontWeight.bold))
    );
  }
}
