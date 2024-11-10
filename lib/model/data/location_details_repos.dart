import 'package:barikoi_map/model/models/location_model.dart';
import 'package:barikoi_map/utils/app_constants/api_links.dart';
import 'package:barikoi_map/utils/app_constants/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:maplibre_gl/maplibre_gl.dart';

class LocationDetailsRepos {
  Future<LocationModel?> getLocationInfo(LatLng location) async {
    try {
      const String endPoint = '/v2/api/search/reverse/geocode';
      final Uri url = Uri.parse(
        '${ApiLinks.baseUrl}$endPoint?api_key=${AppConstants.apikey}&longitude=${location.longitude}&latitude=${location.latitude}&district=true&post_code=true&country=true&sub_district=true&union=true&pauroshova=true&location_type=true&division=true&address=true&area=true&bangla=true',
      );

      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        return locationModelFromJson(response.body);
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
