import 'package:flutter/foundation.dart';
import 'dart:io';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String title,
    File image,
  ) {
    _items.add(
      Place(
        id: DateTime.now().toIso8601String(),
        image: image,
        title: title,
        location: null,
      ),
    );
    notifyListeners();
  }
}
