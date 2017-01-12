//
//  NewsTableViewController.h
//  RSS-reader
//
//  Created by User on 16/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWPRSS.h"


@interface GWPNewsTableViewController : UITableViewController

@property (strong, nonatomic, readwrite) GWPRSS *currentRSS;

@end
