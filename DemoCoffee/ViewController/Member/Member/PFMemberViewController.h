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
#import "UIERealTimeBlurView.h"
#import "AMBlurView.h"

#import "DCManager.h"

#import "PFMemberCell.h"

#import "PFTabBarViewController.h"
#import "PFLoginViewController.h"
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

@property (strong, nonatomic) PFTabBarViewController *tabBarViewController;

@property (retain, nonatomic) PFLoginViewController *loginView;
@property (strong, nonatomic) IBOutlet UIView *blurView;

@property (retain, nonatomic) NSMutableArray *arrObj;
@property (strong, nonatomic) NSDictionary *obj;
@property (strong, nonatomic) NSDictionary *objStamp;
@property (strong, nonatomic) NSDictionary *objStyle;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) IBOutlet UIView *waitView;
@property (retain, nonatomic) IBOutlet UIView *popupwaitView;

@property (strong, nonatomic) IBOutlet UIImageView *bg;

@property (weak, nonatomic) IBOutlet UIView *nomemberView;
@property (weak, nonatomic) IBOutlet UIView *memberView;
@property (weak, nonatomic) IBOutlet UIView *footernomemberView;

@property (weak, nonatomic) IBOutlet UIImageView *posternomember;
@property (weak, nonatomic) IBOutlet UIView *conditionnomemberView;
@property (weak, nonatomic) IBOutlet UILabel_UILabelDynamicHeight *conditionnomember;

- (IBAction)posternoTapped:(id)sender;
- (IBAction)signinTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *signinButton;

@property (weak, nonatomic) IBOutlet UIImageView *postermember;
@property (strong, nonatomic) IBOutlet UILabel *showpoint;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

- (IBAction)posterTapped:(id)sender;
- (IBAction)addPointTapped:(id)sender;

@property (strong, nonatomic) NSString *stampurl;

@property (strong, nonatomic) IBOutlet UIImageView *stamp1;
@property (strong, nonatomic) IBOutlet UIImageView *stamp2;
@property (strong, nonatomic) IBOutlet UIImageView *stamp3;
@property (strong, nonatomic) IBOutlet UIImageView *stamp4;
@property (strong, nonatomic) IBOutlet UIImageView *stamp5;
@property (strong, nonatomic) IBOutlet UIImageView *stamp6;
@property (strong, nonatomic) IBOutlet UIImageView *stamp7;
@property (strong, nonatomic) IBOutlet UIImageView *stamp8;
@property (strong, nonatomic) IBOutlet UIImageView *stamp9;
@property (strong, nonatomic) IBOutlet UIImageView *stamp10;

@property (strong, nonatomic) IBOutlet UIImageView *light1;
@property (strong, nonatomic) IBOutlet UIImageView *light2;
@property (strong, nonatomic) IBOutlet UIImageView *light3;
@property (strong, nonatomic) IBOutlet UIImageView *light4;
@property (strong, nonatomic) IBOutlet UIImageView *light5;
@property (strong, nonatomic) IBOutlet UIImageView *light6;
@property (strong, nonatomic) IBOutlet UIImageView *light7;
@property (strong, nonatomic) IBOutlet UIImageView *light8;
@property (strong, nonatomic) IBOutlet UIImageView *light9;
@property (strong, nonatomic) IBOutlet UIImageView *light10;

@property (strong, nonatomic) IBOutlet UILabel *num1;
@property (strong, nonatomic) IBOutlet UILabel *num2;
@property (strong, nonatomic) IBOutlet UILabel *num3;
@property (strong, nonatomic) IBOutlet UILabel *num4;
@property (strong, nonatomic) IBOutlet UILabel *num5;
@property (strong, nonatomic) IBOutlet UILabel *num6;
@property (strong, nonatomic) IBOutlet UILabel *num7;
@property (strong, nonatomic) IBOutlet UILabel *num8;
@property (strong, nonatomic) IBOutlet UILabel *num9;
@property (strong, nonatomic) IBOutlet UILabel *num10;

- (IBAction)bgTapped:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *addPointView;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *removeAmountButton;
@property (strong, nonatomic) IBOutlet UIButton *addAmountButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *confirmButton;

- (IBAction)removeAmountTapped:(id)sender;
- (IBAction)addAmountTapped:(id)sender;
- (IBAction)cancelTapped:(id)sender;
- (IBAction)confirmTapped:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *amountFinishView;
@property (strong, nonatomic) IBOutlet UILabel *finishamount;
@property (strong, nonatomic) IBOutlet UIButton *amountFinishButton;

- (IBAction)amountFinishOkTapped:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *amountFailView;

- (IBAction)FailTapped:(id)sender;

@end
