//
//  GWPRSSListCell.h
//  RSS-reader
//
//  Created by Student on 29/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWPRSSListCell : UITableViewCell
@property (weak, nonatomic, readonly) IBOutlet UILabel *title;
@property (weak, nonatomic, readonly) IBOutlet UIButton *editButton;
@end
