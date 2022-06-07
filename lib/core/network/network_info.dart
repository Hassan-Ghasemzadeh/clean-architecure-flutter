import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(Object object);

  @override
  Future<bool> get isConnected {
    return _checkForConnection();
  }
}

Future<bool> _checkForConnection() async {
  final result = await Connectivity().checkConnectivity();

  if (result != ConnectivityResult.none) {
    return true;
  }
  return false;
}
