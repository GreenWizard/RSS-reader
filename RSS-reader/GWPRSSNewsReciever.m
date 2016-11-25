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

+(id)selfHolder:(BOOL)destroy create:(BOOL)create
{
    static id selfReciever;
    if(create)
        selfReciever = [[GWPRSSNewsReciever alloc]init];
    if(destroy)
        selfReciever = nil;
    return selfReciever;
}

+(id)getReciever
{
    id result = [self selfHolder:NO create:NO];
    if(!result)
        result = [self selfHolder:NO create:YES];
    return result;
}

+(void)killReciever
{
    [self selfHolder:NO create:YES];
}

-(GWPShortNews *)newsById:(NSNumber *)newsId
{
    for(GWPShortNews *news in newsList)
    {
        if([news.newsId isEqual:newsId])
        {
            GWPShortNews *newNews = [news bodyViewCopy];
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
        GWPShortNews *newNews = [news tableCopy];
        [result addObject:newNews];
    }
    return result;
}

-(void)update
{
    [self.delegate updateStarded];
    [self recieveNewsList];
    [self.delegate updateCompletedWithResult];
}

-(void)recieveNewsList{
    GWPRSSParserDelegate * parserDelegate = [[GWPRSSParserDelegate alloc] init];
    NSArray *parsingResult = [parserDelegate parse];
    
    if(![parsingResult count])
    {
        [self.delegate updateCompletedWithError:@"InternetConnectionError"];
        return;
    }
    
    int ID = 0;
    for(GWPShortNews* news in parsingResult)
    {
        news.newsId = [NSNumber numberWithInt:ID];
        ++ID;
    }
    [self.delegate inputClosed];
    newsList = [parsingResult mutableCopy];
}
@end
