//
//  GWPRSSNewsReciever.h
//  RSS-reader
//
//  Created by Student on 22/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWPNewsReciever_RSSTable.h"
#import "GWPNewsReciever_NewsTable.h"
#import "GWPRSSParserDelegate.h"
#import "GWPRSSDataPack.h"

@interface GWPRSSNewsReciever : NSObject<GWPNewsReciever_NewsTable,GWPNewsReciever_RSSTable>

@end
