//
//  ShortNews.h
//  RSS-reader
//
//  Created by User on 16/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWPShortNews : NSObject <NSCopying>

@property (copy, nullable, nonatomic) NSString *title;
@property (copy, nullable, nonatomic) NSString *publicationDate;
@property (copy, nullable, nonatomic) NSString *details;
@property (copy, nullable, nonatomic) NSURL *link;
@property (copy, nullable, nonatomic) NSURL *guid;

+(nonnull GWPShortNews *)createNews:(nullable NSString *)title
                    publicationDate:(nullable NSString *)pubDate
                            details:(nullable NSString *)details
                               link:(nullable NSURL *)link
                               giud:(nonnull NSURL *)guid;

-(nonnull GWPShortNews *)copy;
-(nonnull GWPShortNews *)tableCopy;

@end
