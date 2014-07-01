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
    
    if ([self.checkstatus isEqualToString:@"displayname"]) {
        self.navigationItem.title = @"Display Name";
        self.tableView.tableHeaderView = self.displaynameView;
        
        self.displayname.text = [self.obj objectForKey:@"display_name"];
    }
    
    if ([self.checkstatus isEqualToString:@"password"]) {
        self.navigationItem.title = @"Password";
        self.tableView.tableHeaderView = self.passwordView;
        
    }
    
    if ([self.checkstatus isEqualToString:@"email"]) {
        self.navigationItem.title = @"E-mail Address";
        self.tableView.tableHeaderView = self.emailView;
        
        self.email.text = [self.obj objectForKey:@"email"];
    }
    
    if ([self.checkstatus isEqualToString:@"website"]) {
        self.navigationItem.title = @"Website";
        self.tableView.tableHeaderView = self.websiteView;
        
        self.website.text = [self.obj objectForKey:@"website"];
    }
    
    if ([self.checkstatus isEqualToString:@"phone"]) {
        self.navigationItem.title = @"Phone Number";
        self.tableView.tableHeaderView = self.phoneView;
        
        self.phone.text = [self.obj objectForKey:@"mobile_phone"];
    }
    
    if ([self.checkstatus isEqualToString:@"gender"]) {
        self.navigationItem.title = @"Gender";
        self.tableView.tableHeaderView = self.genserView;
        
        self.gender.text = [self.obj objectForKey:@"gender"];
    }
    
    if ([self.checkstatus isEqualToString:@"birthday"]) {
        self.navigationItem.title = @"Birthday";
        self.tableView.tableHeaderView = self.birthdayView;
        
        self.birthday.text = [[self.obj objectForKey:@"birth_date"] objectForKey:@"date"];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (IBAction)displaynameTapped:(id)sender{
}

@end
