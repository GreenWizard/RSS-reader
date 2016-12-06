//
//  ShortNews.m
//  RSS-reader
//
//  Created by User on 16/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPShortNews.h"

@implementation GWPShortNews

+(nonnull GWPShortNews *)createNews:(nonnull NSNumber *)newsID
                              title:(nullable NSString *)title
                    publicationDate:(nullable NSString *)pubDate
                            details:(nullable NSString *)details
                               link:(nullable NSURL *)link
                               giud:(nullable NSURL *)guid
{
    GWPShortNews * news = [[GWPShortNews alloc] init];
    
    news.newsID = newsID;
    news.title = title;
    news.publicationDate = pubDate;
    news.details = details;
    news.link = link;
    news.guid = guid;
    
    return news;
}

-(id)copyWithZone:(NSZone *)zone
{
    return [self copy];
}

-(nonnull GWPShortNews *)copy
{
    return [GWPShortNews createNews:self.newsID
                              title:self.title
                    publicationDate:self.publicationDate
                            details:self.details
                               link:self.link
                               giud:self.guid];
}

-(nonnull GWPShortNews *)tableCopy
{
    GWPShortNews *news = [self copy];
    news.link = nil;
    news.guid = nil;
    return news;
}


@end
