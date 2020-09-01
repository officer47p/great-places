import 'dart:convert';

import 'package:http/http.dart' as http;

import '../credentials.dart';

class LocationHelper {
  static String getStaticImageMapUrl({String latitude, String longitude}) {
    return "https://www.mapquestapi.com/staticmap/v5/map?key=$API_KEY&center=$latitude,$longitude&locations=$latitude,$longitude&size=&size=600,170&zoom=16";
  }

  static Future<String> getPlaceAddress(
      String latitude, String longitude) async {
    final url =
        "http://www.mapquestapi.com/geocoding/v1/reverse?key=$API_KEY&location=$latitude,$longitude";
    final res = await http.get(url);
    final aData = json.decode(res.body)["results"][0]["locations"][0];
    final List addressList = [
      aData['street'],
      aData['adminArea6'],
      aData['adminArea5'],
      aData['adminArea4'],
      aData['adminArea3'],
      aData['adminArea1']
    ].where((element) => (element as String).length > 0).toList();
    return addressList.join(" ,");
  }
}
