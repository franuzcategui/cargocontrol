import 'package:cargocontrol/common_widgets/choferes_card.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/utils/constants.dart' as constants;

class ChoferesScreen extends StatelessWidget {
  const ChoferesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Choferes', style: const constants.TextStyles().titleText3),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration:
                  constants.DecorationStyles.searchBarDecoration1.copyWith(
                hintText: 'Buscar choferes',
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: const [
              ChoferesCard(),
              ChoferesCard(),
            ],
          ),
        ],
      ),
    );
  }
}
