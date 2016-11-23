
#import "GWPNewsTableViewController.h"

@interface GWPNewsTableViewController ()

@property NSMutableArray *newsStorage;
@property id <GWPNewsRecieverProtocol> newsReciever;

@end

@implementation GWPNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *cellNib = [UINib nibWithNibName:@"NewsCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"NewsCell"];
    
    self.newsReciever = [GWPRSSNewsReciever getReciever];
    self.newsReciever.numberOfNews = @20;
    [self.newsReciever update];
    self.newsStorage = self.newsReciever.newsList;
  
    
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
    id cell = [tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"NewsBodySegue" sender:cell];
}


- (IBAction)unwindForSegue:(UIStoryboardSegue *)unwindSegue {
    
}

- (IBAction)refreshClicked:(id)sender {
    [self.newsReciever setNumberOfNews:@10];
    [self.newsReciever update];
    self.newsStorage = self.newsReciever.newsList;
    [self.tableView reloadData];
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


@end
