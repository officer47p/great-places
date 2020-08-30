import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import '../providers/great_places.dart';
import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Places List"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
          ),
        ],
      ),
      body: Consumer<GreatPlaces>(
        builder: (context, gp, child) {
          return gp.items.length == 0
              ? Center(
                  child: Text("No Places Yet..."),
                )
              : ListView(
                  children: gp.items
                      .map(
                        (e) => ListTile(
                          title: Text(e.title),
                          leading: CircleAvatar(
                            backgroundImage: FileImage(e.image),
                          ),
                        ),
                      )
                      .toList());
        },
      ),
    );
  }
}
