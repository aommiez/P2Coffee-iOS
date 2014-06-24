//
//  PFAccountViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/20/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFAccountViewController.h"

@interface PFAccountViewController ()

@end

@implementation PFAccountViewController

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
    
    self.navigationItem.title = NSLocalizedString(@"edit_title", nil);
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"edit_button", nil) style:UIBarButtonItemStyleDone target:self action:@selector(editProfileTapped)];
    [rightButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont fontWithName:@"Helvetica" size:17.0],NSFontAttributeName,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.scrollView.contentSize = CGSizeMake(self.formView.frame.size.width, self.formView.frame.size.height+20);
    self.formView.frame = CGRectMake(10, 10, self.formView.frame.size.width,self.formView.frame.size.height);
    [self.scrollView addSubview:self.formView];
    
    CALayer *facebookView = [self.facebookView layer];
    [facebookView setMasksToBounds:YES];
    [facebookView setCornerRadius:5.0f];
    
    CALayer *emailView = [self.emailView layer];
    [emailView setMasksToBounds:YES];
    [emailView setCornerRadius:5.0f];
    
    CALayer *websiteView = [self.websiteView layer];
    [websiteView setMasksToBounds:YES];
    [websiteView setCornerRadius:5.0f];
    
    CALayer *phoneView = [self.phoneView layer];
    [phoneView setMasksToBounds:YES];
    [phoneView setCornerRadius:5.0f];
    
    CALayer *genderView = [self.genderView layer];
    [genderView setMasksToBounds:YES];
    [genderView setCornerRadius:5.0f];
    
    CALayer *birthdayView = [self.birthdayView layer];
    [birthdayView setMasksToBounds:YES];
    [birthdayView setCornerRadius:5.0f];
    
    CALayer *logoutButton = [self.logoutButton layer];
    [logoutButton setMasksToBounds:YES];
    [logoutButton setCornerRadius:5.0f];
    
    CALayer *settingView = [self.settingView layer];
    [settingView setMasksToBounds:YES];
    [settingView setCornerRadius:5.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)editProfileTapped {
    PFEditAccountViewController *editView = [[PFEditAccountViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editView = [[PFEditAccountViewController alloc] initWithNibName:@"PFEditAccountViewController_Wide" bundle:nil];
    } else {
        editView = [[PFEditAccountViewController alloc] initWithNibName:@"PFEditAccountViewController" bundle:nil];
    }
    
    editView.delegate = self;
    [self.navigationController pushViewController:editView animated:YES];
}

- (IBAction)logoutTapped:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"DemoCoffee"
                                message:@"Logout coming soon."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // 'Back' button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        if([self.delegate respondsToSelector:@selector(PFAccountViewControllerBack)]){
            [self.delegate PFAccountViewControllerBack];
        }
    }
    
}

@end
