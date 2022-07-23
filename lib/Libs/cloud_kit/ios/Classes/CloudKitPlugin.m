#import "CloudKitPlugin.h"
#if __has_include(<cloud_kit/cloud_kit-Swift.h>)
#import <cloud_kit/cloud_kit-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "cloud_kit-Swift.h"
#endif

@implementation CloudKitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCloudKitPlugin registerWithRegistrar:registrar];
}
@end
