//
//  PFEditViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/30/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFEditViewController.h"

@interface PFEditViewController ()

@end

@implementation PFEditViewController

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
    
    [self.view addSubview:self.waitView];
    
    CALayer *popup = [self.popupwaitView layer];
    [popup setMasksToBounds:YES];
    [popup setCornerRadius:7.0f];
    
    self.navItem.title = @"";
    
    // Navbar setup
    [[self.navController navigationBar] setBarTintColor:[UIColor colorWithRed:247.0f/255.0f green:148.0f/255.0f blue:30.0f/255.0f alpha:1.0f]];
    
    [[self.navController navigationBar] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                 [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName, nil]];
    
    [[self.navController navigationBar] setTranslucent:YES];
    [self.view addSubview:self.navController.view];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    [rightButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIFont fontWithName:@"Helvetica" size:17.0],NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    self.navItem.rightBarButtonItem = rightButton;
    
    self.tableView.tableHeaderView = self.headerView;
    
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    
    self.objEdit = [[NSDictionary alloc] init];
    
    [self.Demoapi me];
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

- (void)DCManager:(id)sender meResponse:(NSDictionary *)response {
    self.objEdit = response;
    NSLog(@"Me %@",response);
    
    [self.waitView removeFromSuperview];
    
    self.display_name.text = [response objectForKey:@"display_name"];
    
    NSString *picStr = [[response objectForKey:@"picture"] objectForKey:@"link"];
    self.thumUser.layer.masksToBounds = YES;
    self.thumUser.contentMode = UIViewContentModeScaleAspectFill;
    self.thumUser.imageURL = [[NSURL alloc] initWithString:picStr];
    
    self.email.text = [response objectForKey:@"email"];
    self.website.text = [response objectForKey:@"website"];
    self.tel.text = [response objectForKey:@"mobile_phone"];
    self.gender.text = [response objectForKey:@"gender"];
    self.birthday.text = [[response objectForKey:@"birth_date"] objectForKey:@"date"];
    
}

- (void)DCManager:(id)sender meErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (IBAction)displaynameTapped:(id)sender{
    PFEditDetailViewController *editdetail = [[PFEditDetailViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController_Wide" bundle:nil];
    } else {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController" bundle:nil];
    }
    editdetail.obj = self.objEdit;
    editdetail.checkstatus = @"displayname";
    [self.navController pushViewController:editdetail animated:YES];
}

- (IBAction)passwordTapped:(id)sender {
    PFEditDetailViewController *editdetail = [[PFEditDetailViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController_Wide" bundle:nil];
    } else {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController" bundle:nil];
    }
    editdetail.obj = self.objEdit;
    editdetail.checkstatus = @"password";
    [self.navController pushViewController:editdetail animated:YES];
}

- (IBAction)emailTapped:(id)sender {
    PFEditDetailViewController *editdetail = [[PFEditDetailViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController_Wide" bundle:nil];
    } else {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController" bundle:nil];
    }
    editdetail.obj = self.objEdit;
    editdetail.checkstatus = @"email";
    [self.navController pushViewController:editdetail animated:YES];
}

- (IBAction)websiteTapped:(id)sender {
    PFEditDetailViewController *editdetail = [[PFEditDetailViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController_Wide" bundle:nil];
    } else {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController" bundle:nil];
    }
    editdetail.obj = self.objEdit;
    editdetail.checkstatus = @"website";
    [self.navController pushViewController:editdetail animated:YES];
}

- (IBAction)telTapped:(id)sender {
    PFEditDetailViewController *editdetail = [[PFEditDetailViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController_Wide" bundle:nil];
    } else {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController" bundle:nil];
    }
    editdetail.obj = self.objEdit;
    editdetail.checkstatus = @"phone";
    [self.navController pushViewController:editdetail animated:YES];
}

- (IBAction)genderTapped:(id)sender {
    PFEditDetailViewController *editdetail = [[PFEditDetailViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController_Wide" bundle:nil];
    } else {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController" bundle:nil];
    }
    editdetail.obj = self.objEdit;
    editdetail.checkstatus = @"gender";
    [self.navController pushViewController:editdetail animated:YES];
}

- (IBAction)birthdayTapped:(id)sender {
    PFEditDetailViewController *editdetail = [[PFEditDetailViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController_Wide" bundle:nil];
    } else {
        editdetail = [[PFEditDetailViewController alloc] initWithNibName:@"PFEditDetailViewController" bundle:nil];
    }
    editdetail.obj = self.objEdit;
    editdetail.checkstatus = @"birthday";
    [self.navController pushViewController:editdetail animated:YES];
}

@end
