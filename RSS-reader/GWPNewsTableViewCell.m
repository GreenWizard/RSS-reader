//
//  NewsTableViewCell.m
//  RSS-reader
//
//  Created by User on 16/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPNewsTableViewCell.h"

@interface GWPNewsTableViewCell()

@property (weak, nonatomic, readwrite) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic, readwrite) IBOutlet UILabel *publicationDate;
@property (weak, nonatomic, readwrite) IBOutlet UILabel *newsDetails;


@end

@implementation GWPNewsTableViewCell

-(void)setCurrentNews:(GWPNews *)currentNews
{
    self.newsTitle.text = currentNews.title;
    self.publicationDate.text = currentNews.publicationDate;
    self.newsDetails.text = currentNews.details;
    _currentNews = currentNews;
}

@end
