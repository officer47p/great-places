import 'package:flutter/material.dart';
import '../models/place.dart';
import 'package:provider/provider.dart';
import "dart:io";

import '../widgets/image_input.dart';
import '../widgets/location_input.dart';
import '../providers/great_places.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add-place";
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final TextEditingController _titleController = TextEditingController();
  File pickedImage;
  PlaceLocation pickedPlace;

  void _selectImage(File file) {
    pickedImage = file;
  }

  void _selectPlace({String lat, String lng, String address}) {
    pickedPlace =
        PlaceLocation(latitude: lat, longitude: lng, address: address);
  }

  void savePlace() {
    if (_titleController.text.isEmpty ||
        pickedImage == null ||
        pickedPlace == null) return;
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, pickedImage, pickedPlace);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Place"),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: "Title"),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: savePlace,
            icon: Icon(Icons.add),
            label: Text("Add Place"),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
