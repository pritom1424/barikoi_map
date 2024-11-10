import 'package:barikoi_map/provider/homescreen_provider.dart';
import 'package:barikoi_map/utils/app_constants/app_constants.dart';
import 'package:barikoi_map/view/widgets/address_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:provider/provider.dart';

class MapWidget extends StatelessWidget {
  final CameraPosition initialPosition;
  const MapWidget({super.key, required this.initialPosition});

  @override
  Widget build(BuildContext context) {
    final homeScreenProvider =
        Provider.of<HomescreenProvider>(context, listen: false);

    _OnSymboltapped(Symbol symbol) {
      final homeScreenProvider =
          Provider.of<HomescreenProvider>(context, listen: false);
      //update symbol text when tapped
      if (symbol.options.iconImage == "home-marker") {
        homeScreenProvider.setShowAddressDetails(false);
        homeScreenProvider.setCurrentLatLng(initialPosition.target);
        homeScreenProvider.setShowAddressDetails(true);
      } else {
        if (homeScreenProvider.currentLatLng != null) {
          homeScreenProvider.setShowAddressDetails(false);
          homeScreenProvider
              .setCurrentLatLng(homeScreenProvider.currentLatLng!);
          homeScreenProvider.setShowAddressDetails(true);
        }
      }
    }

    // Adds an asset image to the currently displayed style
    Future<void> addImageFromAsset(String name, String assetName) async {
      final ByteData bytes = await rootBundle.load(assetName);
      final Uint8List list = bytes.buffer.asUint8List();
      return Provider.of<HomescreenProvider>(context, listen: false)
          .mapController!
          .addImage(name, list);
    }

    return Stack(
      children: [
        MapLibreMap(
          initialCameraPosition: initialPosition,
          styleString: AppConstants.mapUrl,
          onMapCreated: (MapLibreMapController mapController) {
            //called when map object is created
            homeScreenProvider.setMapController(mapController);

            homeScreenProvider.mapController?.onSymbolTapped.add(
                _OnSymboltapped); // add symbol tap event listener to mapcontroller
          },
          onStyleLoadedCallback: () {
            // Create SymbolOption for creating a symbol in map
            SymbolOptions symbolOptions = SymbolOptions(
              geometry: initialPosition
                  .target, //snapShot.data, // location of the symbol, required
              iconImage: 'home-marker', // icon image of the symbol
              //optional parameter to configure the symbol
              iconSize:
                  .4, // size of the icon in ratio of the actual size, optional
              iconAnchor:
                  'bottom', // anchor direction of the icon on the location specified,  optional
              textField: 'home', // Text to show on the symbol, optional
              textSize: 12.5,
              textOffset: const Offset(0,
                  1.2), // shifting the text position relative to the symbol with x,y axis value, optional
              textAnchor:
                  'bottom', // anchor direction of the text on the location specified, optional
              textColor: '#000000',
              textHaloBlur: 1,
              textHaloColor: '#ffffff',
              textHaloWidth: 0.8,
            );
            addImageFromAsset("home-marker", AppConstants.homeMarkerImagePath)
                .then((value) {
              homeScreenProvider.mapController?.addSymbol(symbolOptions);
            });
          },
          onMapClick: (point, coordinates) {
            SymbolOptions symbolOptions = SymbolOptions(
              geometry: coordinates, // location of the symbol, required
              iconImage: 'custom-marker', // icon image of the symbol

              iconSize:
                  .4, // size of the icon in ratio of the actual size, optional
              iconAnchor:
                  'bottom', // anchor direction of the icon on the location specified,  optional
              textField: 'dest', // Text to show on the symbol, optional
              textSize: 12.5,
              textOffset: const Offset(0,
                  1.2), // shifting the text position relative to the symbol with x,y axis value, optional
              textAnchor:
                  'bottom', // anchor direction of the text on the location specified, optional
              textColor: '#000000',
              textHaloBlur: 1,
              textHaloColor: '#ffffff',
              textHaloWidth: 0.8,
            );
            addImageFromAsset(
                    "custom-marker", AppConstants.destinationMarkerImagePath)
                .then((value) {
              if (homeScreenProvider.mapController != null &&
                  homeScreenProvider.mapController!.symbols.length > 1) {
                homeScreenProvider.mapController?.updateSymbol(
                    homeScreenProvider.mapController!.symbols.last,
                    symbolOptions);
              } else {
                homeScreenProvider.mapController?.addSymbol(symbolOptions);
              }
              homeScreenProvider.mapController?.clearLines();
              homeScreenProvider.setCurrentLatLng(coordinates);
              homeScreenProvider.setShowAddressDetails(true);
            });
          },
        ),
        AddressWidget(
          initialPosition: initialPosition,
        ),
      ],
    );
  }
}
