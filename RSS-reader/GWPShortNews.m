//
//  ShortNews.m
//  RSS-reader
//
//  Created by User on 16/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPShortNews.h"

@implementation GWPShortNews

+(nonnull GWPShortNews *)createNews:(nonnull NSNumber *)newsId
                              title:(nullable NSString *)title
                    publicationDate:(nullable NSString *)pubDate
                            details:(nullable NSString *)details
                               link:(nullable NSURL *)link
{
    GWPShortNews * news = [[GWPShortNews alloc] init];
    
    news.newsId = [newsId copy];
    news.title = [title copy];
    news.publicationDate = [pubDate copy];
    news.details = [details copy];
    news.link = [link copy];
    
    return news;
}

-(nonnull GWPShortNews *)copy
{
    return [GWPShortNews createNews:self.newsId
                              title:self.title
                    publicationDate:self.publicationDate
                            details:self.details
                               link:self.link];
}

-(nonnull GWPShortNews *)tableCopy
{
    GWPShortNews *news = [self copy];
    if([news.details length] > 30)
        news.details = [news.details substringWithRange:NSMakeRange(0, 29)];
    news.link = nil;
    return news;
}

-(nonnull GWPShortNews *)bodyViewCopy
{
    GWPShortNews *news = [self copy];
    news.newsId = nil;
    return news;
}

@end
