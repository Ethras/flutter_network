import 'dart:async';

import 'package:flutter/services.dart';

class FlutterNetwork {
  static const MethodChannel _channel =
      const MethodChannel('flutter_network');
  static const EventChannel  _stream  = EventChannel("com_ethras_flutter_network/stream");

  static  Stream<bool> dataRestrictedStateChanged() {
    return _stream.receiveBroadcastStream().map((restricted) => restricted as bool);
  }

  static Future<bool> get isCellularDataRestricted async {
    final bool isRestricted = await _channel.invokeMethod('isCellularDataRestricted');
    return isRestricted;
  }
}
