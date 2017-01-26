//
//  GWPBackgroundFetchController.h
//  RSS-reader
//
//  Created by Student on 26/01/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GWPBackgroundFetchController : NSObject

@property (readwrite) BOOL updateFailedWhithError;
@property (readwrite) BOOL updateHaveResult;

+(GWPBackgroundFetchController *)initWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;
-(void)updateAllRSS;

@end
