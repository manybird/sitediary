#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
@import AppCenter;
@import AppCenterAnalytics;
@import AppCenterCrashes;
@import GoogleMaps;

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
      [MSAppCenter start:@"4c10153e-441f-4ee6-8773-361871ff3c5f" withServices:@[
        [MSAnalytics class],
        [MSCrashes class]
      ]];
      [GMSServices provideAPIKey:@"AIzaSyCv1Vk7DKKrquoAtBxXcBMLF6VkJPXTqVY"];

    [GeneratedPluginRegistrant registerWithRegistry:self];

  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
