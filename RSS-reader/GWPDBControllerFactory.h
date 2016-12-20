//
//  GWPDBControllerFabric.h
//  RSS-reader
//
//  Created by Student on 08/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWPDBContollerForNewsTable.h"
#import "GWPDBContollerForNewsBodyView.h"
#import "GWPDBContollerForRSSTable.h"
#import "GWPDBControllerForRSSEditView.h"

@interface GWPDBControllerFactory : NSObject

+(id<GWPDBContollerForNewsTable>)newsTableDBController;
+(id<GWPDBContollerForRSSTable>)rssTableDBController;
+(id<GWPDBContollerForNewsBodyView>)newsBodyViewDBController;
+(id<GWPDBControllerForRSSEditView>)rssEditViewDBController;

@end
