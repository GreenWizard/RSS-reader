//
//  GWPRSSEditViewController.m
//  RSS-reader
//
//  Created by Student on 03/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSEditViewController.h"
#import "GWPDBControllerFabric.h"

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

    if([segue.identifier isEqualToString:@"AddRSS_save"]
       &&(self.rssLink.text.length > 0)
       && (self.rssTitle.text.length > 0))
    {
        id<GWPDBControllerForRSSEditView> reciever = [GWPDBControllerFabric getDBControllerForRSSEditView];
        GWPRSS *newRSS = [GWPRSS createRSS:self.rssTitle.text
                                      link:[NSURL URLWithString:self.rssLink.text]
                                unreadNews:0];

        if(self.rss)
            [reciever editRSS:self.rss newRSS:newRSS];
        else
            [reciever addNewRSS:newRSS];
    }
    
    if([segue.identifier isEqualToString:@"AddRSS_delete"])
    {
        id<GWPDBControllerForRSSEditView> reciever = [GWPDBControllerFabric getDBControllerForRSSEditView];
        [reciever deleteRSS:self.rss];
    }
}


@end
