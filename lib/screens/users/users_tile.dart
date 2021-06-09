import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/blocs/user_bloc.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/screens/users/components/user_tile_screen.dart';

class UsersTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _userBloc = BlocProvider.getBloc<UserBloc>();

    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<List>(
              stream: _userBloc.outUsers,
              builder: (context, snapshot) {
                if(!snapshot.hasData)
                  return Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                  ),
                  );
                else if(snapshot.data.length == 0)
                  return Center(
                    child: Text('Nenhum usuário encontrado!',
                      style: TextStyle(color: primaryColor),
                    ),
                  );
                else
                  return ListView.separated(
                      padding: EdgeInsets.all(defaultPadding),
                      itemBuilder: (context, index){
                        return UserTileScreen(snapshot.data[index]);
                      },
                      separatorBuilder: (context, index){
                        return Divider(color: Colors.black,);
                      },
                      itemCount: snapshot.data.length
                  );
              }
          ),
        )
      ],
    );
  }
}
