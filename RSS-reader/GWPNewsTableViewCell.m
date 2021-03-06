//
//  NewsTableViewCell.m
//  RSS-reader
//
//  Created by User on 16/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPNewsTableViewCell.h"

@interface GWPNewsTableViewCell()

@property (weak, nonatomic, readwrite) IBOutlet UILabel *unreadIndicator;
@property (weak, nonatomic, readwrite) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic, readwrite) IBOutlet UILabel *publicationDate;
@end

@implementation GWPNewsTableViewCell

-(void)setCurrentNews:(GWPNews *)currentNews
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd.MMM.yyyy HH:mm"];
    
    self.newsTitle.text = currentNews.title;
    self.publicationDate.text = [format stringFromDate:currentNews.publicationDate];
    self.unreadIndicator.hidden = !currentNews.isUnread;
    _currentNews = currentNews;
}




@end
