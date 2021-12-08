import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/screens/users/components/users_header.dart';
import 'package:gerenciador_aquifero/screens/users/users_tile.dart';

class UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: UsersHeader(),
          ),
          SliverToBoxAdapter(
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: UsersTile()
            ),
          )
        ],
      ),
    );
  }
}
