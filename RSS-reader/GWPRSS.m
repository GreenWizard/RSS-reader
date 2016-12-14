//
//  GWPRSS.m
//  RSS-reader
//
//  Created by Student on 30/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSS.h"
@interface GWPRSS()

@property (readwrite) NSString *title;
@property (readwrite) NSURL *link;

@end

@implementation GWPRSS

+(GWPRSS *)createRSS:(NSString *)title
                link:(NSURL *)link
          unreadNews:(NSInteger )unreadNews
{
    GWPRSS *result = [[GWPRSS alloc] init];
    result.title = title;
    result.link = link;
    result.unreadNews = unreadNews;
    return result;
}

@end
