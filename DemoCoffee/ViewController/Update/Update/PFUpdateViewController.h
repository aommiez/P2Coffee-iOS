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
@property (weak, nonatomic  ) IBOutlet UINavigationItem *navItem;

@property (retain, nonatomic) PFLoginViewController *loginView;

@property (retain, nonatomic) IBOutlet UIView *waitView;
@property (retain, nonatomic) IBOutlet UIView *popupwaitView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) NSMutableArray *arrObj;
@property (strong, nonatomic) NSDictionary *obj;

@property (retain, nonatomic) NSString *paging;

@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *act;
@property (retain, nonatomic) IBOutlet UILabel *loadLabel;

@end
