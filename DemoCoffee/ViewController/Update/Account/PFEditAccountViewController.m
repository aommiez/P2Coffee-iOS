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
    
    self.navigationItem.title = @"P2 Coffee";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(SaveProfile)];
    [rightButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont fontWithName:@"Helvetica" size:17.0],NSFontAttributeName,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.scrollView.contentSize = CGSizeMake(self.formView.frame.size.width, self.formView.frame.size.height+20);
    self.formView.frame = CGRectMake(0, 0, self.formView.frame.size.width,self.formView.frame.size.height);
    [self.scrollView addSubview:self.formView];
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

@end
