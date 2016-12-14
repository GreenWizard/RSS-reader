//
//  GWPNewsReciever.h
//  RSS-reader
//
//  Created by Student on 06/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWPRSSParser.h"

@interface GWPNewsReciever : NSObject

@property (strong, nonatomic, readwrite) NSURL *url;

-(NSDictionary *)recieveNews;

@end
