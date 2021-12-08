import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VerDadosUsers extends StatefulWidget {
  final Map<String, dynamic> user;

  VerDadosUsers(this.user);

  @override
  _VerDadosUsersState createState() =>
      _VerDadosUsersState(user);
}

class _VerDadosUsersState extends State<VerDadosUsers> {
  final Map<String, dynamic> user;

  _VerDadosUsersState(this.user);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                radius: 80,
                child: CachedNetworkImage(
                  imageUrl: user['url'],
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                backgroundColor: Colors.transparent,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nome:'),
                  Text(user['name']),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Email:'),
                  Text(user['email'])
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Telefone:'),
                  Text(user['phone']),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                          child: Text('Fechar'),
                          style: TextButton.styleFrom(primary: Colors.red),
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
}
