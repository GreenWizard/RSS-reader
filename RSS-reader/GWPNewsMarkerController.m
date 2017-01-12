//
//  GWPNewsMarkerController.m
//  RSS-reader
//
//  Created by Student on 10/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPNewsMarkerController.h"
#import "GWPNews.h"
#import "GWPRSSData+CoreDataClass.h"
#import "GWPNewsData+CoreDataClass.h"

@implementation GWPNewsMarkerController

-(void)markNews:(GWPNews *)news
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"News"];
    request.predicate = [NSPredicate predicateWithFormat:@"title LIKE %@", news.title];
    
    NSError *error = nil;
    NSArray *results = [self.context executeFetchRequest:request error:&error];    
    
    GWPNewsData *data = results.firstObject;
    if(!data.wasRead)
    {
        data.wasRead = YES;
        
        if([self.context hasChanges])
            [self.context performBlockAndWait:
             ^{
                 NSError *error = nil;
                 [self.context save:&error];
             }];
        
        [self.parentController contextController:self
                               saveParentContext:self.context];
    }
}

@end
