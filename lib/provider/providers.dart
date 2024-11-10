import 'package:barikoi_map/model/data/location_details_repos.dart';
import 'package:barikoi_map/model/data/location_route_repos.dart';
import 'package:barikoi_map/provider/homescreen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  static List<SingleChildWidget> providers = [
    Provider<LocationDetailsRepos>(
      create: (ctx) => LocationDetailsRepos(),
    ),
    Provider<LocationRouteRepos>(
      create: (ctx) => LocationRouteRepos(),
    ),
    ChangeNotifierProvider(create: (ctx) {
      final lRepos = ctx.read<LocationDetailsRepos>();
      final lRoute = ctx.read<LocationRouteRepos>();
      return HomescreenProvider(lRepos, lRoute);
    })
  ];
}
