import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/models/especie/especie.dart';
import 'package:gerenciador_aquifero/screens/especie/components/image_field_especie.dart';
import 'package:gerenciador_aquifero/stores/new_especie_store.dart';
import 'package:mobx/mobx.dart';

class EditCategoryDialog extends StatefulWidget {
  final Especie especie;

  EditCategoryDialog({this.especie});

  @override
  _EditCategoryDialogState createState() =>
      _EditCategoryDialogState(especie);
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  _EditCategoryDialogState(Especie especie)
      : editing = especie != null,
        store = NewEspecieStore(especie: especie ?? Especie());

  final NewEspecieStore store;

  bool editing;

  @override
  void initState() {
    super.initState();
    when((_) => store.saveEs, () {
      if (editing)
        Navigator.of(context).pop();
      else {
        Navigator.of(context).pop();
      }
    });
  }

  final labelStyle =
      TextStyle(fontWeight: FontWeight.w800, color: Colors.grey, fontSize: 14);

  final contentPadding = const EdgeInsets.fromLTRB(16, 10, 12, 10);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Observer(builder: (_) {
        if (store.loading)
          return Container(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Salvando Espécie',
                    style: TextStyle(fontSize: 16, color: bgBlue),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(primaryColor),
                  )
                ],
              ),
            ),
          );
        else
          return Container(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Carregar imagem: *",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ImagesFieldEspecie(store),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Título em PT: *",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Observer(builder: (_){
                    return TextFormField(
                      initialValue: store.pt ?? '',
                      onChanged: store.setPt,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      decoration: InputDecoration(
                          errorText: store.ptError,
                          contentPadding: EdgeInsets.fromLTRB(16, 16, 32, 16),
                          hintText: "Anfíbio",
                          filled: true,
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withAlpha(125)),
                          fillColor: Colors.grey,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    );
                  }),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Título em EN: *",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Observer(builder: (_){
                    return TextFormField(
                      initialValue: store.en ?? '',
                      onChanged: store.setEn,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      decoration: InputDecoration(
                          errorText: store.enError,
                          contentPadding: EdgeInsets.fromLTRB(16, 16, 32, 16),
                          hintText:
                          "amphibian",
                          filled: true,
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withAlpha(125)),
                          fillColor: Colors.grey,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    );
                  }),
                ],
              ),
            ),
          );
      }),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: !store.loading
                    ? () {
                  delete(context);
                }
                    : null,
                child: const Text('Remover', style: TextStyle(color: Colors.red)),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: !store.loading
                        ? () {
                      Navigator.of(context).pop();
                    }
                        : null,
                    child: const Text('Voltar'),
                  ),
                  Observer(builder: (_){
                    return GestureDetector(
                      onTap: store.invalidSendPressed,
                      child: TextButton(
                        onPressed: store.sendPressed,
                        style: TextButton.styleFrom(primary: primaryColor),
                        child: const Text('Salvar'),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void delete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Excluir'),
        content: Text('Ateção: esse procedimento irá excluir todas as sub espécie cadastradas!'),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: Text('Não', style: TextStyle(color: Theme.of(context).primaryColor),),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              store.especie.delete(store.especie);
            },
            child: Text('Sim', style: TextStyle(color: Colors.red),),
          ),
        ],
      ),
    );
  }
}
