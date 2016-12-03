//
//  GWPRSSNewsReciever.m
//  RSS-reader
//
//  Created by Student on 22/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSNewsReciever.h"

@interface GWPRSSNewsReciever()

@property (strong, nonatomic, readwrite) NSMutableDictionary *rssData;

@end

@implementation GWPRSSNewsReciever
@synthesize delegate;
@synthesize currentRSS;



+(id)getReciever
{
    static id selfReciever;
    if(!selfReciever)
    {
        selfReciever = [[GWPRSSNewsReciever alloc] init];
        GWPRSSNewsReciever * reciever =(GWPRSSNewsReciever *)selfReciever;
        reciever.rssData = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return selfReciever;
}



-(NSArray *)newsList
{
    NSMutableArray *result =[[NSMutableArray alloc]init];
    NSMutableArray *currentNewsList = [[self.rssData objectForKey:self.currentRSS.link] news];
    
    for(GWPShortNews *news in currentNewsList)
    {
        GWPShortNews *newNews = [news tableCopy];
        [result addObject:newNews];
    }
    return result;
}

-(void)setNewsList:(NSMutableArray *)list
{
    GWPRSSDataPack *rss = [self.rssData objectForKey:self.currentRSS.link];
    rss.news = list;
}

-(NSMutableArray *)rssList
{
    NSMutableArray *result = [[NSMutableArray alloc]initWithCapacity:0];
    for(NSURL *url in self.rssData)
    {
        GWPRSSDataPack *pack = [self.rssData objectForKey:url];
        GWPRSS *newRSS = [[GWPRSS alloc]init];
        newRSS.title = [pack.title copy];
        newRSS.link = [pack.link copy];
        [result addObject:newRSS];
    }
    return result;
}

-(void)updateNews
{
    [self.delegate updateStarded];
    [self recieveNewsList];
}

-(void)recieveNewsList{
    GWPRSSParserDelegate * parserDelegate = [[GWPRSSParserDelegate alloc] init];
    parserDelegate.urlToParse = currentRSS.link;
    NSArray *parsingResult = [parserDelegate parse];
    
    if(![parsingResult count])
    {
        [self.delegate updateCompletedWithError];
        return;
    }
    
    int ID = 0;
    for(GWPShortNews* news in parsingResult)
    {
        news.newsID = [NSNumber numberWithInt:ID];
        ++ID;
    }
    [self.delegate inputClosed];
    self.newsList = [parsingResult mutableCopy];
    [self.delegate updateCompletedWithResult];
}

-(void)addNewRSS:(GWPRSS *)rss
{
    if([self.rssData objectForKey:rss.link])
        @throw @"!!!!!!";
    GWPRSSDataPack *newRSS = [[GWPRSSDataPack alloc] initWithTitle:rss.title
                                                              link:rss.link
                                                         newsArray:nil];
    [self.rssData setObject:newRSS
                     forKey:newRSS.link];
}

-(void)editRSS:(GWPRSS *)rss
        newRSS:(GWPRSS *)newRSS
{
    GWPRSSDataPack * oldData = [self.rssData objectForKey:rss.link];
    GWPRSSDataPack * newData = [[GWPRSSDataPack alloc]initWithTitle:newRSS.title
                                                               link:newRSS.link
                                                          newsArray:oldData.news];
    newData.lastGUID = oldData.lastGUID;
    newData.unreadNews = oldData.unreadNews;
    [self.rssData removeObjectForKey:rss.link];
    [self.rssData setObject:newData forKey:newData.link];
}

-(void)deleteRSS:(GWPRSS *)rss
{
    [self.rssData removeObjectForKey:rss.link];
}

-(void)loadBaseData
{
    GWPRSSDataPack *rt = [[GWPRSSDataPack alloc]initWithTitle:@"Russian RT"
                                                         link:[NSURL URLWithString:@"https://russian.rt.com/rss"]
                                                    newsArray:nil];
    GWPRSSDataPack *google = [[GWPRSSDataPack alloc] initWithTitle:@"Google News"
                                                              link:[NSURL URLWithString:@"https://news.google.com/?output=rss"]
                                                                              newsArray:nil];
    GWPRSSDataPack *vesti = [[GWPRSSDataPack alloc] initWithTitle:@"Vesti.ru"
                                                             link:[NSURL URLWithString:@"http://www.vesti.ru/vesti.rss"]
                                                        newsArray:nil];
    GWPRSS *current = [[GWPRSS alloc] init];
    
    current.title = rt.title;
    current.link = rt.link;
    
    [self.rssData setObject:rt forKey:rt.link];
    [self.rssData setObject:google forKey:google.link];
    [self.rssData setObject:vesti forKey:vesti.link];
    self.currentRSS = current;
}

@end
