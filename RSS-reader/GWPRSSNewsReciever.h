//
//  GWPRSSNewsReciever.h
//  RSS-reader
//
//  Created by Student on 22/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWPNewsRecieverProtocol.h"
#import "GWPNewsReciever - NewsTableProtocol.h"
#import "GWPRSSParserDelegate.h"
#import "GWPRSSDataPack.h"

@interface GWPRSSNewsReciever : NSObject<GWPNewsReciever_NewsTable,GWPNewsReciever_NewsBody,GWPNewsReciever_RSSTable>

@end
