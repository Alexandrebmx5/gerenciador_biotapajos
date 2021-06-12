import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/screens/suggestions/components/ver_dados_suggestions.dart';
import 'package:shimmer/shimmer.dart';

class SuggestionTileScreen extends StatelessWidget {

  final Map<String, dynamic> suggestions;

  SuggestionTileScreen(this.suggestions);

  @override
  Widget build(BuildContext context) {

    final textStyle = TextStyle(color: Colors.black);

    if(suggestions.containsKey('name'))
      return ListTile(
        title: Text(
          suggestions['name'],
          style: textStyle,
        ),
        subtitle: Text(
          suggestions['email'],
          style: textStyle,
        ),
        trailing: ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => VerDadosSuggestions(suggestions));
          },
          child: Text('Ver dados'),
        ),
      );
    else
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
                width: 200,
                height: 20,
                child: Shimmer.fromColors(
                    child: Container(
                      color: Colors.white.withAlpha(50),
                      margin: EdgeInsets.symmetric(vertical: 4),
                    ),
                    baseColor: Colors.white,
                    highlightColor: Colors.grey
                )
            ),
            SizedBox(
                width: 50,
                height: 20,
                child: Shimmer.fromColors(
                    child: Container(
                      color: Colors.white.withAlpha(50),
                      margin: EdgeInsets.symmetric(vertical: 4),
                    ),
                    baseColor: Colors.white,
                    highlightColor: Colors.grey
                )
            )
          ],
        ),
      );
  }
}
