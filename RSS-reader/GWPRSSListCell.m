//
//  GWPRSSListCell.m
//  RSS-reader
//
//  Created by Student on 29/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSListCell.h"
#import "GWPRSSImageExtractor.h"

@interface GWPRSSListCell()

@property (weak, nonatomic, readwrite) IBOutlet UILabel *title;
@property (weak, nonatomic, readwrite) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UILabel *unreadMassages;
@property (weak, nonatomic) IBOutlet UIImageView *image;


@end

@implementation GWPRSSListCell

-(IBAction)editButtonClicked:(id)sender
{
    [self.delegate rssCell:self editButtonClicked:self.editButton];
}

-(void)setCurrentRSS:(GWPRSS *)currentRSS
{
    _currentRSS = currentRSS;
    self.title.text = currentRSS.title;
    NSNumber *unreadNews = [NSNumber numberWithInteger:currentRSS.unreadNews];
    GWPRSSImageExtractor *extractor = [GWPRSSImageExtractor initWithURL:self.currentRSS.link];
    UIImage *tmpImage = extractor.image;
    self.image.image = tmpImage;
    if(currentRSS.unreadNews)
        self.unreadMassages.text = [NSString stringWithFormat:@"%d", [unreadNews intValue]];
    else
        self.unreadMassages.text = @"0";
}

@end
