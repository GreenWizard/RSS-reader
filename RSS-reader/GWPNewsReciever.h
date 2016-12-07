//
//  GWPNewsReciever.h
//  RSS-reader
//
//  Created by Student on 06/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWPNewsRecieverDelegate.h"
#import "GWPRSSParser.h"

@interface GWPNewsReciever : NSObject

@property (weak, nonatomic, readwrite) id <GWPNewsRecieverDelegate> delegate;
@property (strong, nonatomic, readwrite) NSURL *url;

-(NSDictionary *)recieveNewsList;

@end
