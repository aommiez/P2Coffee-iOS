//
//  PFMemberViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/16/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFMemberViewController.h"

@interface PFMemberViewController ()

@end

@implementation PFMemberViewController

BOOL refreshDataMember;

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
    
    // Navbar setup
    [[self.navController navigationBar] setBarTintColor:[UIColor colorWithRed:247.0f/255.0f green:148.0f/255.0f blue:30.0f/255.0f alpha:1.0f]];
    
    [[self.navController navigationBar] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                 [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName, nil]];
    
    [[self.navController navigationBar] setTranslucent:YES];
    [self.view addSubview:self.navController.view];
    
    //no login
    //self.tableView.tableHeaderView = self.nomemberView;
    //login
    self.tableView.tableHeaderView = self.memberView;
    
    UIView *fv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 52)];
    self.tableView.tableFooterView = fv;
    
    CALayer *postermember = [self.postermember layer];
    [postermember setMasksToBounds:YES];
    [postermember setCornerRadius:7.0f];
    
    CALayer *posternomember = [self.posternomember layer];
    [posternomember setMasksToBounds:YES];
    [posternomember setCornerRadius:7.0f];
    
    CALayer *addButton = [self.addButton layer];
    [addButton setMasksToBounds:YES];
    [addButton setCornerRadius:7.0f];
    
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    
    self.obj = [[NSDictionary alloc] init];
    self.arrObj = [[NSMutableArray alloc] init];
    
    [self.Demoapi getStampStyle];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)DCManager:(id)sender getStampStyleResponse:(NSDictionary *)response {
    NSLog(@"Member nomemberview %@",response);
    
    //login
    
    [DLImageLoader loadImageFromURL:[response objectForKey:@"poster"]
                          completed:^(NSError *error, NSData *imgData) {
                              self.postermember.image = [UIImage imageWithData:imgData];
                          }];
    
    NSString *urlbg = [NSString stringWithFormat:@"%@%@",[response objectForKey:@"background"],@"?blur=30"];
    
    [DLImageLoader loadImageFromURL:urlbg
                          completed:^(NSError *error, NSData *imgData) {
                              self.bg.image = [UIImage imageWithData:imgData];
                          }];
    self.bg.layer.masksToBounds = YES;
    self.bg.contentMode = UIViewContentModeScaleAspectFill;
    
    //no login
    /*
    [DLImageLoader loadImageFromURL:[response objectForKey:@"poster"]
     completed:^(NSError *error, NSData *imgData) {
     self.posternomember.image = [UIImage imageWithData:imgData];
     }];
     
     NSString *urlbg = [NSString stringWithFormat:@"%@%@",[response objectForKey:@"background"],@"?blur=30"];
     
    [DLImageLoader loadImageFromURL:urlbg
                          completed:^(NSError *error, NSData *imgData) {
                              self.bg.image = [UIImage imageWithData:imgData];
                          }];
    self.bg.layer.masksToBounds = YES;
    self.bg.contentMode = UIViewContentModeScaleAspectFill;
    
    self.conditionnomember.text = [[NSString alloc] initWithString:[response objectForKey:@"condition_info"]];

    CGRect frame = self.conditionnomember.frame;
    frame.size = [self.conditionnomember sizeOfMultiLineLabel];
    [self.conditionnomember sizeOfMultiLineLabel];
    [self.conditionnomember setFrame:frame];
    int lines = self.conditionnomember.frame.size.height/15;
    self.conditionnomember.numberOfLines = lines;
    UILabel *descText = [[UILabel alloc] initWithFrame:frame];
    descText.text = self.conditionnomember.text;
    descText.numberOfLines = lines;
    [descText setFont:[UIFont systemFontOfSize:15]];
    descText.textColor = [UIColor colorWithRed:104.0/255.0 green:71.0/255.0 blue:56.0/255.0 alpha:1.0];
    self.conditionnomember.alpha = 0;
    [self.conditionnomemberView addSubview:descText];
    self.conditionnomemberView.frame = CGRectMake(self.conditionnomemberView.frame.origin.x, self.conditionnomemberView.frame.origin.y, self.conditionnomemberView.frame.size.width, self.conditionnomemberView.frame.size.height+descText.frame.size.height-15);
    
    self.signinButton.frame = CGRectMake(self.signinButton.frame.origin.x, self.signinButton.frame.origin.y+descText.frame.size.height-25, self.signinButton.frame.size.width, self.signinButton.frame.size.height);
    
    CALayer *signinButton = [self.signinButton layer];
    [signinButton setMasksToBounds:YES];
    [signinButton setCornerRadius:7.0f];
    */
    //login
    
    
    [self.Demoapi getStamp];
    
}

