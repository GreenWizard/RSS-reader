//
//  ShortNews.h
//  RSS-reader
//
//  Created by User on 16/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWPShortNews : NSObject

@property (atomic, strong, nullable) NSNumber *newsId;
@property (atomic, strong, nullable) NSString *title;
@property (atomic, strong, nullable) NSString *publicationDate;
@property (atomic, strong, nullable) NSString *details;
@property (atomic, strong, nullable) NSURL *link;

+(nonnull GWPShortNews *)createNews:(nonnull NSNumber *)newsId
                              title:(nullable NSString *)title
                    publicationDate:(nullable NSString *)pubDate
                            details:(nullable NSString *)details
                               link:(nullable NSURL *)link;

-(nonnull GWPShortNews *)copy;
-(nonnull GWPShortNews *)tableCopy;
-(nonnull GWPShortNews *)bodyViewCopy;

@end
