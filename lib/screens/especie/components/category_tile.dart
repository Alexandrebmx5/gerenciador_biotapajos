import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/screens/especie/components/edit_category_dialog.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot category;

  CategoryTile(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        color: secondaryColor,
        elevation: 8,
        child: ExpansionTile(
          collapsedIconColor: bgColor,
          iconColor: bgColor,
          leading: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => EditCategoryDialog(
                        category: category,
                      ));
            },
            child: CircleAvatar(
              child: Image.network(
                category.data()['img'],
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
          title: Text(
            category.data()['pt'],
            style:
                TextStyle(color: Colors.grey[850], fontWeight: FontWeight.w500),
          ),
          children: <Widget>[
            FutureBuilder<QuerySnapshot>(
              future: category.reference.collection('subspecies').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                return Column(
                  children: snapshot.data.docs.map((doc) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(doc.data()['img'][0].toString()),
                        backgroundColor: Colors.transparent,
                      ),
                      title: Text(
                        doc.data()['nome'],
                        style: TextStyle(color: bgColor),
                      ),
                      onTap: () {},
                    );
                  }).toList()
                    ..add(ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.add,
                          color: bgColor,
                        ),
                      ),
                      title: Text('Adicionar'),
                      onTap: () {},
                    )),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
