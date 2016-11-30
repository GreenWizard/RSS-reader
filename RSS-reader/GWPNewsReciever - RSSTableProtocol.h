//
//  GWPNewsReciever - RSSTableProtocol.h
//  RSS-reader
//
//  Created by Student on 30/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import<Foundation/Foundation.h>
//#import "GWPRSS.h"

@class GWPRSS;

@protocol GWPNewsReciever_RSSTable <NSObject>

@property (readwrite, atomic, strong) GWPRSS *currentRSS;
@property (readonly, atomic, strong) NSArray *rssList;

+(id)getReciever;
-(void)updateRSSList;

-(void)addNewRSS:(GWPRSS *)rss;
-(void)editRSS:(GWPRSS *)rss
        newRSS:(GWPRSS *)newRSS;
-(void)deleteRSS:(GWPRSS *)rss;


@end


