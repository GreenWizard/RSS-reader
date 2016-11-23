//
//  NewsRecieverProtocol.h
//  RSS-reader
//
//  Created by User on 17/11/16.
//  Copyright © 2016 User. All rights reserved.
//
#import<Foundation/Foundation.h>
#import "GWPShortNews.h"
#import "GWPNewsRecieverDelegate.h"
#ifndef GWPNewsRecieverProtocol_h
#define GWPNewsRecieverProtocol_h

@protocol GWPNewsRecieverProtocol <NSObject>

@property (readonly, nonatomic, strong, getter=newsList) NSMutableArray *newsList;
@property (readwrite, atomic, strong) NSNumber * numberOfNews;
@property (readwrite, atomic, weak, getter=delegate) id<GWPNewsRecieverDelegate> delegate;

+(id)getReciever;
+(void)killReciever;

-(void)update;
-(GWPShortNews *)newsById:(NSNumber *)newsId;



@end

#endif /* GWPNewsRecieverProtocol_h */
