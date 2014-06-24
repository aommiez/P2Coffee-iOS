//
//  PFMapViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/16/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFMapView.h"
#import "CMMapLauncher.h"

@interface PFMapViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate>

@property (assign, nonatomic) id delegate;

@property (retain, nonatomic) IBOutlet PFMapView *mapView;
@property (retain, nonatomic) CLLocationManager *locationManager;
@property (retain, nonatomic) CLLocation *currentLocation;

@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lng;
@property (strong, nonatomic) NSString *name;

@end
