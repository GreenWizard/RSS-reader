//
//  GWPNewsRecieverController.h
//  RSS-reader
//
//  Created by Student on 10/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPContextController.h"
#import "GWPRSS.h"

@interface GWPNewsRecieverController : GWPContextController

@property (strong, nonatomic, readwrite) GWPRSS *rss;

-(void)updateRSS;

@end
