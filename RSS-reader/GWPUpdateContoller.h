//
//  GWPUpdateContoller.h
//  RSS-reader
//
//  Created by Student on 10/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWPDBController.h"

@interface GWPUpdateContoller : NSObject

@property (readwrite) NSInteger *updateTime;
@property (readwrite) NSInteger *updateBlock;
@property (weak, readonly) GWPDBController* dbController;

@end
