//
//  GWPRSSTableViewController.m
//  RSS-reader
//
//  Created by Student on 29/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSTableViewController.h"
#import "GWPRSSEditViewController.h"
#import "GWPRSSCell_ButtonAction.h"

@interface GWPRSSTableViewController ()<GWPRSSCell_ButtonAction>

@property (strong, nonatomic, readwrite) NSArray *rssList;
@property (weak, readwrite) id<GWPNewsReciever_RSSTable> reciever;

@end

@implementation GWPRSSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"GWPRSSNewsCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"RSSListCell"];
    self.reciever = [GWPRSSNewsReciever getReciever];
    
    [self.reciever loadBaseData];
    self.rssList = [self.reciever rssList];
    
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
    cell.currentRSS = rss;
    cell.delegate = self;
    
    return cell;
}

-(void)rssCell:(GWPRSSListCell *)cell editButtonClicked:(UIButton *)button
{
    [self performSegueWithIdentifier:@"RSSList_edit" sender:cell];
}


-(IBAction)unwindForSegue:(UIStoryboardSegue *)unwindSegue
{
    self.rssList = self.reciever.rssList;
    [self.tableView reloadData];
}

 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.reciever.currentRSS = [self.rssList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"NewsListSegue" sender:self];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"RSSList_edit"])
    {
        GWPRSSEditViewController *destination = segue.destinationViewController;
        destination.rss = [(GWPRSSListCell *)sender currentRSS];
    }
}


@end
