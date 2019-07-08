import 'dart:async';

import 'package:flutter/services.dart';

class FlutterNetwork {
  static const MethodChannel _channel =
      const MethodChannel('flutter_network');

  static Future<bool> get isCellularDataRestricted async {
    final bool isRestricted = await _channel.invokeMethod('isCellularDataRestricted');
    return isRestricted;
  }
}
