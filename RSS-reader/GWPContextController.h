//
//  GWPContextController.h
//  RSS-reader
//
//  Created by Student on 08/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GWPContextControllerParent.h"

@interface GWPContextController : NSObject

@property (strong, readonly) NSManagedObjectContext *context;
@property (weak, nonatomic, readonly) id<GWPContextControllerParent> parentController;

-(id)initWithContext:(NSManagedObjectContext *)context
    parentController:(id<GWPContextControllerParent>)parent;

-(void)parentControllerHasUpdated;

@end
