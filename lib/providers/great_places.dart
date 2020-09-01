import 'package:flutter/foundation.dart';
import 'dart:io';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String title,
    File image,
    PlaceLocation location,
  ) {
    final id = DateTime.now().toIso8601String();
    _items.add(
      Place(
        id: id,
        image: image,
        title: title,
        location: location,
      ),
    );
    notifyListeners();
    DBHelper.insert("places", {
      "id": id,
      "title": title,
      "image": image.path,
      "loc_lat": location.latitude,
      "loc_lng": location.longitude,
      "address": location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DBHelper.getData("places");
    _items = data
        .map(
          (e) => Place(
            id: e["id"],
            title: e["title"],
            image: File(e["image"]),
            location: PlaceLocation(
              latitude: e["loc_lat"],
              longitude: e["loc_lng"],
              address: e["address"],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
