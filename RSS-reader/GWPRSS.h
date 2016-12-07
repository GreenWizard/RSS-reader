//
//  GWPRSS.h
//  RSS-reader
//
//  Created by Student on 30/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GWPRSS : NSObject

@property (strong, nonatomic, readwrite) NSString *title;
@property (strong, nonatomic, readwrite) NSURL *link;
@property (strong, nonatomic, readwrite) NSNumber *unreadMassages;

@end
