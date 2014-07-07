//
//  PFContactViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/13/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h> 
#import "DLImageLoader.h"
#import "UILabel+UILabelDynamicHeight.h"

#import "DCManager.h"

#import "PFContactCell.h"

#import "PFBranchViewController.h"
#import "PFBranch1ViewController.h"
#import "PFMapAllViewController.h"
#import "PFWebViewController.h"

@protocol PFContactViewControllerDelegate <NSObject>

- (void)PFImageViewController:(id)sender viewPicture:(NSString *)link;
- (void)PFGalleryViewController:(id)sender sum:(NSMutableArray *)sum current:(NSString *)current;
- (void)HideTabbar;
- (void)ShowTabbar;

@end

@interface PFContactViewController : UIViewController < MFMailComposeViewControllerDelegate >

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) DCManager *Demoapi;
@property (strong, nonatomic) NSMutableArray *arrObj;
@property (strong, nonatomic) NSDictionary *obj;

@property (strong, nonatomic) IBOutlet UIView *waitView;
@property (strong, nonatomic) IBOutlet UIView *popupwaitView;

@property (strong, nonatomic) IBOutlet UINavigationController *navController;
@property (strong, nonatomic  ) IBOutlet UINavigationItem *navItem;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (strong, nonatomic) IBOutlet UIView *imgscrollview;
@property (strong, nonatomic) NSMutableArray *arrcontactimg;
@property (strong, nonatomic) NSString *current;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel_UILabelDynamicHeight *content;

@property (strong, nonatomic) IBOutlet UIView *mapView;
@property (strong, nonatomic) IBOutlet UIView *mapButton;
@property (strong, nonatomic) IBOutlet UIImageView *mapImage;
@property (strong, nonatomic) IBOutlet UILabel_UILabelDynamicHeight *location;

@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *website;
@property (strong, nonatomic) IBOutlet UILabel *email;

- (IBAction)mapTapped:(id)sender;

- (IBAction)callTapped:(id)sender;
- (IBAction)webTapped:(id)sender;
- (IBAction)emailTapped:(id)sender;
- (IBAction)powerbyTapped:(id)sender;

@end
