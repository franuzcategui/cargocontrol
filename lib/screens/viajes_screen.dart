import 'package:cargocontrol/widgets/viajes_card.dart';
import 'package:flutter/material.dart';
import 'package:cargocontrol/constants.dart' as constants;

class ViajesScreen extends StatelessWidget {
  const ViajesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title:
                Text('Viajes', style: const constants.TextStyles().titleText3),
            bottom: const TabBar(tabs: [
              Tab(text: 'Todos'),
              Tab(text: 'En camino'),
              Tab(text: 'Completados'),
            ]),
          ),
          body: const TabBarView(
            children: [
              ViajesList(),
              ViajesList(),
              ViajesList(),
            ],
          )),
    );
  }
}

class ViajesList extends StatelessWidget {
  const ViajesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView(
        children: const [
          ViajesCard(),
          ViajesCard(),
        ],
      ),
    );
  }
}
