//
//  NewsBodyViewController.h
//  RSS-reader
//
//  Created by User on 17/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWPShortNews.h"
#import "GWPNewsRecieverProtocol.h"
#import "GWPDeterminateNewsReciever.h"
#import "GWPRSSNewsReciever.h"

@interface GWPNewsBodyViewController : UIViewController

@property NSNumber *newsId;

@end
