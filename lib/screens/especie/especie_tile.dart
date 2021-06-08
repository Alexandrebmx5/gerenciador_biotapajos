import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/screens/especie/components/category_tile.dart';

class EspecieTile extends StatefulWidget {
  @override
  _EspecieTileState createState() => _EspecieTileState();
}

class _EspecieTileState extends State<EspecieTile>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('species').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(bgColor),
            ),
          );
        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return CategoryTile(snapshot.data.docs[index]);
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
