import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  LocationInput(this.onSubmit);
  final Function onSubmit;
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  String _address;

  Future<void> getCurrentUserLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    final address = await LocationHelper.getPlaceAddress(
        _locationData.latitude.toString(), _locationData.longitude.toString());
    print(
        "Latitude: ${_locationData.latitude}, Longitude: ${_locationData.longitude}");
    setState(() {
      _previewImageUrl = LocationHelper.getStaticImageMapUrl(
        latitude: _locationData.latitude.toString(),
        longitude: _locationData.longitude.toString(),
      );
      _address = address;
    });
    widget.onSubmit(
        lat: _locationData.latitude.toString(),
        lng: _locationData.longitude.toString(),
        address: address);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 170,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text(
                  "No Location Chosen",
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  width: double.infinity,
                  // width: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
        if (_address != null) ...[
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                "Address:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  _address,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
        FlatButton.icon(
          onPressed: getCurrentUserLocation,
          icon: Icon(Icons.location_on),
          label: Text("Get Current Location"),
          textColor: Theme.of(context).primaryColor,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [

        //     FlatButton.icon(
        //       onPressed: () {},
        //       icon: Icon(Icons.map),
        //       label: Text("Select On Map"),
        //       textColor: Theme.of(context).primaryColor,
        //     )
        //   ],
        // )
      ],
    );
  }
}
