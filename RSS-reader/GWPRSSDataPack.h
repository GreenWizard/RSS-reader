//
//  GWPRSSDataPack.h
//  RSS-reader
//
//  Created by Student on 30/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWPRSSDataPack : NSObject

@property (strong, readonly, atomic) NSString *title;
@property (strong, readonly, atomic) NSURL *link;
@property (strong, readwrite, atomic) NSMutableArray *news;
@property (strong, readwrite, atomic) NSMutableArray *unreadNews;
@property (strong, readwrite, atomic) NSURL *lastGUID;

-(GWPRSSDataPack *)initWithTitle:(NSString *)title
                            link:(NSURL *)link
                       newsArray:(NSMutableArray *)array;

@end
