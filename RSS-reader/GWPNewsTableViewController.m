
#import "GWPNewsTableViewController.h"

@interface GWPNewsTableViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
@property (strong, readwrite) NSMutableArray *newsStorage;
@property (strong, readwrite) id <GWPNewsRecieverProtocol> newsReciever;
@property (readwrite) BOOL interfaceIsLocked;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation GWPNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"NewsCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"NewsCell"];
    
    self.newsReciever = [GWPRSSNewsReciever getReciever];
    [self.newsReciever setDelegate:self];
    [self refreshClicked:self];
    self.indicatorView.center = self.view.center;
    [self.view addSubview:self.indicatorView];
    
    
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
    return [self.newsStorage count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GWPNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    
    GWPShortNews *news = [self.newsStorage objectAtIndex:indexPath.row];
    cell.newsId = news.newsId;
    cell.newsTitle.text = news.title;
    cell.publicationDate.text = news.publicationDate;
    cell.newsDetails.text = news.details;
    
    return cell;
}

-(UIActivityIndicatorView *)indicatorView
{
    if(!_indicatorView)
        _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    return _indicatorView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!self.interfaceIsLocked)
    {
        id cell = [tableView cellForRowAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"NewsBodySegue" sender:cell];
    }
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
    
}

- (IBAction)refreshClicked:(id)sender {
    if(self.refreshButton.enabled)
    {
       self.refreshButton.enabled = NO;
       NSThread *tread = [[NSThread alloc]initWithTarget:self.newsReciever
                                                selector:@selector(update)
                                                  object:nil];
       [tread start];
    }
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GWPNewsTableViewCell *cell = (GWPNewsTableViewCell *)sender;
    if(cell.newsId != nil){
        UIViewController *viewController = segue.destinationViewController;
        GWPNewsBodyViewController *destination = (GWPNewsBodyViewController *)viewController;
        destination.newsId = cell.newsId;
    }
}

#pragma mark - Custom methods

- (void)refreshNewsList{
    self.newsStorage = self.newsReciever.newsList;
    [self.tableView reloadData];
}

#pragma mark - Delegate methods

-(void)updateStarded
{
    self.refreshButton.enabled = NO;
    dispatch_async(dispatch_get_main_queue(), ^{[self.indicatorView startAnimating];});
}

-(void) updateCompletedWithResult
{
    
    self.interfaceIsLocked = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self refreshNewsList];
        [self.indicatorView stopAnimating];    });
    self.refreshButton.enabled = YES;

}

-(void) updateCompletedWithError
{
    dispatch_async(dispatch_get_main_queue(), ^{[self.indicatorView stopAnimating];});
    self.refreshButton.enabled = YES;
    self.interfaceIsLocked = NO;
    [self showRefreshError];
}

-(void) inputClosed
{
    self.interfaceIsLocked = YES;
}

@end
