//
//  GWPRSSTableViewController.m
//  RSS-reader
//
//  Created by Student on 29/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSTableViewController.h"

@interface GWPRSSTableViewController ()

@property (strong, nonatomic, readwrite) NSMutableArray *rssList;
@property (weak, readwrite) id<GWPNewsReciever_RSSTable> reciever;

@end

@implementation GWPRSSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"GWPRSSNewsCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"RSSListCell"];
    self.reciever = [GWPRSSNewsReciever getReciever];
    
    self.rssList = [[self.reciever rssList] mutableCopy];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.rssList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GWPRSSListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RSSListCell" forIndexPath:indexPath];
    
    GWPRSS *rss = [self.rssList objectAtIndex:indexPath.row];
    cell.title.text = rss.title;
    
    return cell;
}





#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
