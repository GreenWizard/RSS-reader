//
//  GWPRSSListCell.m
//  RSS-reader
//
//  Created by Student on 29/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSListCell.h"

@interface GWPRSSListCell()

@property (weak, nonatomic, readwrite) IBOutlet UILabel *title;
@property (weak, nonatomic, readwrite) IBOutlet UIButton *editButton;


@end

@implementation GWPRSSListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCurrentRSS:(GWPRSS *)currentRSS
{
    self.title.text = currentRSS.title;
    _currentRSS = currentRSS;
}

-(IBAction)editButtonClicked:(id)sender
{
    [self.tableView rssCell:self editButtonClicked:self.editButton];
}


@end
