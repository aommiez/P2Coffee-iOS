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
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(SaveProfile)];
    [rightButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont fontWithName:@"Helvetica" size:17.0],NSFontAttributeName,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.scrollView.contentSize = CGSizeMake(self.formView.frame.size.width, self.formView.frame.size.height+20);
    self.formView.frame = CGRectMake(0, 0, self.formView.frame.size.width,self.formView.frame.size.height);
    [self.scrollView addSubview:self.formView];
    
    CALayer *saveButton = [self.saveButton layer];
    [saveButton setMasksToBounds:YES];
    [saveButton setCornerRadius:5.0f];
    
    self.display_name.text = [self.objAccount objectForKey:@"display_name"];
    
    NSString *picStr = [[self.objAccount objectForKey:@"picture"] objectForKey:@"link"];
    self.thumUser.layer.masksToBounds = YES;
    self.thumUser.contentMode = UIViewContentModeScaleAspectFill;
    self.thumUser.imageURL = [[NSURL alloc] initWithString:picStr];
    
    self.facebook.text = [self.objAccount objectForKey:@"display_name"];
    self.email.text = [self.objAccount objectForKey:@"email"];
    self.website.text = [self.objAccount objectForKey:@"website"];
    self.tel.text = [self.objAccount objectForKey:@"mobile_phone"];
    self.gender.text = [self.objAccount objectForKey:@"gender"];
    self.birthday.text = [[self.objAccount objectForKey:@"birth_date"] objectForKey:@"date"];
    
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
    
    [self.display_name resignFirstResponder];
    [self.facebook resignFirstResponder];
    [self.email resignFirstResponder];
    [self.website resignFirstResponder];
    [self.tel resignFirstResponder];
    [self.gender resignFirstResponder];
    [self.birthday resignFirstResponder];
    
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // 'Back' button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        if([self.delegate respondsToSelector:@selector(PFEditAccountViewControllerBack)]){
            [self.delegate PFEditAccountViewControllerBack];
        }
    }
    
}

@end
