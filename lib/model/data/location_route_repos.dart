import 'package:barikoi_map/model/models/location_route.dart';
import 'package:barikoi_map/utils/app_constants/api_links.dart';
import 'package:barikoi_map/utils/app_constants/app_constants.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:http/http.dart' as http;

class LocationRouteRepos {
  Future<LocationRoute?> getRouteInfo(
      LatLng location1, LatLng location2) async {
    try {
      const String endPoint = '/v2/api/route/';
      final Uri url = Uri.parse(
        '${ApiLinks.baseUrl}$endPoint${location1.longitude},${location1.latitude};${location2.longitude},${location2.latitude}?api_key=${AppConstants.apikey}&geometries=polyline',
      );

      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        final model = locationRouteFromJson(response.body);
        return model;
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('An error occurred: $e');
      return null;
    }
  }
}
