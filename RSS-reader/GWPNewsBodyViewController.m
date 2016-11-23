//
//  NewsBodyViewController.m
//  RSS-reader
//
//  Created by User on 17/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPNewsBodyViewController.h"

@interface GWPNewsBodyViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *newsTitle;
@property (weak, nonatomic) IBOutlet UITextView *newsDetails;
@property GWPShortNews *news;

@end

@implementation GWPNewsBodyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id<GWPNewsRecieverProtocol> reciever = [GWPRSSNewsReciever getReciever];
    self.news = [reciever newsById:self.newsId];
    self.newsTitle.title = self.news.title;
    //NSLog (@"%@",self.newsDetails.text);
    self.newsDetails.text = self.news.details;
    //NSLog (@"%@",self.newsDetails.text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
