import 'package:barikoi_map/provider/homescreen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:provider/provider.dart';

class AddressWidget extends StatelessWidget {
  final CameraPosition initialPosition;

  const AddressWidget({super.key, required this.initialPosition});

  @override
  Widget build(BuildContext context) {
    final homeScreenProvider =
        Provider.of<HomescreenProvider>(context, listen: false);
    List<LatLng> decodePolyline(String encoded) {
      PolylinePoints polylinePoints = PolylinePoints();
      List<PointLatLng> points = polylinePoints.decodePolyline(encoded);

      return points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    }

    return Consumer<HomescreenProvider>(builder: (context, snapDetails, ch) {
      if (!snapDetails.showAddressDetails ||
          snapDetails.currentLatLng == null) {
        return const SizedBox.shrink();
      }

      return FutureBuilder(
          future: snapDetails.locationInfo(snapDetails.currentLatLng!),
          builder: (context, snapLocDetails) {
            return FutureBuilder(
                future: snapDetails.locationRouteInfo(
                    initialPosition.target, snapDetails.currentLatLng!),
                builder: (context, snapRoute) {
                  return Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Address Details',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  snapDetails.setShowAddressDetails(false);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(snapLocDetails.data?.place.country ??
                              "Country Unknown"),
                          Text(
                            snapLocDetails.data?.place.addressBn ??
                                'No address details available',
                            style: const TextStyle(fontSize: 16),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                snapDetails.setShowAddressDetails(false);
                                if (snapRoute.hasData) {
                                  homeScreenProvider.mapController?.addLine(
                                    LineOptions(
                                        geometry: decodePolyline(
                                            snapRoute.data!.routes[0].geometry),
                                        lineColor: "#FF0000",
                                        lineOpacity: 0.5,
                                        lineWidth: 2.5,
                                        draggable: true),
                                  );
                                }
                              },
                              child: const Text("Direction"))
                        ],
                      ),
                    ),
                  );
                });
          });
    });
  }
}
