//
//  PFUpdateViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/16/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFUpdateViewController.h"

@interface PFUpdateViewController ()

@end

@implementation PFUpdateViewController

BOOL loadNews;
BOOL noDataNews;
BOOL refreshDataNews;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.Demoapi checkLogin] != false){
        
        [self.view addSubview:self.pagecontrollerView];
        [self.delegate HideTabbar];
        
    }else{
    
        [self.view addSubview:self.waitView];
        
        CALayer *popup = [self.popupwaitView layer];
        [popup setMasksToBounds:YES];
        [popup setCornerRadius:7.0f];
        
        // Navbar setup
        [[self.navController navigationBar] setBarTintColor:[UIColor colorWithRed:247.0f/255.0f green:148.0f/255.0f blue:30.0f/255.0f alpha:1.0f]];
        
        [[self.navController navigationBar] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName, nil]];
        
        [[self.navController navigationBar] setTranslucent:YES];
        [self.view addSubview:self.navController.view];
        
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Setting_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(account)];
        
        //notification if (noti = 0) else
        //UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Notification_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(notify)];
        
        UIButton *toggleKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        toggleKeyboardButton.bounds = CGRectMake( 0, 0, 21, 21 );
        [toggleKeyboardButton setTitle:@"10" forState:UIControlStateNormal];
        [toggleKeyboardButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
        [toggleKeyboardButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        toggleKeyboardButton.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        [toggleKeyboardButton setBackgroundColor:[UIColor clearColor]];
        [toggleKeyboardButton.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        [toggleKeyboardButton.layer setBorderWidth: 1.0];
        [toggleKeyboardButton.layer setCornerRadius:10.0f];
        [toggleKeyboardButton addTarget:self action:@selector(notify) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:toggleKeyboardButton];
        
        self.navItem.leftBarButtonItem = leftButton;
        self.navItem.rightBarButtonItem = rightButton;
        
        UIView *fv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
        self.tableView.tableFooterView = fv;
        
        loadNews = NO;
        noDataNews = NO;
        refreshDataNews = NO;
        
        self.Demoapi = [[DCManager alloc] init];
        self.Demoapi.delegate = self;
        
        self.arrObj = [[NSMutableArray alloc] init];
        [self.Demoapi getNewsByAppKey:@"5" next:@"NO" app_key:@""];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)account {
    
    if ([self.Demoapi checkLogin] == false){
        
        self.loginView = [PFLoginViewController alloc];
        self.loginView.menu = @"account";
        self.loginView.delegate = self;
        [self.view addSubview:self.loginView.view];
        
    }else{

        [self.delegate HideTabbar];
    
        PFAccountViewController *account = [[PFAccountViewController alloc] init];
    
        if(IS_WIDESCREEN) {
            account = [[PFAccountViewController alloc] initWithNibName:@"PFAccountViewController_Wide" bundle:nil];
        } else {
            account = [[PFAccountViewController alloc] initWithNibName:@"PFAccountViewController" bundle:nil];
        }
    
        account.delegate = self;
        [self.navController pushViewController:account animated:YES];
    }
    
}

- (void)notify {
    [[[UIAlertView alloc] initWithTitle:@"DemoCoffee"
                                message:@"Notification coming soon."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (void)PFAccountViewController:(id)sender{
    
    [self.delegate HideTabbar];
    
    PFAccountViewController *account = [[PFAccountViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        account = [[PFAccountViewController alloc] initWithNibName:@"PFAccountViewController_Wide" bundle:nil];
    } else {
        account = [[PFAccountViewController alloc] initWithNibName:@"PFAccountViewController" bundle:nil];
    }
    
    account.delegate = self;
    [self.navController pushViewController:account animated:YES];
    
}

- (void)DCManager:(id)sender getNewsByAppKeyResponse:(NSDictionary *)response {
    self.obj = response;
    NSLog(@"Update %@",response);
    
    [self.waitView removeFromSuperview];
    
    if (!refreshDataNews) {
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObj addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    } else {
        [self.arrObj removeAllObjects];
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObj addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    }
    
    if ( [[response objectForKey:@"paginate"] objectForKey:@"next"] == nil ) {
        noDataNews = YES;
    } else {
        noDataNews = NO;
        self.paging = [[response objectForKey:@"paginate"] objectForKey:@"next"];
    }
    
    [self reloadData:YES];
    
}

- (void)DCManager:(id)sender getNewsByAppKeyErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void)reloadData:(BOOL)animated
{
    [self.tableView reloadData];
    if (!noDataNews){
        self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width,self.tableView.contentSize.height);
    } else {
        self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width,self.tableView.contentSize.height);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrObj count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFUpdateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFUpdateCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFUpdateCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleNews.text = [[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.detailNews.text = [[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"content"];
    
    cell.thumbnails.layer.masksToBounds = YES;
    cell.thumbnails.contentMode = UIViewContentModeScaleAspectFill;
    
    NSString *thumbid = [[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"thumb_id"];
    NSString *urlimg = [[NSString alloc] initWithFormat:@"%@%@%@",@"http://coffee-api.pla2app.com/picture/",thumbid,@"?width=800&height=600"];
    cell.thumbnails.imageURL = [[NSURL alloc] initWithString:urlimg];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.detailNewsView.layer setCornerRadius:5.0f];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.delegate HideTabbar];
    
    PFUpdateDetailViewController *mmdetail = [[PFUpdateDetailViewController alloc] init];
    
    if(IS_WIDESCREEN){
        mmdetail = [[PFUpdateDetailViewController alloc] initWithNibName:@"PFUpdateDetailViewController_Wide" bundle:nil];
    } else {
        mmdetail = [[PFUpdateDetailViewController alloc] initWithNibName:@"PFUpdateDetailViewController" bundle:nil];
    }
    
    mmdetail.obj = [self.arrObj objectAtIndex:indexPath.row];
    mmdetail.delegate = self;
    [self.navController pushViewController:mmdetail animated:YES];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	//NSLog(@"%f",scrollView.contentOffset.y);
	//[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ( scrollView.contentOffset.y < 0.0f ) {
        //NSLog(@"refreshData < 0.0f");
        [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        self.loadLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [dateFormatter stringFromDate:[NSDate date]]];
        self.act.alpha =1;
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    //NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < -60.0f ) {
        refreshDataNews = YES;

        self.Demoapi = [[DCManager alloc] init];
        self.Demoapi.delegate = self;
        
        [self.Demoapi getNewsByAppKey:@"5" next:@"NO" app_key:@""];
        
        if ([[self.obj objectForKey:@"total"] intValue] == 0) {
            self.loadLabel.text = @"";
            self.act.alpha = 0;
        }
    } else {
        self.loadLabel.text = @"";
        self.act.alpha = 0;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if ( scrollView.contentOffset.y < -100.0f ) {
        [UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
        self.tableView.frame = CGRectMake(0, 60, 320, self.tableView.frame.size.height);
		[UIView commitAnimations];
        [self performSelector:@selector(resizeTable) withObject:nil afterDelay:2];
        
        if ([[self.obj objectForKey:@"total"] intValue] == 0) {
            self.loadLabel.text = @"";
            self.act.alpha = 0;
        }
    } else {
        self.loadLabel.text = @"";
        self.act.alpha = 0;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float offset = (scrollView.contentOffset.y - (scrollView.contentSize.height - scrollView.frame.size.height));
    if (offset >= 0 && offset <= 5) {
        if (!noDataNews) {
            refreshDataNews = NO;
            
            self.Demoapi = [[DCManager alloc] init];
            self.Demoapi.delegate = self;
            
            [self.Demoapi getNewsByAppKey:@"5" next:self.paging app_key:@""];
        }
    }
}

- (void)resizeTable {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.tableView.frame = CGRectMake(0, 0, 320, self.tableView.frame.size.height);
    [UIView commitAnimations];
}

- (void)PFUpdateDetailViewController:(id)sender viewPicture:(NSString *)link{
    [self.delegate PFImageViewController:self viewPicture:link];
}

- (void)PFAccountViewController:(id)sender viewPicture:(NSString *)link{
    [self.delegate PFImageViewController:self viewPicture:link];
}

- (void)PFUpdateDetailViewControllerBack {
    [self.delegate ShowTabbar];
}

- (void)PFNotificationViewControllerBack {
    [self.delegate ShowTabbar];
}

- (void)PFAccountViewControllerBack {
    [self.delegate ShowTabbar];
}

@end
