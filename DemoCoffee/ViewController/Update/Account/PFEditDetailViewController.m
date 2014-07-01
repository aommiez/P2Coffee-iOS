//
//  PFEditDetailViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/30/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFEditDetailViewController.h"

@interface PFEditDetailViewController ()

@end

@implementation PFEditDetailViewController

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
    
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    
    if ([self.checkstatus isEqualToString:@"displayname"]) {
        self.navigationItem.title = @"Display Name";
        self.tableView.tableHeaderView = self.displaynameView;
        
        self.displayname.text = [self.obj objectForKey:@"display_name"];
        
        CALayer *displayname_bt = [self.displayname_bt layer];
        [displayname_bt setMasksToBounds:YES];
        [displayname_bt setCornerRadius:5.0f];
    }
    
    if ([self.checkstatus isEqualToString:@"password"]) {
        self.navigationItem.title = @"Password";
        self.tableView.tableHeaderView = self.passwordView;
        
        
    }
    
    if ([self.checkstatus isEqualToString:@"email"]) {
        self.navigationItem.title = @"E-mail Address";
        self.tableView.tableHeaderView = self.emailView;
        
        self.email.text = [self.obj objectForKey:@"email"];
        
        CALayer *email_bt = [self.email_bt layer];
        [email_bt setMasksToBounds:YES];
        [email_bt setCornerRadius:5.0f];
    }
    
    if ([self.checkstatus isEqualToString:@"website"]) {
        self.navigationItem.title = @"Website";
        self.tableView.tableHeaderView = self.websiteView;
        
        self.website.text = [self.obj objectForKey:@"website"];
        
        CALayer *website_bt = [self.website_bt layer];
        [website_bt setMasksToBounds:YES];
        [website_bt setCornerRadius:5.0f];
    }
    
    if ([self.checkstatus isEqualToString:@"phone"]) {
        self.navigationItem.title = @"Phone Number";
        self.tableView.tableHeaderView = self.phoneView;
        
        self.phone.text = [self.obj objectForKey:@"mobile_phone"];
        
        CALayer *phone_bt = [self.phone_bt layer];
        [phone_bt setMasksToBounds:YES];
        [phone_bt setCornerRadius:5.0f];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)DCManager:(id)sender getUserSettingResponse:(NSDictionary *)response {
    NSLog(@"settingUser %@",response);
}

- (void)DCManager:(id)sender getUserSettingErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (IBAction)displaynameTapped:(id)sender{
    
    [self.displayname resignFirstResponder];
    
    [self.Demoapi updateSetting:self.displayname.text
                       facebook:[self.obj objectForKey:@"facebook_name"]
                          email:[self.obj objectForKey:@"email"]
                        website:[self.obj objectForKey:@"website"]
                            tel:[self.obj objectForKey:@"mobile_phone"]
                         gender:[self.obj objectForKey:@"gender"]
                       birthday:[[self.obj objectForKey:@"birth_date"] objectForKey:@"date"]];
    
    [[[UIAlertView alloc] initWithTitle:@"DemoCoffee"
                                message:@"Save complete."
                               delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (IBAction)passwordTapped:(id)sender{

}

- (IBAction)emailTapped:(id)sender{
    
    [self.email resignFirstResponder];
    
    [self.Demoapi updateSetting:[self.obj objectForKey:@"display_name"]
                       facebook:[self.obj objectForKey:@"facebook_name"]
                          email:self.email.text
                        website:[self.obj objectForKey:@"website"]
                            tel:[self.obj objectForKey:@"mobile_phone"]
                         gender:[self.obj objectForKey:@"gender"]
                       birthday:[[self.obj objectForKey:@"birth_date"] objectForKey:@"date"]];
    
    [[[UIAlertView alloc] initWithTitle:@"DemoCoffee"
                                message:@"Save complete."
                               delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (IBAction)websiteTapped:(id)sender{
    
    [self.website resignFirstResponder];
    
    [self.Demoapi updateSetting:[self.obj objectForKey:@"display_name"]
                       facebook:[self.obj objectForKey:@"facebook_name"]
                          email:[self.obj objectForKey:@"email"]
                        website:self.website.text
                            tel:[self.obj objectForKey:@"mobile_phone"]
                         gender:[self.obj objectForKey:@"gender"]
                       birthday:[[self.obj objectForKey:@"birth_date"] objectForKey:@"date"]];
    
    [[[UIAlertView alloc] initWithTitle:@"DemoCoffee"
                                message:@"Save complete."
                               delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (IBAction)phoneTapped:(id)sender{
    
    [self.phone resignFirstResponder];
    
    [self.Demoapi updateSetting:[self.obj objectForKey:@"display_name"]
                       facebook:[self.obj objectForKey:@"facebook_name"]
                          email:[self.obj objectForKey:@"email"]
                        website:[self.obj objectForKey:@"website"]
                            tel:self.phone.text
                         gender:[self.obj objectForKey:@"gender"]
                       birthday:[[self.obj objectForKey:@"birth_date"] objectForKey:@"date"]];
    
    [[[UIAlertView alloc] initWithTitle:@"DemoCoffee"
                                message:@"Save complete."
                               delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // 'Back' button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        if([self.delegate respondsToSelector:@selector(PFEditDetailViewControllerBack)]){
            [self.delegate PFEditDetailViewControllerBack];
        }
    }
    
}

@end
