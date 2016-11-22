//
//  ShortNews.h
//  RSS-reader
//
//  Created by User on 16/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWPShortNews : NSObject

@property (atomic, strong) NSNumber *Id;
@property (atomic, strong) NSString *title;
@property (atomic, strong) NSString *publicationDate;
@property (atomic, strong) NSString *details;

@end
