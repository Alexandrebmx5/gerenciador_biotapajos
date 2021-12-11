import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/screens/about_me/about_me_tile.dart';
import 'package:gerenciador_aquifero/screens/about_me/components/about_me_header.dart';

class AboutMeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AboutMeHeader(),
          ),
          SliverToBoxAdapter(
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: AboutMeTile()
            ),
          )
        ],
      ),
    );
  }
}
