import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/common/responsive.dart';
import 'package:gerenciador_aquifero/controllers/MenuController.dart';
import 'package:provider/provider.dart';

import 'edit_category_dialog.dart';

class EspecieHeader extends StatelessWidget {
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
                "Lista de Especies",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          if (!Responsive.isMobile(context))
            Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: SizedBox(
              height: 44,
              width: 70,
              child: ElevatedButton(
                child: Text('Nova Espécie'),
                style: ElevatedButton.styleFrom(primary: bgBlue),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => EditCategoryDialog());
                },
              ),
            ),
          )),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        labelStyle: TextStyle(color: Colors.black),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
