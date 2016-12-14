
#import "GWPNewsTableViewController.h"
#import "GWPNews.h"
#import "GWPNewsTableViewCell.h"
#import "GWPDBControllerDelegate.h"
#import "GWPDBControllerFabric.h"
#import "GWPNewsBodyViewController.h"

@interface GWPNewsTableViewController ()<GWPDBControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
@property (strong, readwrite) NSArray *newsStorage;
@property (weak, readwrite) id <GWPDBContollerForNewsTable> newsReciever;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property (strong, nonatomic) UIBarButtonItem *refreshButtonStorage;


@end

@implementation GWPNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"NewsCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"NewsCell"];
    
    self.newsReciever = [GWPDBControllerFabric getDBControllerForNewsTable];
    [self.newsReciever setDelegate:self];
    [self refreshClicked:self];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.newsReciever.newsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GWPNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    
    GWPNews *news = [self.newsReciever.newsList objectAtIndex:indexPath.row];
    cell.currentNews = news;
    
    return cell;
}

-(UIActivityIndicatorView *)indicatorView
{
    if(!_indicatorView)
        _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    return _indicatorView;
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

- (IBAction)refreshClicked:(id)sender {
    
    if(self.refreshButton.enabled)
    {
        self.refreshButton.enabled = NO;
        self.navigationItem.title = self.currentRSS.title;
        NSThread *tread = [[NSThread alloc]initWithTarget:self
                                                 selector:@selector(updateNews)
                                                  object:nil];
        [tread start];
    }
}

-(void)updateNews
{
    [self.newsReciever updateNews:self.currentRSS];
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
    self.newsStorage = self.newsReciever.newsList;
    [self.tableView reloadData];
}

#pragma mark - Delegate methods

-(void)dbControllerUpdateStarded:(id)controller
{
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.indicatorView startAnimating];
        self.refreshButton.enabled = NO;
        self.refreshButtonStorage = self.refreshButton;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                  initWithCustomView:self.indicatorView];
    });
}

-(void)dbControllerUpdateCompleted:(id)controller
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self refreshNewsList];
        [self.indicatorView stopAnimating];
        self.refreshButton.enabled = YES;
        self.navigationItem.rightBarButtonItem = self.refreshButton;
    });
    

}

-(void)dbControllerUpdateFailed:(id)controller
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.indicatorView stopAnimating];
        self.refreshButton.enabled = YES;
        self.navigationItem.rightBarButtonItem = self.refreshButtonStorage;
        [self showRefreshError];
    });

}

@end
