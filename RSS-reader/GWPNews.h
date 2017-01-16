//
//  ShortNews.h
//  RSS-reader
//
//  Created by User on 16/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWPNews : NSObject <NSCopying>

@property (copy, nullable, nonatomic) NSString *title;
@property (copy, nullable, nonatomic) NSDate *publicationDate;
@property (copy, nullable, nonatomic) NSString *details;
@property (copy, nonnull, nonatomic) NSURL *link;
@property (readwrite) BOOL isUnread;

+(nonnull GWPNews *)createNews:(nullable NSString *)title
                    publicationDate:(nullable NSDate *)pubDate
                            details:(nullable NSString *)details
                               link:(nonnull NSURL *)link;

-(nonnull GWPNews *)copy;

@end
