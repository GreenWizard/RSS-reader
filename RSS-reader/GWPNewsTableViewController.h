//
//  NewsTableViewController.h
//  RSS-reader
//
//  Created by User on 16/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWPShortNews.h"
#import "GWPNewsTableViewCell.h"
#import "GWPNewsReciever - NewsTableProtocol.h"
#import "GWPRSSNewsReciever.h"
#import "GWPNewsBodyViewController.h"

@interface GWPNewsTableViewController : UITableViewController<GWPNewsRecieverDelegate>

@end
