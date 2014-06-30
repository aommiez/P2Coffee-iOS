//
//  PFProfileViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/30/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFProfileViewController.h"

@interface PFProfileViewController ()

@end

@implementation PFProfileViewController

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
    [[self.navController navigationBar] setBarTintColor:[UIColor colorWithRed:247.0f/255.0f green:148.0f/255.0f blue:30.0f/255.0f alpha:0.9f]];
    
    [[self.navController navigationBar] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                 [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName, nil]];
    
    [[self.navController navigationBar] setTranslucent:YES];
    [self.view addSubview:self.navController.view];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    [rightButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIFont fontWithName:@"Helvetica" size:17.0],NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    self.navItem.rightBarButtonItem = rightButton;
    
    self.tableView.tableHeaderView = self.headerView;
    
    CALayer *facebook_bt = [self.facebook_bt layer];
    [facebook_bt setMasksToBounds:YES];
    [facebook_bt setCornerRadius:5.0f];
    
    CALayer *email_bt = [self.email_bt layer];
    [email_bt setMasksToBounds:YES];
    [email_bt setCornerRadius:5.0f];
    
    CALayer *website_bt = [self.website_bt layer];
    [website_bt setMasksToBounds:YES];
    [website_bt setCornerRadius:5.0f];
    
    CALayer *tel_bt = [self.tel_bt layer];
    [tel_bt setMasksToBounds:YES];
    [tel_bt setCornerRadius:5.0f];
    
    CALayer *gender_bt = [self.gender_bt layer];
    [gender_bt setMasksToBounds:YES];
    [gender_bt setCornerRadius:5.0f];
    
    CALayer *birthday_bt = [self.birthday_bt layer];
    [birthday_bt setMasksToBounds:YES];
    [birthday_bt setCornerRadius:5.0f];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)close {
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)editTapped:(id)sender{
    PFEditAccountViewController *editView = [[PFEditAccountViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editView = [[PFEditAccountViewController alloc] initWithNibName:@"PFEditAccountViewController_Wide" bundle:nil];
    } else {
        editView = [[PFEditAccountViewController alloc] initWithNibName:@"PFEditAccountViewController" bundle:nil];
    }
    
    //account.delegate = self;
    [self presentModalViewController:editView animated:YES];
}

@end
