//
//  PFBranchViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/16/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFBranchViewController.h"

@interface PFBranchViewController ()

@end

@implementation PFBranchViewController

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
    
    self.navigationItem.title =[self.obj objectForKey:@"name"];
    self.tableView.tableHeaderView = self.branchView;
    
    NSLog(@"%@",self.obj);
    
    CALayer *mapimg = [self.mapImage layer];
    [mapimg setMasksToBounds:YES];
    [mapimg setCornerRadius:7.0f];
    
    NSString *urlmap = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",@"http://maps.googleapis.com/maps/api/staticmap?center=",self.lat,@",",self.lng,@"&zoom=16&size=6400x280&sensor=false&markers=color:red%7Clabel:Satit%7C",self.lat,@",",self.lng];
    
    NSData *data = [NSData dataWithContentsOfURL:[[NSURL alloc] initWithString:urlmap]];
    self.mapImage.image = [UIImage imageWithData: data];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (IBAction) mapTapped:(id)sender {
    
    PFMapViewController *mapView = [[PFMapViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        mapView = [[PFMapViewController alloc] initWithNibName:@"PFMapViewController_Wide" bundle:nil];
    } else {
        mapView = [[PFMapViewController alloc] initWithNibName:@"PFMapViewController" bundle:nil];
    }
    
    mapView.lat = [self.obj objectForKey:@"lat"];
    mapView.lng = [self.obj objectForKey:@"lng"];
    mapView.name = [self.obj objectForKey:@"name"];
    mapView.delegate = self;
    [self.navigationController pushViewController:mapView animated:YES];
}

- (IBAction)callTapped:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"DemoCoffee"
                                message:@"Contact coming soon."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // 'Back' button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        if([self.delegate respondsToSelector:@selector(PFBranchViewControllerBack)]){
            [self.delegate PFBranchViewControllerBack];
        }
    }
}

@end
