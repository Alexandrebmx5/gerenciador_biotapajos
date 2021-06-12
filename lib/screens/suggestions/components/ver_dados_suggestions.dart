import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class VerDadosSuggestions extends StatefulWidget {
  final Map<String, dynamic> suggestions;

  VerDadosSuggestions(this.suggestions);

  @override
  _VerDadosSuggestionsState createState() =>
      _VerDadosSuggestionsState(suggestions);
}

class _VerDadosSuggestionsState extends State<VerDadosSuggestions> {
  final Map<String, dynamic> suggestions;

  _VerDadosSuggestionsState(this.suggestions);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 500,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if(suggestions.containsKey('fileUrl'))
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Arquivo:'),
                    TextButton(
                        child: Text('Baixar'),
                        style: TextButton.styleFrom(primary: bgColor),
                        onPressed: (){
                          launchURL(url: suggestions['fileUrl']);
                        }
                    )
                  ],
                ),
              if(suggestions.containsKey('lat'))
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Coordenadas:'),
                    TextButton(
                        child: Text('ver'),
                        style: TextButton.styleFrom(primary: bgColor),
                        onPressed: (){
                          launchURL(url: 'https://www.google.com/maps/search/?api=1&amp;query=${suggestions['lat']},${suggestions['long']}');
                        }
                    )
                  ],
                ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nome:'),
                  Text(suggestions['name']),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Email:'),
                  Text(suggestions['email'])
                ],
              ),
              SizedBox(height: 5,),
              Text('Texto:'),
              Text(suggestions['text']),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(height: 5,),
                  TextButton(
                      child: Text('Sair'),
                      style: TextButton.styleFrom(primary: bgColor),
                      onPressed: Navigator.of(context).pop
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void launchURL({String url}) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
