//
//  PFUpdateViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/16/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFUpdateViewController.h"

@interface PFUpdateViewController ()

@end

@implementation PFUpdateViewController

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
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Setting_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(account)];
    
    //notification if (noti = 0) else
    //UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Notification_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(notify)];
    
    UIButton *toggleKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    toggleKeyboardButton.bounds = CGRectMake( 0, 0, 21, 21 );
    [toggleKeyboardButton setTitle:@"10" forState:UIControlStateNormal];
    [toggleKeyboardButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    [toggleKeyboardButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    toggleKeyboardButton.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [toggleKeyboardButton setBackgroundColor:[UIColor clearColor]];
    [toggleKeyboardButton.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [toggleKeyboardButton.layer setBorderWidth: 1.0];
    [toggleKeyboardButton.layer setCornerRadius:10.0f];
    [toggleKeyboardButton addTarget:self action:@selector(notify) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:toggleKeyboardButton];
    
    self.navItem.leftBarButtonItem = leftButton;
    self.navItem.rightBarButtonItem = rightButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)account {
    
}

- (void)notify {
    
}

@end
