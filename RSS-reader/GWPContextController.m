//
//  GWPContextController.m
//  RSS-reader
//
//  Created by Student on 08/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPContextController.h"

@interface GWPContextController()

@property (readwrite) NSManagedObjectContext *context;
@property (readwrite) id<GWPContextControllerParent> parentController;

@end

@implementation GWPContextController

-(id)initWithContext:(NSManagedObjectContext *)context parentController:(id<GWPContextControllerParent>)parent
{
    self.context = context;
    self.parentController = parent;
    
    return self;
}

-(void)parentControllerHasUpdated
{
    return;
}

@end
