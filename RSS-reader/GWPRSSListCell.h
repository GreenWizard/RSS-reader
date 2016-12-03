//
//  GWPRSSListCell.h
//  RSS-reader
//
//  Created by Student on 29/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWPRSS.h"
#import "GWPRSSCell_ButtonAction.h"

@interface GWPRSSListCell : UITableViewCell

@property (strong, nonatomic, readwrite) GWPRSS *currentRSS;
@property (weak, nonatomic, readwrite) id<GWPRSSCell_ButtonAction> tableView;

@end
