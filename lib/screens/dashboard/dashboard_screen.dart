import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';

import 'components/header.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Text(
                'Bem vindo ao Aquiféro, seu sistema de controle',
                style: TextStyle(fontSize: 22, color: bgColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
