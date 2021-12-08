import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/blocs/suggestions_bloc.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/common/responsive.dart';
import 'package:gerenciador_aquifero/controllers/MenuController.dart';
import 'package:provider/provider.dart';


class SuggestionsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: primaryColor,
      child: Row(
        children: [
          if (!Responsive.isDesktop(context))
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: context.read<MenuController>().controlMenu,
            ),
          if (!Responsive.isMobile(context))
            Padding(
              padding: EdgeInsets.only(left: defaultPadding),
              child: Text(
                "Sugestões dos usuários",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          if (!Responsive.isMobile(context))
            Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Container(
                width: 350,
                child: SearchField()),
          )
        ],
      ),
    );
  }
}

final _suggestionsBloc = BlocProvider.getBloc<SuggestionsBloc>();

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: _suggestionsBloc.onChangedSearch,
      style: TextStyle(color: bgColor),
      decoration: InputDecoration(
        hintText: "Pesquisar",
        hintStyle: TextStyle(color: bgColor),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}