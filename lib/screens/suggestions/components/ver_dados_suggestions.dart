import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/models/suggestions/suggestions.dart';
import 'package:url_launcher/url_launcher.dart';

class VerDadosSuggestions extends StatefulWidget {
  final Suggestions suggestions;

  VerDadosSuggestions(this.suggestions);

  @override
  _VerDadosSuggestionsState createState() =>
      _VerDadosSuggestionsState(suggestions);
}

class _VerDadosSuggestionsState extends State<VerDadosSuggestions> {
  final Suggestions suggestions;

  _VerDadosSuggestionsState(this.suggestions);

  bool loading = false;
  String error;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: loading
          ? Container(
              width: 200,
              height: 100,
              child: Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(primaryColor))),
            )
          : Container(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (suggestions?.fileUrl != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Imagem ou arquivo:'),
                          TextButton(
                              child: Text('Baixar'),
                              style: TextButton.styleFrom(primary: primaryColor),
                              onPressed: () {
                                launchURL(url: suggestions.fileUrl);
                              })
                        ],
                      ),
                    if (suggestions?.lat != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Coordenadas:'),
                          TextButton(
                              child: Text('ver',
                                  style: TextStyle(color: primaryColor)),
                              style: TextButton.styleFrom(primary: bgColor),
                              onPressed: () {
                                launchURL(
                                    url:
                                    'https://www.google.com/maps/search/?api=1&amp;query=${suggestions.lat},${suggestions.long}');
                              })
                        ],
                      ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Nome:'),
                        Text(suggestions.name),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Email:'), Text(suggestions.email)],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (suggestions.date != null && suggestions.time != null) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Data:'),
                          Text(suggestions.date),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Hora:'),
                          Text(suggestions.date),
                        ],
                      ),
                    ],
                    SizedBox(
                      height: 5,
                    ),
                    if (suggestions.location != null) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Local:'),
                          Text(suggestions.location),
                        ],
                      ),
                    ],
                    SizedBox(
                      height: 5,
                    ),
                    if (suggestions.environment != null) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ambiente:'),
                          Text(suggestions.environment),
                        ],
                      ),
                    ],
                    SizedBox(
                      height: 5,
                    ),
                    if (suggestions.sightedPlace != null) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Local avistado:'),
                          Text(suggestions.sightedPlace),
                        ],
                      ),
                    ],
                    SizedBox(
                      height: 5,
                    ),
                    if (suggestions.behavior != null) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Comportamento:'),
                          Text(suggestions.behavior),
                        ],
                      ),
                    ],
                    SizedBox(
                      height: 5,
                    ),
                    if (suggestions.approved != null) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Aprovado:'),
                          Text(suggestions.approved ? 'Sim' : 'Não'),
                        ],
                      ),
                    ],
                    SizedBox(
                      height: 5,
                    ),
                    if (suggestions.comment != null) ...[
                      Text('Comentário:'),
                      Text(suggestions.comment),
                    ],
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                            child: Text('Remover'),
                            style: TextButton.styleFrom(primary: Colors.red),
                            onPressed: !loading ? () async {
                              setState(() {
                                loading = true;
                              });
                              try {
                                await suggestions.delete(suggestions);
                                Navigator.of(context).pop();
                              } catch (e){
                                setState(() {
                                  loading = false;
                                  error = e.toString();
                                });
                              }
                            } : null,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        TextButton(
                          child: Text('Aprovar'),
                          style: TextButton.styleFrom(primary: primaryColor),
                          onPressed: !loading ? () async {
                            setState(() {
                              loading = true;
                            });
                            try {
                              await suggestions.approvedSuggestions(suggestions);
                              Navigator.of(context).pop();
                            } catch (e){
                              setState(() {
                                loading = false;
                                error = e.toString();
                              });
                            }
                          } : null,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        TextButton(
                            child: Text('Fechar'),
                            style: TextButton.styleFrom(primary: Colors.black),
                            onPressed: Navigator.of(context).pop),
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
