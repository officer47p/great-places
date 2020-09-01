import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import '../providers/great_places.dart';
import './add_place_screen.dart';
import './place_detail_screen.dart';

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
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<GreatPlaces>(
              builder: (context, gp, child) {
                return gp.items.length == 0
                    ? Center(
                        child: Text("No Places Yet..."),
                      )
                    : ListView(
                        children: gp.items
                            .map(
                              (e) => ListTile(
                                onTap: () => Navigator.of(context).pushNamed(
                                    PlaceDetailScreen.routeName,
                                    arguments: e.id),
                                title: Text(e.title),
                                subtitle: Text(
                                  e.location.address,
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(e.image),
                                ),
                              ),
                            )
                            .toList());
              },
            );
          }
        },
      ),
    );
  }
}
