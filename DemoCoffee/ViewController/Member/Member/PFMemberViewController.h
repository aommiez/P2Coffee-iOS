//
//  PFMemberViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/16/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLImageLoader.h"
#import "UILabel+UILabelDynamicHeight.h"

#import "DCManager.h"

#import "PFMemberCell.h"

#import "PFHistoryViewController.h"
#import "PFRewardViewController.h"

@protocol PFMemberViewControllerDelegate <NSObject>

- (void)HideTabbar;
- (void)ShowTabbar;

@end

@interface PFMemberViewController : UIViewController

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) DCManager *Demoapi;
@property (strong, nonatomic) IBOutlet UINavigationController *navController;
@property (weak, nonatomic  ) IBOutlet UINavigationItem *navItem;

@property (retain, nonatomic) NSMutableArray *arrObj;
@property (strong, nonatomic) NSDictionary *obj;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) IBOutlet UIView *waitView;
@property (retain, nonatomic) IBOutlet UIView *popupwaitView;

@property (strong, nonatomic) IBOutlet UIImageView *bg;

@property (weak, nonatomic) IBOutlet UIView *nomemberView;
@property (weak, nonatomic) IBOutlet UIView *memberView;

@property (weak, nonatomic) IBOutlet UIImageView *posternomember;
@property (weak, nonatomic) IBOutlet UIView *conditionnomemberView;
@property (weak, nonatomic) IBOutlet UILabel_UILabelDynamicHeight *conditionnomember;
- (IBAction)posternoTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *signinButton;

@property (weak, nonatomic) IBOutlet UIImageView *postermember;
@property (strong, nonatomic) IBOutlet UILabel *showpoint;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

- (IBAction)posterTapped:(id)sender;
- (IBAction)addPointTapped:(id)sender;

@end
