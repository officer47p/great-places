import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';

import '../models/place.dart';

import '../helpers/location_helper.dart';

class PlaceDetailScreen extends StatelessWidget {
  static String routeName = "/place-detail";
  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute.of(context).settings.arguments;
    final Place place = Provider.of<GreatPlaces>(context).getPlaceById(placeId);
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.file(
              place.image,
              width: double.infinity,
              height: 450,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    "Address: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      place.location.address,
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                child: Text(
                  "Where is it on map?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () => LocationHelper.openMap(
                    place.location.latitude, place.location.longitude),
                child: Image.network(
                  LocationHelper.getStaticImageMapUrl(
                    latitude: place.location.latitude,
                    longitude: place.location.longitude,
                  ),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
