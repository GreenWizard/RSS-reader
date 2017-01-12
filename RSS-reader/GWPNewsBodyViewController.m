//
//  NewsBodyViewController.m
//  RSS-reader
//
//  Created by User on 17/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPNewsBodyViewController.h"
#import "GWPDBControllerFactory.h"

@interface GWPNewsBodyViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *newsTitle;
@property (weak, nonatomic) IBOutlet UIWebView *newsDetails;

@end

@implementation GWPNewsBodyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.newsTitle.title = self.news.publicationDate;
    [self.newsDetails loadHTMLString:[NSString stringWithFormat:@"%@ \n\n %@",self.news.title , self.news.details]
                             baseURL:self.news.link];
    id<GWPNewsMarkerControllerProtocol> controller = [GWPDBControllerFactory newsMarkerController];
    [controller markNews:self.news];
    self.newsDetails.delegate = self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *cssString = @"img { max-width: 100%; } h1 { font-size: 150%; }";
    NSString *javascriptWithCSSString = [NSString stringWithFormat:@"var style = document.createElement('style'); \
                                         style.innerHTML = '%@'; \
                                         document.head.appendChild(style)", cssString];
    [webView stringByEvaluatingJavaScriptFromString:javascriptWithCSSString];
}
@end
