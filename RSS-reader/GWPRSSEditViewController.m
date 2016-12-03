//
//  GWPRSSEditViewController.m
//  RSS-reader
//
//  Created by Student on 03/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSEditViewController.h"
#import "GWPRSSNewsReciever.h"

@interface GWPRSSEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *rssTitle;
@property (weak, nonatomic) IBOutlet UITextField *rssLink;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end

@implementation GWPRSSEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rssTitle.text = self.rss.title;
    self.rssLink.text = [self.rss.link absoluteString];
    
    if(!self.rss)
    {
        self.deleteButton.enabled = NO;
        [self.deleteButton setHidden:YES];
    }
    
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    unsigned long notNil = (self.rssLink.text.length)*(self.rssTitle.text.length);
    if([segue.identifier isEqualToString:@"AddRSS_save"]&&(notNil))
    {
        id<GWPNewsReciever_RSSTable> reciever = [GWPRSSNewsReciever getReciever];
        GWPRSS *newRSS = [[GWPRSS alloc]init];
        newRSS.title = self.rssTitle.text;
        newRSS.link = [NSURL URLWithString:self.rssLink.text];

        if(self.rss)
            [reciever editRSS:self.rss newRSS:newRSS];
        else
            [reciever addNewRSS:newRSS];
    }
    
    if([segue.identifier isEqualToString:@"AddRSS_delete"])
    {
        id<GWPNewsReciever_RSSTable> reciever = [GWPRSSNewsReciever getReciever];
        [reciever deleteRSS:self.rss];
    }
}


@end
