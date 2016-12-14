//
//  GWPDBLoader.h
//  RSS-reader
//
//  Created by Student on 06/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWPContextController.h"
#import "GWPContextControllerParent.h"

@interface GWPDBController : NSObject

@property (strong, nonatomic) GWPContextController *newsTableCC;
@property (strong, nonatomic) GWPContextController *rssTableCC;
@property (strong, nonatomic) GWPContextController *newsBodyCC;
@property (strong, nonatomic) GWPContextController *rssEditViewCC;

+(id)getInstance;

@end
