import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/common/responsive.dart';
import 'package:gerenciador_aquifero/controllers/MenuController.dart';
import 'package:gerenciador_aquifero/screens/guia_pratico/components/add_pdf.dart';
import 'package:provider/provider.dart';


class PdfHeader extends StatelessWidget {
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
                "Guia Práticos",
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
                    child: Text('Adicionar'),
                    style: ElevatedButton.styleFrom(primary: bgBlue),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AddPdf());
                    },
                  ),
                ),
              )),
        ],
      ),
    );
  }
}