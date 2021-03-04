import 'package:geolocator/geolocator.dart';
import 'networking.dart';


class location {
  var longitude;
  var latitude;

  Future<void> GetLocation() async {
    try {
      Position position = await Geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      longitude = position.longitude;
      latitude = position.latitude;

    } catch (e) {
      print(e);
    }
  }

}
