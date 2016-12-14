//
//  GWPRSSTableCC.m
//  RSS-reader
//
//  Created by Student on 09/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSTableCC.h"
#import "GWPRSS.h"
#import "GWPRSSData+CoreDataClass.h"
#import "GWPNewsData+CoreDataClass.h"


@interface GWPRSSTableCC()

@property (readwrite) NSArray *rssList;

@end

@implementation GWPRSSTableCC

@synthesize rssList;
@synthesize delegate;


-(void)updateRSSList
{

    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"RSS"];
        
    NSError *error = nil;
    NSArray *results = [self.context executeFetchRequest:request error:&error];
    
    NSMutableArray *rss = [[NSMutableArray alloc] initWithCapacity:0];
    
    for( GWPRSSData *data in results)
        [rss addObject:[self fromDataToRSS:data]];
    self.rssList = rss;
    [self.delegate dbControllerUpdateCompleted:self];
}

-(void)parentControllerHasUpdated
{
    dispatch_async(dispatch_get_main_queue(), ^{
            [self updateRSSList];
    });

}

-(GWPRSS *)fromDataToRSS:(GWPRSSData *)data
{
    GWPRSS *result = [GWPRSS createRSS:data.title
                                  link:[NSURL URLWithString:data.link]
                            unreadNews:0];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"News"];
    request.predicate = [NSPredicate predicateWithFormat:@"rssLink == %@ and wasRead == 0",data.link];
    NSError *error = nil;
    NSArray *news = [self.context executeFetchRequest:request error:&error];
    result.unreadNews = [news count];
    return result;
}


@end
