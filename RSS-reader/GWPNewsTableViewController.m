
#import "GWPNewsTableViewController.h"
#import "GWPNews.h"
#import "GWPNewsTableViewCell.h"
#import "GWPDBControllerDelegate.h"
#import "GWPDBControllerFactory.h"
#import "GWPNewsBodyViewController.h"

@interface GWPNewsTableViewController ()<GWPDBControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
@property (strong, readwrite) NSArray *newsStorage;
@property (weak, readwrite) id <GWPNewsListControllerProtocol> controller;
@property (strong, nonatomic) UIRefreshControl *refreshControle;

@end

@implementation GWPNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"NewsCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"NewsCell"];
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshClicked:) forControlEvents:UIControlEventValueChanged];

    
    self.controller = [GWPDBControllerFactory newsListController];
    [self.controller setDelegate:self];
    [self refreshClicked:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.controller.newsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GWPNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    
    GWPNews *news = self.controller.newsList[indexPath.row];
    cell.currentNews = news;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"NewsBodySegue" sender:cell];
}


- (void)showRefreshError{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"No connection!", nil)
                                                                    message:NSLocalizedString(@"Can not load RSS", nil)
                                                             preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", nil)
                                                          style:UIAlertActionStyleDestructive
                                                        handler:nil];
    [alert addAction:alertAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (IBAction)unwindForSegue:(UIStoryboardSegue *)unwindSegue {
    [self refreshClicked:self];
}

- (IBAction)refreshClicked:(id)sender
{
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                                                ^{
                                                    [self updateNews];
                                                });
}

-(void)updateNews
{
    [self.controller updateNews:self.currentRSS];
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"NewsBodySegue"])
    {
        GWPNewsBodyViewController *dectination = segue.destinationViewController;
        dectination.news = [(GWPNewsTableViewCell *)sender currentNews];
    }
}

#pragma mark - Custom methods

- (void)refreshNewsList{
    self.newsStorage = self.controller.newsList;
    [self.tableView reloadData];
}

#pragma mark - Delegate methods

-(void)dbControllerUpdateStarded:(id)controller
{

}

-(void)dbControllerUpdateCompleted:(id)controller
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self refreshNewsList];
        [self.refreshControl endRefreshing];
    });
    

}

-(void)dbControllerUpdateFailed:(id)controller
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showRefreshError];
        [self.refreshControl endRefreshing];
    });

}

@end
