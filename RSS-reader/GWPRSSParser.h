//
//  RSSParserDelgate.h
//  RSS-reader
//
//  Created by Student on 22/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWPNews.h"

@interface GWPRSSParser : NSObject 

@property (strong, readwrite, atomic) NSURL *urlToParse;
-(NSDictionary *)parse;
@end
