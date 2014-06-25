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
    
    [self.view addSubview:self.waitView];
    
    CALayer *popup = [self.popupwaitView layer];
    [popup setMasksToBounds:YES];
    [popup setCornerRadius:7.0f];
    
    self.navigationItem.title =[self.objContact objectForKey:@"name"];
    self.tableView.tableHeaderView = self.branchView;
    
    NSLog(@"branch %@",self.objContact);
    self.lat = [self.objContact objectForKey:@"lat"];
    self.lng = [self.objContact objectForKey:@"lng"];
    
    CALayer *mapimg = [self.mapImage layer];
    [mapimg setMasksToBounds:YES];
    [mapimg setCornerRadius:7.0f];
    
    self.location.text = [self.objContact objectForKey:@"address"];
    self.phone.text = [self.objContact objectForKey:@"phone"];
    
    self.arrObj = [[NSMutableArray alloc] init];
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    
    images = [[NSMutableArray alloc]init];

    [self.Demoapi getBranchById:[self.objContact objectForKey:@"id"]];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [scrollView addGestureRecognizer:singleTap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    CGPoint touchPoint=[gesture locationInView:scrollView];
    for(int index=0;index<[images count];index++)
	{
		UIImageView *imgView = [images objectAtIndex:index];
		
		if(CGRectContainsPoint([imgView frame], touchPoint))
		{
            self.current = [NSString stringWithFormat:@"%d",index];
			[self ShowDetailView:imgView];
			break;
		}
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch * touch = [[event allTouches] anyObject];
	
	for(int index=0;index<[images count];index++)
	{
		UIImageView *imgView = [images objectAtIndex:index];
		
		if(CGRectContainsPoint([imgView frame], [touch locationInView:scrollView]))
		{
			[self ShowDetailView:imgView];
			break;
		}
	}
}

-(void)ShowDetailView:(UIImageView *)imgView
{
	imageView.image = imgView.image;
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (IBAction)fullimgTapped:(id)sender {
    [self.delegate PFGalleryViewController:self sum:self.arrgalleryimg current:self.current];
}

- (void)DCManager:(id)sender getBranchByIdResponse:(NSDictionary *)response {
    NSLog(@"branchid = %@",response);
    
    [self.waitView removeFromSuperview];
    
    NSString *urlmap = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",@"http://maps.googleapis.com/maps/api/staticmap?center=",self.lat,@",",self.lng,@"&zoom=16&size=6400x280&sensor=false&markers=color:red%7Clabel:Satit%7C",self.lat,@",",self.lng];
    
    NSData *data = [NSData dataWithContentsOfURL:[[NSURL alloc] initWithString:urlmap]];
    self.mapImage.image = [UIImage imageWithData: data];
    
    if ([[response objectForKey:@"length"] intValue] == 0) {
    
    } else {
    
    scrollView.delegate = self;
	scrollView.scrollEnabled = YES;
	int scrollWidth = 70;
	scrollView.contentSize = CGSizeMake(scrollWidth,70);
    
    int xOffset = 0;
    
    NSString *thumbid = [[[[response objectForKey:@"data"] objectAtIndex:0] objectForKey:@"picture"] objectForKey:@"id"];
    NSString *urlimg = [[NSString alloc] initWithFormat:@"%@%@%@",@"http://coffee-api.pla2app.com/picture/",thumbid,@"?width=800&height=600"];
    imageView.imageURL = [NSURL URLWithString:urlimg];
    
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.arrgalleryimg = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
        //
		AsyncImageView *img = [[AsyncImageView alloc] init];
        
        img.layer.masksToBounds = YES;
        img.contentMode = UIViewContentModeScaleAspectFill;
        
		img.frame = CGRectMake(xOffset, 0, 70, 70);
        
        NSString *thumbid = [[[[response objectForKey:@"data"] objectAtIndex:i] objectForKey:@"picture"] objectForKey:@"id"];
        NSString *urlimg = [[NSString alloc] initWithFormat:@"%@%@%@",@"http://coffee-api.pla2app.com/picture/",thumbid,@"?width=800&height=600"];
        img.imageURL = [[NSURL alloc] initWithString:urlimg];
        
		[images insertObject:img atIndex:i];
        
        [self.arrgalleryimg addObject:[[[[response objectForKey:@"data"] objectAtIndex:i] objectForKey:@"picture"] objectForKey:@"link"]];
        
		scrollView.contentSize = CGSizeMake(scrollWidth+xOffset,70);
		[scrollView addSubview:[images objectAtIndex:i]];
		
		xOffset += 70;
    }
    }
    
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
        if([self.delegate respondsToSelector:@selector(PFBranchViewControllerBack)]){
            [self.delegate PFBranchViewControllerBack];
        }
    }
}

@end
