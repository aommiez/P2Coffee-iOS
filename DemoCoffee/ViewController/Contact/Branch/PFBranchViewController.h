//
//  PFBranchViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/16/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLImageLoader.h"
#import "CMMapLauncher.h"
#import "AsyncImageView.h"

#import "DCManager.h"

#import "PFMapViewController.h"
#import "ScrollView.h"

@protocol PFBranchViewControllerDelegate <NSObject>

- (void)PFGalleryViewController:(id)sender sum:(NSMutableArray *)sum current:(NSString *)current;
- (void)PFBranchViewControllerBack;

@end

@interface PFBranchViewController : UIViewController < UIScrollViewDelegate > {
    
    IBOutlet ScrollView *scrollView;
    IBOutlet AsyncImageView *imageView;
    NSMutableArray *images;
    NSArray *imagesName;
    
}

@property (assign, nonatomic) id <PFBranchViewControllerDelegate> delegate;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

@property (strong, nonatomic) DCManager *Demoapi;
@property (strong, nonatomic) NSMutableArray *arrObj;
@property (strong, nonatomic) NSDictionary *obj;

@property (strong, nonatomic) NSDictionary *objContact;

@property (strong, nonatomic) IBOutlet UIView *waitView;
@property (strong, nonatomic) IBOutlet UIView *popupwaitView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *branchView;

@property (strong, nonatomic) IBOutlet AsyncImageView *mapImage;
@property (strong, nonatomic) IBOutlet UILabel *location;
@property (strong, nonatomic) IBOutlet UILabel *phone;

@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lng;

@property (strong, nonatomic) NSString *product_id;
@property (strong, nonatomic) NSString *current;

@property (strong, nonatomic) NSMutableArray *arrgalleryimg;

- (IBAction)fullimgTapped:(id)sender;

- (IBAction)mapTapped:(id)sender;

- (IBAction)locationTapped:(id)sender;
- (IBAction)callTapped:(id)sender;

@end
