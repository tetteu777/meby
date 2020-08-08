import 'package:geolocator/geolocator.dart';

import 'Usuario.dart';
import 'dart:math' as Math;

class CalculadoraDeDistancia {
  List<double> calcularLatitudeELongitude(
      Usuario eu, double distanciaEmMetros) {
    double coef = distanciaEmMetros * 0.0000089;
    double latitude = eu.latitude + coef;
    double longitude = eu.longitude + coef / Math.cos(eu.latitude * 0.018);

    return [latitude, longitude].toList();
  }

  Future<bool> estaPerto(double minhaLat, double minhaLong, double outroLat,
      double outroLong) async {
    double distanceInMeters = await Geolocator()
        .distanceBetween(minhaLat, minhaLong, outroLat, outroLong);

    return distanceInMeters <= 100;
  }
}
