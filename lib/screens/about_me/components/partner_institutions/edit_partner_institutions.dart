import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/models/about_me/partner_institutions.dart';
import 'package:gerenciador_aquifero/screens/about_me/components/partner_institutions/images_field_institutions.dart';
import 'package:gerenciador_aquifero/stores/edit_partner_institutions_store.dart';
import 'package:mobx/mobx.dart';

class EditPartnerInstitutionsScreen extends StatefulWidget {
  EditPartnerInstitutionsScreen(this.partnerInstitutions);

  final PartnerInstitutions partnerInstitutions;

  @override
  _EditPartnerInstitutionsScreenState createState() => _EditPartnerInstitutionsScreenState(partnerInstitutions);
}

class _EditPartnerInstitutionsScreenState extends State<EditPartnerInstitutionsScreen> {

  _EditPartnerInstitutionsScreenState(PartnerInstitutions partnerInstitutions)
      : editing = partnerInstitutions != null,
        store = EditPartnerInstitutionsStore(partnerInstitutions: partnerInstitutions);

  bool editing;

  final EditPartnerInstitutionsStore store;

  @override
  void initState() {
    super.initState();

    when((_) => store.savePartners == true, () {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Dados atualizados com sucesso!'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    final _fieldStyle = TextStyle(color: Colors.black, fontSize: 16);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Instituições parceiras', style: TextStyle(color: secondaryColor)),
        backgroundColor: primaryColor,
        actions: [
          Observer(builder: (_) {
            return Padding(
              padding:
              const EdgeInsets.only(right: 20, bottom: 10, top: 10),
              child: ElevatedButton(
                  onPressed: store.sendPressed,
                  style: ElevatedButton.styleFrom(primary: bgBlue),
                  child: Text('Salva')),
            );
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Observer(
          builder: (_){
            if (store.loading)
              return Padding(
                padding: const EdgeInsets.all(100),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(primaryColor)),
                      SizedBox(height: 5),
                      Text(
                        'Salvando',
                        style: _fieldStyle,
                      )
                    ],
                  ),
                ),
              );
            else
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: defaultPadding, top: defaultPadding),
                    child: Row(
                      children: [
                        Text(
                          'Escolher imagens:',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  ImagesFieldInstitutions(store),
                ],
              );
          },
        ),
      ),
    );
  }
}
