//
//  NewsBodyViewController.m
//  RSS-reader
//
//  Created by User on 17/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPNewsBodyViewController.h"
#import "GWPDBControllerFactory.h"

@interface GWPNewsBodyViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *newsTitle;
@property (weak, nonatomic) IBOutlet UITextView *newsDetails;

@end

@implementation GWPNewsBodyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.newsTitle.title = self.news.publicationDate;
    self.newsDetails.text = [NSString stringWithFormat:@"%@\n\n%@",self.news.title, self.news.details];
    id<GWPNewsMarkerControllerProtocol> controller = [GWPDBControllerFactory newsMarkerController];
    [controller markNews:self.news];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
