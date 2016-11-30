//
//  NewsTableViewCell.h
//  RSS-reader
//
//  Created by User on 16/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWPNewsTableViewCell : UITableViewCell

@property (weak, nonatomic, readonly) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic, readonly) IBOutlet UILabel *publicationDate;
@property (weak, nonatomic, readonly) IBOutlet UILabel *newsDetails;

@end
