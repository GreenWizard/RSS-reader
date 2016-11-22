//
//  DeterminateNewsReciever.h
//  RSS-reader
//
//  Created by User on 17/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWPNewsRecieverProtocol.h"
#import "GWPShortNews.h"

@interface GWPDeterminateNewsReciever : NSObject <GWPNewsRecieverProtocol>

@property (readwrite, atomic, strong) NSNumber *numberOfNews;
@property (readonly, nonatomic, strong, getter=newsList) NSMutableArray *newsList;

@end
