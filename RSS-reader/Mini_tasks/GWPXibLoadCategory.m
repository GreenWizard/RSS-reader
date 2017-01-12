//
//  GWPXibLoadCategory.m
//  RSS-reader
//
//  Created by Student on 25/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPXibLoadCategory.h"
#import <UIKit/UIKit.h>

@implementation NSNumber(GWPXibLoader)

-(id)load:(Class)type fromXib:(NSString *)name
{
    @try
    {
        NSArray *xibObjects = [[NSBundle mainBundle] loadNibNamed:name
                                                            owner:self
                                                          options:nil];
        if (!xibObjects) return nil;
        
        for (id object in xibObjects)
        {
            if ([object isKindOfClass:type])
                return object;
        }
    }
    @catch (NSException *exception) {}
    return nil;
}

@end
