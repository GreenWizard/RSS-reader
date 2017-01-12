//
//  GWPRSS.h
//  RSS-reader
//
//  Created by Student on 30/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWPRSSData+CoreDataClass.h"



@interface GWPRSS : NSObject

@property (copy, nonatomic, readonly) NSString *title;
@property (copy, nonatomic, readonly) NSURL *link;
@property (nonatomic, readwrite) NSInteger unreadNews;

+(GWPRSS *)createRSS:(NSString *)title
                link:(NSURL *)link
          unreadNews:(NSInteger )unreadNews;

@end