- (void)DCManager:(id)sender getStampStyleErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void)DCManager:(id)sender getStampResponse:(NSDictionary *)response {
    self.obj = response;
    NSLog(@"Member nomemberview getStamp %@",response);
    
    //login
    if (!refreshDataMember) {
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObj addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    } else {
        [self.arrObj removeAllObjects];
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObj addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    }
    
    [self reloadData:YES];
    
}

- (void)DCManager:(id)sender getStampErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void)reloadData:(BOOL)animated
{
    [self.tableView reloadData];
    self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width,self.tableView.contentSize.height);
}

- (IBAction)posterTapped:(id)sender {
    
    [self.delegate HideTabbar];
    
    PFHistoryViewController *history = [[PFHistoryViewController alloc] init];
    
    if(IS_WIDESCREEN){
        history = [[PFHistoryViewController alloc] initWithNibName:@"PFHistoryViewController_Wide" bundle:nil];
    } else {
        history = [[PFHistoryViewController alloc] initWithNibName:@"PFHistoryViewController" bundle:nil];
    }
    history.delegate = self;
    [self.navController pushViewController:history animated:YES];
}

- (IBAction)posternoTapped:(id)sender {
    
    [self.delegate HideTabbar];
    
    PFHistoryViewController *history = [[PFHistoryViewController alloc] init];
    
    if(IS_WIDESCREEN){
        history = [[PFHistoryViewController alloc] initWithNibName:@"PFHistoryViewController_Wide" bundle:nil];
    } else {
        history = [[PFHistoryViewController alloc] initWithNibName:@"PFHistoryViewController" bundle:nil];
    }
    history.delegate = self;
    [self.navController pushViewController:history animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrObj count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFMemberCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFMemberCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CALayer *bgView = [cell.bgView layer];
    [bgView setMasksToBounds:YES];
    [bgView setCornerRadius:7.0f];
    
    CALayer *bgPoint = [cell.bgPoint layer];
    [bgPoint setMasksToBounds:YES];
    [bgPoint setCornerRadius:7.0f];
    
    NSString *img = [[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"picture"] objectForKey:@"link"];
    NSString *urlimg = [[NSString alloc] initWithFormat:@"%@%@",img,@"?width=100&height=100"];
    cell.image.imageURL = [[NSURL alloc] initWithString:urlimg];
    cell.name.text = [[NSString alloc] initWithString:[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"name"]];
    NSString *point = [[NSString alloc] initWithFormat:@"%@",[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"point"]];
    cell.point.text = point;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.delegate HideTabbar];
    
    PFRewardViewController *reward = [[PFRewardViewController alloc] init];
    
    if(IS_WIDESCREEN){
        reward = [[PFRewardViewController alloc] initWithNibName:@"PFRewardViewController_Wide" bundle:nil];
    } else {
        reward = [[PFRewardViewController alloc] initWithNibName:@"PFRewardViewController" bundle:nil];
    }
    reward.delegate = self;
    [self.navController pushViewController:reward animated:YES];

}

- (IBAction)addPointTapped:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"DemoCoffee"
                                message:@"Add point coming soon."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (void) PFRewardViewControllerBack {
    [self.delegate ShowTabbar];
}

- (void) PFHistoryViewControllerBack {
    [self.delegate ShowTabbar];
}

@end
