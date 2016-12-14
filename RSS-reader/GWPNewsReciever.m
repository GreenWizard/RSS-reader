//
//  GWPNewsReciever.m
//  RSS-reader
//
//  Created by Student on 06/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPNewsReciever.h"

@implementation GWPNewsReciever

-(NSDictionary *)recieveNews
{
    @try
    {
        GWPRSSParser *parser = [[GWPRSSParser alloc]init];
        parser.urlToParse = self.url;
        NSDictionary *result = [parser parse];
        return result;
    }
    @catch(NSException *exception)
    {
        return nil;
    }
}

@end
