import '../credentials.dart';

class LocationHelper {
  static String getStaticImageMapUrl({String latitude, String longitude}) {
    return "https://www.mapquestapi.com/staticmap/v5/map?key=$API_KEY&center=$latitude,$longitude&locations=$latitude,$longitude&size=&size=600,170&zoom=16";
  }
}
