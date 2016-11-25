//
//  ShortNews.h
//  RSS-reader
//
//  Created by User on 16/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWPShortNews : NSObject

@property (strong, nullable) NSNumber *newsId;
@property (strong, nullable) NSString *title;
@property (strong, nullable) NSString *publicationDate;
@property (strong, nullable) NSString *details;
@property (strong, nullable) NSURL *link;

+(nonnull GWPShortNews *)createNews:(nonnull NSNumber *)newsId
                              title:(nullable NSString *)title
                    publicationDate:(nullable NSString *)pubDate
                            details:(nullable NSString *)details
                               link:(nullable NSURL *)link;

-(nonnull GWPShortNews *)copy;
-(nonnull GWPShortNews *)tableCopy;
-(nonnull GWPShortNews *)bodyViewCopy;

@end
