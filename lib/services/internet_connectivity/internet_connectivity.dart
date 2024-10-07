import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';

// Method to check both connection type and internet accessibility
Future<bool> hasInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();

  if (connectivityResult != ConnectivityResult.none) {
    // Check if we can actually ping an external server
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true; // Internet is available
      }
    } on SocketException catch (_) {
      return false; // Device is connected but no internet
    }
  }
  return false; // No connection type found
}
