import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/blocs/suggestions_bloc.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/screens/suggestions/components/suggestion_tile_screen.dart';

class SuggestionsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _suggestionsBloc = BlocProvider.getBloc<SuggestionsBloc>();

    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<List>(
              stream: _suggestionsBloc.outSuggestions,
              builder: (context, snapshot) {
                if(!snapshot.hasData)
                  return Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(primaryColor),
                  ),
                  );
                else if(snapshot.data.length == 0)
                  return Center(
                    child: Text('Nenhuma sugestão encontrada!',
                      style: TextStyle(color: primaryColor),
                    ),
                  );
                else
                  return ListView.separated(
                      padding: EdgeInsets.all(defaultPadding),
                      itemBuilder: (context, index){
                        return SuggestionTileScreen(snapshot.data[index]);
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
