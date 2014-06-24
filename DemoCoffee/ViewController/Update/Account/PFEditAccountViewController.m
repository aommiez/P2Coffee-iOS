//
//  PFEditAccountViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/20/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFEditAccountViewController.h"

@interface PFEditAccountViewController ()

@end

@implementation PFEditAccountViewController

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
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"save_button", nil) style:UIBarButtonItemStyleDone target:self action:@selector(SaveProfile)];
    [rightButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont fontWithName:@"Helvetica" size:17.0],NSFontAttributeName,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.scrollView.contentSize = CGSizeMake(self.formView.frame.size.width, self.formView.frame.size.height+20);
    self.formView.frame = CGRectMake(0, 0, self.formView.frame.size.width,self.formView.frame.size.height);
    [self.scrollView addSubview:self.formView];
    
    CALayer *saveButton = [self.saveButton layer];
    [saveButton setMasksToBounds:YES];
    [saveButton setCornerRadius:5.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)SaveProfile {
    [[[UIAlertView alloc] initWithTitle:@"DemoCoffee"
                                message:@"Save profile coming soon."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (IBAction)changepasswordTapped:(id)sender {
    [self.view addSubview:self.blurView];
    [self.changepasswordView.layer setCornerRadius:4.0f];
    self.changepasswordView.frame = CGRectMake(10, 161, self.changepasswordView.frame.size.width, self.changepasswordView.frame.size.height);
    [self.view addSubview:self.changepasswordView];
}

- (IBAction)bgTapped:(id)sender {
    [self.blurView removeFromSuperview];
    [self.changepasswordView removeFromSuperview];
}

- (IBAction)saveTapped:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"DemoCoffee"
                                message:@"Save password coming soon."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField  {
//    [self.emailSignIn resignFirstResponder];
//    [self.passwordSignIn resignFirstResponder];
//    
//    [self.username resignFirstResponder];
//    [self.emailSignUp resignFirstResponder];
//    [self.passwordSignUp resignFirstResponder];
//    [self.confirmSignUp resignFirstResponder];
    
    return YES;
}

@end
