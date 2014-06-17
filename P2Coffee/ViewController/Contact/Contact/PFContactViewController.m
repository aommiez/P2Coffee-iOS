//
//  PFContactViewController.m
//  P2Coffee
//
//  Created by Pariwat on 6/13/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFContactViewController.h"

@interface PFContactViewController ()

@end

@implementation PFContactViewController

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
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    
    //map
    CALayer *mapimg = [self.mapImage layer];
    [mapimg setMasksToBounds:YES];
    [mapimg setCornerRadius:7.0f];
    
    CALayer *mapbt = [self.mapButton layer];
    [mapbt setMasksToBounds:YES];
    [mapbt setCornerRadius:7.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (IBAction) mapTapped:(id)sender {
    
    [self.delegate HideTabbar];
    
    PFMapAllViewController *mapView = [[PFMapAllViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        mapView = [[PFMapAllViewController alloc] initWithNibName:@"PFMapAllViewController_Wide" bundle:nil];
    } else {
        mapView = [[PFMapAllViewController alloc] initWithNibName:@"PFMapAllViewController" bundle:nil];
    }
    
    mapView.delegate = self;
    [self.navController pushViewController:mapView animated:YES];
}

- (IBAction)webTapped:(id)sender {
    
    [self.delegate HideTabbar];
    
    PFWebViewController *webView = [[PFWebViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        webView = [[PFWebViewController alloc] initWithNibName:@"PFWebViewController_Wide" bundle:nil];
    } else {
        webView = [[PFWebViewController alloc] initWithNibName:@"PFWebViewController" bundle:nil];
    }
    
    webView.url = @"http://www.google.com";
    webView.delegate = self;
    [self.navController pushViewController:webView animated:YES];
}

- (void) PFMapAllViewControllerBack {
    [self.delegate ShowTabbar];
}

- (void) PFWebViewControllerBack {
    [self.delegate ShowTabbar];
}

@end
