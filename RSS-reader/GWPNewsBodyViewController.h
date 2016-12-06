//
//  NewsBodyViewController.h
//  RSS-reader
//
//  Created by User on 17/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWPShortNews.h"
#import "GWPRSSNewsReciever.h"

@interface GWPNewsBodyViewController : UIViewController

@property (strong, nonatomic) GWPShortNews *news;

@end
