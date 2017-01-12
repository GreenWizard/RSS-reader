//
//  GWPNewsListController.m
//  RSS-reader
//
//  Created by Student on 08/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPNewsListController.h"
#import "GWPRSS.h"
#import "GWPNews.h"
#import "GWPRSSData+CoreDataClass.h"
#import "GWPNewsData+CoreDataClass.h"
#import "GWPNewsListControllerParent.h"

@interface GWPNewsListController()

@property (readwrite) NSArray *newsList;
@property (readwrite) id<GWPNewsListControllerParent> parentController;
@property (readwrite, atomic, strong) NSFetchRequest *request;

@end

@implementation GWPNewsListController
@synthesize delegate;
@synthesize parentController;
@synthesize newsList;


-(void)updateNews:(GWPRSS *)rss
{
    @try
    {
        [self.parentController contextController:self
                              forceUpdateThisRSS:rss];
        
        GWPRSSData *rssData = [self rssData:rss];
        
        self.request = [GWPNewsData fetchRequest];
        self.request.predicate = [NSPredicate predicateWithFormat:@"rss == %@", rssData];
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
    GWPNews *news = [GWPNews createNews:data.title
                        publicationDate:data.pubDate
                                details:data.details
                                   link:[NSURL URLWithString:data.link]];
    news.isUnread = !data.wasRead;
    return news;
}

-(GWPRSSData *)rssData:(GWPRSS *)rss
{
    NSFetchRequest *request = [GWPRSSData fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"link == %@", [rss.link absoluteString]];
    
    NSError *error = nil;
    NSArray *results = [self.context executeFetchRequest:request error:&error];
    return results.firstObject;
}

@end
