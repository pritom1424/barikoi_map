import 'package:barikoi_map/model/data/location_details_repos.dart';
import 'package:barikoi_map/model/data/location_route_repos.dart';
import 'package:barikoi_map/model/models/location_model.dart';
import 'package:barikoi_map/model/models/location_route.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class HomescreenProvider with ChangeNotifier {
  final LocationDetailsRepos locationDetailsRepos;
  final LocationRouteRepos locationRouteRepos;

  HomescreenProvider(this.locationDetailsRepos, this.locationRouteRepos);
  bool _showAddressDetails = false;

  MapLibreMapController? _mapController;

  MapLibreMapController? get mapController {
    return _mapController;
  }

  LatLng? _currentLatLng;

  LatLng? get currentLatLng {
    return _currentLatLng;
  }

  bool get showAddressDetails {
    return _showAddressDetails;
  }

  void setMapController(MapLibreMapController mCOntrol) {
    _mapController = mCOntrol;
    notifyListeners();
  }

  void setCurrentLatLng(LatLng curr) {
    _currentLatLng = curr;
    notifyListeners();
  }

  void setShowAddressDetails(bool didShow) {
    _showAddressDetails = didShow;
    notifyListeners();
  }

  Future<LocationModel?> locationInfo(LatLng loc) async {
    final info = locationDetailsRepos.getLocationInfo(loc);

    return info;
  }

  Future<LocationRoute?> locationRouteInfo(LatLng l1, LatLng l2) async {
    final info = locationRouteRepos.getRouteInfo(l1, l2);
    return info;
  }

  Future<LatLng?> getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    return LatLng(_locationData.latitude!, _locationData.longitude!);
  }
}
