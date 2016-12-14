//
//  GWPNewsTableCC.m
//  RSS-reader
//
//  Created by Student on 08/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPNewsTableCC.h"
#import "GWPRSS.h"
#import "GWPNews.h"
#import "GWPRSSData+CoreDataClass.h"
#import "GWPNewsData+CoreDataClass.h"
#import "GWPNewsTableContextControllerParent.h"

@interface GWPNewsTableCC()

@property (readwrite) NSArray *newsList;
@property (readwrite) id<GWPNewsTableContextControllerParent> parentController;
@property (readwrite, atomic, strong) NSFetchRequest *request;

@end

@implementation GWPNewsTableCC
@synthesize delegate;
@synthesize parentController;
@synthesize newsList;


-(void)updateNews:(GWPRSS *)rss
{
    @try
    {
        [self.parentController contextController:self
                              forceUpdateThisRSS:rss];
        
        self.request = [[NSFetchRequest alloc] initWithEntityName:@"News"];
        self.request.predicate = [NSPredicate predicateWithFormat:@"rssLink == %@", [rss.link absoluteString]];
        [self updateNewsList];
    }
    @catch(NSError *error)
    {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        [self.delegate dbControllerUpdateFailed:self];
    }
}

-(void)parentControllerHasUpdated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateNewsList];
    });
}

-(void)updateNewsList
{
    [self.delegate dbControllerUpdateStarded:self];
    
    if(self.request)
    {
        NSError *error = nil;
        NSArray *results = [self.context executeFetchRequest:self.request error:&error];
    
        NSMutableArray *news = [[NSMutableArray alloc] initWithCapacity:0];
    
        for( GWPNewsData *data in results )
            [news addObject:[self fromDataToNews:data]];
        self.newsList = news;
    }
    
    [self.delegate dbControllerUpdateCompleted:self];
}

-(GWPNews *)fromDataToNews:(GWPNewsData *)data
{
    return [GWPNews createNews:data.title
               publicationDate:data.pubDate
                       details:data.details
                          link:[NSURL URLWithString:data.link]];
}

@end
