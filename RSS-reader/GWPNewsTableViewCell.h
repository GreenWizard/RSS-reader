//
//  NewsTableViewCell.h
//  RSS-reader
//
//  Created by User on 16/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWPShortNews.h"

@interface GWPNewsTableViewCell : UITableViewCell

@property (strong, nonatomic, readwrite) GWPShortNews *currentNews;

@end
