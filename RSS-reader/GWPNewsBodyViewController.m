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
@property (atomic, strong) GWPShortNews *news;

@end

@implementation GWPNewsBodyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id<GWPNewsReciever_NewsBody> reciever = [GWPRSSNewsReciever getReciever];
    self.news = reciever.currentNews;
    self.newsTitle.title = self.news.publicationDate;
    self.newsDetails.text = [NSString stringWithFormat:@"%@\n\n%@",self.news.title, self.news.details];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
