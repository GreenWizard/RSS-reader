//
//  GWPRSSData.m
//  RSS-reader
//
//  Created by Student on 27/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSData+Requests.h"
#import "GWPNewsData+CoreDataClass.h"

@implementation GWPRSSData(Requests)

-(NSInteger)countOfUnreadNews
{
    int result = 0;
    
    for( GWPNewsData *newsData in self.news)
        if(!newsData.wasRead)
            ++result;

    return result;
}

@end
