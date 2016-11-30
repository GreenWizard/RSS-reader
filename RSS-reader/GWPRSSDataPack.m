//
//  GWPRSSDataPack.m
//  RSS-reader
//
//  Created by Student on 30/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSDataPack.h"

@implementation GWPRSSDataPack

-(GWPRSSDataPack *)initWithTitle:(NSString *)title link:(NSURL *)link newsArray:(NSMutableArray *)array
{
    _title = [title copy];
    _link = [link copy];
    if(array)
        _news = array;
    else
        _news = [[NSMutableArray alloc] initWithCapacity:0];
    return self;
}

@end
