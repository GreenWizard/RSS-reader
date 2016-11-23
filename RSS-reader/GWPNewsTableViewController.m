
#import "GWPNewsTableViewController.h"

@interface GWPNewsTableViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
@property (strong, readwrite) NSMutableArray *newsStorage;
@property (strong, readwrite) id <GWPNewsRecieverProtocol> newsReciever;
@property (readwrite) BOOL interfaceIsLocked;

@end

@implementation GWPNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"NewsCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"NewsCell"];
    
    self.newsReciever = [GWPRSSNewsReciever getReciever];
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
    return [self.newsStorage count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GWPNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    
    GWPShortNews *news = [self.newsStorage objectAtIndex:indexPath.row];
    cell.Id = news.Id;
    cell.newsTitle.text = news.title;
    cell.publicationDate.text = news.publicationDate;
    cell.newsDetails.text = news.details;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!self.interfaceIsLocked)
    {
        id cell = [tableView cellForRowAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"NewsBodySegue" sender:cell];
    }
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
    if(cell.Id != nil){
        UIViewController *viewController = segue.destinationViewController;
        GWPNewsBodyViewController *destination = (GWPNewsBodyViewController *)viewController;
        destination.newsId = cell.Id;
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
}

-(void) updateCompletedWithResult
{
    self.interfaceIsLocked = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self refreshNewsList];
    });
    self.refreshButton.enabled = YES;

}

-(void) updateCompletedWithError:(NSString *)error
{
    self.refreshButton.enabled = YES;
    self.interfaceIsLocked = NO;
    NSLog(@"%@", error);
}

-(void) inputClosed
{
    self.interfaceIsLocked = YES;
}

@end
