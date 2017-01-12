//
//  GWPDBControllerFabric.h
//  RSS-reader
//
//  Created by Student on 08/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWPNewsListControllerProtocol.h"
#import "GWPNewsMarkerControllerProtocol.h"
#import "GWPRSSListControllerProtocol.h"
#import "GWPEditControllerProtocol.h"

@interface GWPDBControllerFactory : NSObject

+(id<GWPNewsListControllerProtocol>)newsListController;
+(id<GWPRSSListControllerProtocol>)rssListController;
+(id<GWPNewsMarkerControllerProtocol>)newsMarkerController;
+(id<GWPEditControllerProtocol>)editController;

@end
