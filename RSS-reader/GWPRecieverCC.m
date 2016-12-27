//
//  GWPRecieverCC.m
//  RSS-reader
//
//  Created by Student on 10/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRecieverCC.h"
#import "GWPRSSParser.h"
#import "GWPRecieverControllerParent.h"
#import "GWPRSS.h"
#import "GWPNews.h"
#import "GWPRSSData+CoreDataClass.h"
#import "GWPNewsData+CoreDataClass.h"

@interface GWPRecieverCC()

@property (readonly) id<GWPRecieverControllerParent> parentController;

@end

@implementation GWPRecieverCC

-(void)updateRSS
{
    GWPRSSParser *parser = [[GWPRSSParser alloc] init];
    parser.urlToParse = self.rss.link;
    NSMutableDictionary *results = [parser parse];
    
    if(results)
    {
        GWPRSSData *rssData = [self requestRSSData];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"News"];
        request.predicate = [NSPredicate predicateWithFormat:@"rss == %@", rssData];
    
        NSError *error = nil;
        NSArray *requestResult = [self.context executeFetchRequest:request error:&error];
    
        NSMutableArray *oldNews = [NSMutableArray arrayWithCapacity:0];
    
        for(GWPNewsData *data in requestResult)
        {
            GWPNews *news = [results objectForKey:[NSURL URLWithString:data.link]];
            if(news)
                [results removeObjectForKey:[NSURL URLWithString:data.link]];
            else
                [oldNews addObject:data];
        }
        if([oldNews count])
            NSLog(@"push new %lu results in %@ rss", [oldNews count], self.rss.title);
        
        for(GWPNewsData *data in oldNews)
            [self.context deleteObject:data];
            
    
        for(NSURL *url in results)
            [self insertNews:[results objectForKey:url]];
    
        if([self.context hasChanges])
            [self.context performBlockAndWait:
             ^{
                 NSError *error = nil;
                 [self.context save:&error];
                 if(error)
                     @throw error;
             }];
    
        [self.parentController contextControllerUpdateComplete:self];
    }
}

-(void)insertNews:(GWPNews *)news
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"RSS"];
    request.predicate = [NSPredicate predicateWithFormat:@"link == %@", [self.rss.link absoluteString]];
    NSError *error = nil;
    NSArray *requestResult = [self.context executeFetchRequest:request error:&error];
    GWPRSSData *rssData = requestResult.firstObject;

    if(rssData)
    {
        GWPNewsData *newsObject = [NSEntityDescription insertNewObjectForEntityForName:@"News"
                                                          inManagedObjectContext:self.context];
        newsObject.title = news.title;
        newsObject.link = [news.link absoluteString];
        newsObject.details = news.details;
        newsObject.pubDate = news.publicationDate;
        newsObject.wasRead = NO;
        newsObject.rss = rssData;
    
        [self.context insertObject:newsObject];
        [rssData addNewsObject:newsObject];
    }
}

-(GWPRSSData *)requestRSSData
{
    NSFetchRequest *rssRequest = [[NSFetchRequest alloc] initWithEntityName:@"RSS"];
    rssRequest.predicate = [NSPredicate predicateWithFormat:@"link == %@", [self.rss.link absoluteString]];
    
    NSError *error = nil;
    NSArray *requestResult = [self.context executeFetchRequest:rssRequest error:&error];
    
    return requestResult.firstObject;
}

@end
