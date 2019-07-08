#import "FlutterNetworkPlugin.h"
#import <flutter_network/flutter_network-Swift.h>

@implementation FlutterNetworkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterNetworkPlugin registerWithRegistrar:registrar];
}
@end
