//
//  GWPRSSNewsReciever.m
//  RSS-reader
//
//  Created by Student on 22/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSNewsReciever.h"

@interface GWPRSSNewsReciever()

@property (readwrite) NSMutableArray *newsList;

@end

@implementation GWPRSSNewsReciever
@synthesize newsList;
@synthesize numberOfNews;
@synthesize delegate;

+(id)selfHolder:(BOOL)destroy create:(BOOL)create{
    static id selfReciever;
    if(create)
        selfReciever = [[GWPRSSNewsReciever alloc]init];
    if(destroy)
        selfReciever = nil;
    return selfReciever;
}

+(id)getReciever{
    id result = [self selfHolder:NO create:NO];
    if(!result)
        result = [self selfHolder:NO create:YES];
    return result;
}

+(void)killReciever{
    [self selfHolder:NO create:YES];
}

-(GWPShortNews *)newsById:(NSNumber *)newsId{
    for(GWPShortNews *news in newsList)
    {
        if([news.Id isEqual:newsId]){
            GWPShortNews *newNews = [[GWPShortNews alloc]init];
            newNews.Id = [news.Id copy];
            newNews.title = [news.title copy];
            newNews.details = [news.details copy];
            newNews.publicationDate = [news.publicationDate copy];
            newNews.link = [news.link copy];
            return newNews;
        }
    }
    return nil;
}

-(NSArray *)getNewsList
{
    NSMutableArray *result =[[NSMutableArray alloc]init];
    for(GWPShortNews *news in newsList)
    {
        GWPShortNews *newNews = [[GWPShortNews alloc]init];
        newNews.Id = [news.Id copy];
        newNews.title = [news.title copy];
        newNews.details = [news.details copy];
        newNews.publicationDate = [news.publicationDate copy];
        [result addObject:newNews];
    }
        
    return result;
}

-(void)update{
    [self.delegate updateStarded];
    [self recieveNewsList];
    [self.delegate updateCompletedWithResult];
}

-(void)recieveNewsList{
    GWPRSSParserDelegate * parserDelegate = [[GWPRSSParserDelegate alloc] init];
    NSMutableArray *recievedNewsList = [[NSMutableArray alloc]init];
    [parserDelegate parse];
    NSArray *parsingResult = parserDelegate.marrXMLData;
    
    if(![parsingResult count])
    {
        [self.delegate updateCompletedWithError:@"InternetConnectionError"];
        return;
    }
    
    int ID = 0;
    for(NSDictionary* newsRecord in parsingResult)
    {
        GWPShortNews *news = [[GWPShortNews alloc]init];
        news.Id = [NSNumber numberWithInt:ID];
        news.title = [newsRecord objectForKey:@"title"];
        news.details = [newsRecord objectForKey:@"description"];
        news.publicationDate = [newsRecord objectForKey:@"pubDate"];
        news.link = [NSURL URLWithString:[newsRecord objectForKey:@"link"]];
        [recievedNewsList addObject:news];
        ++ID;
    }
    [self.delegate inputClosed];
    newsList = recievedNewsList;
}
@end
