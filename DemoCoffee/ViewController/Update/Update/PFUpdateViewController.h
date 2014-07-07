//
//  PFUpdateViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/16/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DCManager.h"

#import "PFUpdateCell.h"

#import "PFTutorialViewController.h"
#import "PFLoginViewController.h"
#import "PFUpdateDetailViewController.h"
#import "PFAccountViewController.h"
#import "PFNotificationViewController.h"

@protocol PFUpdateViewControllerDelegate <NSObject>

- (void)PFImageViewController:(id)sender viewPicture:(NSString *)link;
- (void)HideTabbar;
- (void)ShowTabbar;

@end

@interface PFUpdateViewController : UIViewController

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) DCManager *Demoapi;
@property (strong, nonatomic) IBOutlet UINavigationController *navController;
@property (strong, nonatomic  ) IBOutlet UINavigationItem *navItem;

@property (strong, nonatomic) PFTutorialViewController *tutorialView;
@property (strong, nonatomic) PFLoginViewController *loginView;

@property (strong, nonatomic) IBOutlet UIView *waitView;
@property (strong, nonatomic) IBOutlet UIView *popupwaitView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *arrObj;
@property (strong, nonatomic) NSDictionary *obj;

@property (strong, nonatomic) NSString *paging;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *act;
@property (strong, nonatomic) IBOutlet UILabel *loadLabel;

@end
