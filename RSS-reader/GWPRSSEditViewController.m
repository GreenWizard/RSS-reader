//
//  GWPRSSEditViewController.m
//  RSS-reader
//
//  Created by Student on 03/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSEditViewController.h"
#import "GWPDBControllerFactory.h"

@interface GWPRSSEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *rssTitle;
@property (weak, nonatomic) IBOutlet UITextField *rssLink;

@end

@implementation GWPRSSEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rssTitle.text = self.rss.title;
    self.rssLink.text = [self.rss.link absoluteString];
    
    if(self.rss)
        self.navigationItem.title = self.rss.title;
    else
        self.navigationItem.title = @"Add new RSS";
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([segue.identifier isEqualToString:@"AddRSS_save"]
       &&(self.rssLink.text.length > 0)
       && (self.rssTitle.text.length > 0))
    {
        id<GWPEditControllerProtocol> controller = [GWPDBControllerFactory editController];
        GWPRSS *newRSS = [GWPRSS createRSS:self.rssTitle.text
                                      link:[NSURL URLWithString:self.rssLink.text]
                                unreadNews:0];

        if(self.rss)
            [controller editRSS:self.rss newRSS:newRSS];
        else
            [controller addNewRSS:newRSS];
    }
}


@end
