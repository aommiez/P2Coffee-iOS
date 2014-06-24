//
//  PFMapViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/16/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFMapViewController.h"

@interface PFMapViewController ()

@end

@implementation PFMapViewController

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
    
    self.navigationItem.title = @"Map";
    
    NSLog(@"%@",self.lat);
    NSLog(@"%@",self.lng);
    
    self.lng = [[NSString alloc] init];
    self.lat = [[NSString alloc] init];
    
    CLLocationCoordinate2D location;
    location.latitude = [self.lat doubleValue];
    location.longitude = [self.lng doubleValue];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = location;
    point.title = self.name;
    
    
    [self.mapView addAnnotation:point];
    [self.mapView selectAnnotation:point animated:NO];
    [self.mapView setCenterCoordinate:location zoomLevel:13 animated:NO];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

@end
