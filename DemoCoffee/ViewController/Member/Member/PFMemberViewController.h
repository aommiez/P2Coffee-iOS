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

@end
