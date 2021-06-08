import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/screens/especie/components/especie_header.dart';
import 'package:gerenciador_aquifero/screens/especie/especie_tile.dart';

class EspecieTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: EspecieHeader(),
          ),
          SliverToBoxAdapter(
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: EspecieTile()
            ),
          )
        ],
      ),
    );
  }
}
