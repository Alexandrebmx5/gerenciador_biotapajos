import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/models/especie/especie_manager.dart';
import 'package:gerenciador_aquifero/screens/especie/components/category_tile.dart';
import 'package:provider/provider.dart';

class EspecieTile extends StatefulWidget {
  @override
  _EspecieTileState createState() => _EspecieTileState();
}

class _EspecieTileState extends State<EspecieTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EspecieManager>(
        builder: (_, especieManager, __) {
      final especies = especieManager.allEspecies;
      if (especies.isEmpty)
        return Center(
            child: Text(
              'Nenhuma categoria encontrada!',
              style: TextStyle(color: bgColor),
            ));
      return ListView.builder(
          itemCount: especies.length,
          itemBuilder: (_, index) {
            return CategoryTile(especies[index]);
          });
    });
  }
}
