//
//  PFBranch1ViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/25/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLImageLoader.h"
#import "CMMapLauncher.h"
#import "AsyncImageView.h"

#import "DCManager.h"

#import "PFMapViewController.h"
#import "ScrollView.h"

@protocol PFBranch1ViewControllerDelegate <NSObject>

- (void)PFImageViewController:(id)sender viewPicture:(NSString *)link;
- (void)PFBranch1ViewControllerBack;

@end

@interface PFBranch1ViewController : UIViewController

@property (assign, nonatomic) id <PFBranch1ViewControllerDelegate> delegate;
@property (retain, nonatomic) CLLocationManager *locationManager;
@property (retain, nonatomic) CLLocation *currentLocation;

@property (strong, nonatomic) DCManager *Demoapi;
@property (retain, nonatomic) NSMutableArray *arrObj;
@property (strong, nonatomic) NSDictionary *obj;

@property (strong, nonatomic) NSDictionary *objContact;

@property (retain, nonatomic) IBOutlet UIView *waitView;
@property (retain, nonatomic) IBOutlet UIView *popupwaitView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *branchView;
@property (weak, nonatomic) IBOutlet AsyncImageView *imageView;
@property (weak, nonatomic) IBOutlet AsyncImageView *mapImage;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *phone;

@property (strong, nonatomic) NSString *link;

@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lng;

@property (strong, nonatomic) NSString *product_id;
@property (strong, nonatomic) NSString *current;

- (IBAction)fullimgTapped:(id)sender;

- (IBAction)mapTapped:(id)sender;

- (IBAction)locationTapped:(id)sender;
- (IBAction)callTapped:(id)sender;

@end
