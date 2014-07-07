//
//  PFMapAllViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/16/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFMapView.h"
#import "CMMapLauncher.h"

#import "DCManager.h"

@protocol PFMapAllViewControllerDelegate <NSObject>

- (void) PFMapAllViewControllerBack;

@end

@interface PFMapAllViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate>

@property (assign, nonatomic) id <PFMapAllViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet PFMapView *allmapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

@property (strong, nonatomic) DCManager *Demoapi;
@property (strong, nonatomic) NSMutableArray *arrObj;
@property (strong, nonatomic) NSDictionary *obj;

@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lng;

@end
