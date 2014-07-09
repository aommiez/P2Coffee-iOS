//
//  PFBranch1ViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/25/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFBranch1ViewController.h"

@interface PFBranch1ViewController ()

@end

@implementation PFBranch1ViewController

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
    
    [self.view addSubview:self.waitView];
    
    CALayer *popup = [self.popupwaitView layer];
    [popup setMasksToBounds:YES];
    [popup setCornerRadius:7.0f];
    
    self.navigationItem.title =[self.objContact objectForKey:@"name"];
    
    self.tableView.tableHeaderView = self.branchView;
    
    NSLog(@"branch from contact %@",self.objContact);
    self.lat = [self.objContact objectForKey:@"lat"];
    self.lng = [self.objContact objectForKey:@"lng"];
    
    CALayer *mapimg = [self.mapImage layer];
    [mapimg setMasksToBounds:YES];
    [mapimg setCornerRadius:7.0f];
    
    self.mapView.layer.shadowOffset = CGSizeMake(0.5, -0.5);
    self.mapView.layer.shadowRadius = 2;
    self.mapView.layer.shadowOpacity = 0.1;
    
    NSString *urlmap = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",@"http://maps.googleapis.com/maps/api/staticmap?center=",self.lat,@",",self.lng,@"&zoom=16&size=6400x280&sensor=false&markers=color:red%7Clabel:Satit%7C",self.lat,@",",self.lng];
    
    NSData *data = [NSData dataWithContentsOfURL:[[NSURL alloc] initWithString:urlmap]];
    self.mapImage.image = [UIImage imageWithData: data];
    
    self.location.text = [self.objContact objectForKey:@"address"];
    self.phone.text = [self.objContact objectForKey:@"phone"];
    
    self.arrObj = [[NSMutableArray alloc] init];
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    
    [self.Demoapi getBranchById:[self.objContact objectForKey:@"id"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (IBAction)fullimgTapped:(id)sender {
    [self.delegate PFImageViewController:self viewPicture:self.link];
}

- (void)DCManager:(id)sender getBranchByIdResponse:(NSDictionary *)response {
    NSLog(@"branchid %@",response);
    
    [self.waitView removeFromSuperview];
    
    self.link = [[self.objContact objectForKey:@"thumb"] objectForKey:@"link"];

    NSString *urlimg = [[NSString alloc] initWithFormat:@"%@%@",[[self.objContact objectForKey:@"thumb"] objectForKey:@"link"],@"?width=800&height=600"];
    self.imageView.imageURL = [NSURL URLWithString:urlimg];
    
    self.imageView.layer.masksToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
}

- (void)DCManager:(id)sender getBranchByIdErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (IBAction) mapTapped:(id)sender {
    
    PFMapViewController *mapView = [[PFMapViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        mapView = [[PFMapViewController alloc] initWithNibName:@"PFMapViewController_Wide" bundle:nil];
    } else {
        mapView = [[PFMapViewController alloc] initWithNibName:@"PFMapViewController" bundle:nil];
    }
    
    mapView.lat = [self.objContact objectForKey:@"lat"];
    mapView.lng = [self.objContact objectForKey:@"lng"];
    mapView.name = [self.objContact objectForKey:@"name"];
    mapView.delegate = self;
    [self.navigationController pushViewController:mapView animated:YES];
}

- (IBAction) locationTapped:(id)sender {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [self.locationManager startUpdatingLocation];
}

- (IBAction)callTapped:(id)sender {
    NSString *phone = [[NSString alloc] initWithFormat:@"telprompt://%@",[self.objContact objectForKey:@"phone"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    self.currentLocation = newLocation;
    CLLocationCoordinate2D location;
	location.latitude = [self.lat doubleValue];
	location.longitude = [self.lng doubleValue];
    [self.locationManager stopUpdatingLocation];
    [CMMapLauncher launchMapApp:CMMapAppAppleMaps
              forDirectionsFrom:[CMMapPoint mapPointWithName:@"Origin"
                                                  coordinate:newLocation.coordinate]
                             to:[CMMapPoint mapPointWithName:@"Destination"
                                                  coordinate:location]];
    return;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // 'Back' button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        if([self.delegate respondsToSelector:@selector(PFBranch1ViewControllerBack)]){
            [self.delegate PFBranch1ViewControllerBack];
        }
    }
}

@end
