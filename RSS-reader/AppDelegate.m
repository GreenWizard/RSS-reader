//
//  AppDelegate.m
//  RSS-reader
//
//  Created by User on 14/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import "AppDelegate.h"
#import "GWPBackgroundFetchController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    return YES;
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    GWPBackgroundFetchController *controller = [GWPBackgroundFetchController initWithCompletionHandler:completionHandler];
    [controller updateAllRSS];
}
@end
