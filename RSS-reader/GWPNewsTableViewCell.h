//
//  NewsTableViewCell.h
//  RSS-reader
//
//  Created by User on 16/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWPNewsTableViewCell : UITableViewCell

@property NSNumber *newsId;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *publicationDate;
@property (weak, nonatomic) IBOutlet UILabel *newsDetails;

@end
