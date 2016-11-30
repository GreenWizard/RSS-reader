//
//  GWPNewsReciever - NewsTableProtocol.h
//  RSS-reader
//
//  Created by Student on 30/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import<Foundation/Foundation.h>
#import "GWPShortNews.h"
#import "GWPNewsRecieverDelegate.h"
#import "GWPRSS.h"


@protocol GWPNewsReciever_NewsTable <NSObject>

@property (readonly, atomic, strong) NSMutableArray *newsList;
@property (readwrite, atomic, weak) id<GWPNewsRecieverDelegate> delegate;
@property (readwrite, atomic, strong) NSNumber *currentNewsID;
@property (readwrite, atomic, strong) GWPRSS *currentRSS;

+(id)getReciever;

-(void)updateNews;
-(void)loadBaseData;

@end

