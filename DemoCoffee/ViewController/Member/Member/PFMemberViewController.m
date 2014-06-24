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
    
    self.navItem.title = NSLocalizedString(@"DEMO_MEMBER", nil);
    
    // Navbar setup
    [[self.navController navigationBar] setBarTintColor:[UIColor colorWithRed:247.0f/255.0f green:148.0f/255.0f blue:30.0f/255.0f alpha:1.0f]];
    
    [[self.navController navigationBar] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                 [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName, nil]];
    
    [[self.navController navigationBar] setTranslucent:YES];
    [self.view addSubview:self.navController.view];
    
    //self.tableView.tableHeaderView = self.nomemberView;
    self.tableView.tableHeaderView = self.memberView;
    
    UIView *fv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 52)];
    self.tableView.tableFooterView = fv;
    
    CALayer *postermember = [self.postermember layer];
    [postermember setMasksToBounds:YES];
    [postermember setCornerRadius:7.0f];
    
    CALayer *addButton = [self.addButton layer];
    [addButton setMasksToBounds:YES];
    [addButton setCornerRadius:7.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
