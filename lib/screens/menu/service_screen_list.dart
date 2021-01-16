import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:operativo_final_cliente/models/services.dart';

class ServiceScreenList extends StatelessWidget {
  final Services services;
  const ServiceScreenList(this.services);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                  title: Text(
                services.title,
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: [
                IconButton(
                  icon: const Icon(LineAwesomeIcons.search),
                  color: Colors.white,
                  onPressed: () {},
                  ),
                ]
              ),
            ],
          )
        ],
      ),
    );
  }
}
