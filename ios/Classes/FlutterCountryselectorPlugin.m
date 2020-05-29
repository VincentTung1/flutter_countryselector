#import "FlutterCountryselectorPlugin.h"
#if __has_include(<flutter_countryselector/flutter_countryselector-Swift.h>)
#import <flutter_countryselector/flutter_countryselector-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_countryselector-Swift.h"
#endif

@implementation FlutterCountryselectorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterCountryselectorPlugin registerWithRegistrar:registrar];
}
@end
