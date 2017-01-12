//
//  ShortNews.m
//  RSS-reader
//
//  Created by User on 16/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPNews.h"

@interface GWPNews()

@end

@implementation GWPNews

+(nonnull GWPNews *)createNews:(nullable NSString *)title
                    publicationDate:(nullable NSString *)pubDate
                            details:(nullable NSString *)details
                               link:(nonnull NSURL *)link
{
    GWPNews * news = [[GWPNews alloc] init];
    
    news.title = title;
    news.publicationDate = pubDate;
    news.details = details;
    news.link = link;
    news.isUnread = YES;
    
    return news;
}

-(id)copyWithZone:(NSZone *)zone
{
    return [self copy];
}

-(nonnull GWPNews *)copy
{
    GWPNews *result = [GWPNews createNews:self.title
                         publicationDate:self.publicationDate
                                 details:self.details
                                    link:self.link];
    result.isUnread = self.isUnread;
    return result;
}

@end
