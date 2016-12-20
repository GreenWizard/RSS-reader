//
//  GWPRSSEditViewCC.m
//  RSS-reader
//
//  Created by Student on 09/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSEditViewCC.h"
#import "GWPRSS.h"
#import "GWPRSSData+CoreDataClass.h"

@implementation GWPRSSEditViewCC

-(void)deleteRSS:(GWPRSS *)rss
{
    GWPRSSData *object = [self findObject:rss];
    if(object)
    {
        [self deleteNews:rss];
        [self.context deleteObject:object];
        [self save];
    }
}

-(void)addNewRSS:(GWPRSS *)rss
{
    GWPRSSData *object = [self findObject:rss];
    if(!object)
    {
        GWPRSSData *newObject = [NSEntityDescription insertNewObjectForEntityForName:@"RSS"
                                                              inManagedObjectContext:self.context];
        newObject.title = rss.title;
        newObject.link = [rss.link absoluteString];
        
        [self.context insertObject:newObject];
        [self save];
    }
}

-(void)editRSS:(GWPRSS *)rss newRSS:(GWPRSS *)newRSS
{
    GWPRSSData *object = [self findObject:rss];
    if(object)
    {
        object.title = newRSS.title;
        object.link = [newRSS.link absoluteString];
        
        [self save];
    }
}

-(GWPRSSData *)findObject:(GWPRSS *)rss
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"RSS"];
    request.predicate = [NSPredicate predicateWithFormat:@"link == %@", [rss.link absoluteString]];
    
    NSError *error = nil;
    NSArray *results = [self.context executeFetchRequest:request error:&error];
    if ([results count] != 1)
    {
        NSLog(@"Error fetching News objects: %@\n%@", [error localizedDescription], [error userInfo]);
        return nil;
    }
    
    return results.firstObject;
}

-(void)deleteNews:(GWPRSS *)rss
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"News"];
    request.predicate = [NSPredicate predicateWithFormat:@"rssLink == %@", [rss.link absoluteString]];
    NSError *error = nil;
    NSArray *results = [self.context executeFetchRequest:request error:&error];
    
    for(GWPRSSData *data in results)
        [self.context deleteObject:data];
}

-(void)save
{
    @try
    {
        if([self.context hasChanges])
            [self.context performBlockAndWait:
             ^{
                 NSError *error = nil;
                 [self.context save:&error];
                 if(error)
                     @throw error;
             }];
        
        [self.parentController contextController:self
                               saveParentContext:self.context];
        
    }
    @catch(NSError *error)
    {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}

@end
