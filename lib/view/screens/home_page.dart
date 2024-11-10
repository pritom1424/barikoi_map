import 'package:barikoi_map/provider/homescreen_provider.dart';
import 'package:barikoi_map/utils/app_components/app_components.dart';
import 'package:barikoi_map/view/widgets/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import "package:maplibre_gl/maplibre_gl.dart";
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraPosition initialPosition =
      const CameraPosition(target: LatLng(23.835677, 90.380325), zoom: 12);
  //MapLibreMapController? mController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //  mController?.dispose();
    Provider.of<HomescreenProvider>(context, listen: false)
        .mapController
        ?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppComponents.screenSize = MediaQuery.of(context).size;
    final homeScreenProvider =
        Provider.of<HomescreenProvider>(context, listen: false);
    return FutureBuilder(
        future: homeScreenProvider.getLocation(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: AppComponents.screenSize.height,
              width: double.infinity,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          if (!snapShot.hasData) {
            return SizedBox(
              height: AppComponents.screenSize.height,
              width: double.infinity,
              child: const Center(
                child: Text("Please turn on location!"),
              ),
            );
          }

          initialPosition = CameraPosition(target: snapShot.data!, zoom: 12);
          return MapWidget(initialPosition: initialPosition);
        });
  }
}
