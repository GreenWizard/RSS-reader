//
//  GWPRSSTableViewController.m
//  RSS-reader
//
//  Created by Student on 29/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSTableViewController.h"
#import "GWPNewsTableViewController.h"
#import "GWPRSSEditViewController.h"
#import "GWPRSSCell_ButtonAction.h"
#import "GWPRSS.h"
#import "GWPRSSListCell.h"
#import "GWPDBControllerFactory.h"

@interface GWPRSSTableViewController ()<GWPRSSCell_ButtonAction, GWPDBControllerDelegate>

@property (strong, nonatomic, readwrite) NSArray *rssList;
@property (weak, readwrite) id<GWPDBContollerForRSSTable> controller;

@end

@implementation GWPRSSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"GWPRSSNewsCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"RSSListCell"];
    self.controller = [GWPDBControllerFactory rssTableDBController];
    
    self.controller.delegate = self;
    [self.controller updateRSSList];
    
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

-(void)dbControllerUpdateStarded:(id)controller
{
    return;
}

-(void)dbControllerUpdateFailed:(id)controller
{
    return;
}

-(void)dbControllerUpdateCompleted:(id)controller
{
    self.rssList = self.controller.rssList;
    [self.tableView reloadData];
}


-(IBAction)unwindForSegue:(UIStoryboardSegue *)unwindSegue
{
    [self.controller updateRSSList];
}

 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id sender = [tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"NewsListSegue" sender:sender];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"RSSList_edit"])
    {
        GWPRSSEditViewController *destination = segue.destinationViewController;
        destination.rss = [(GWPRSSListCell *)sender currentRSS];
    }
    if([segue.identifier isEqualToString:@"NewsListSegue"])
    {
        GWPNewsTableViewController *destination = segue.destinationViewController;
        destination.currentRSS = [(GWPRSSListCell *)sender currentRSS];
    }
}


@end
