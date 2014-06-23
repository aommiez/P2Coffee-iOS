//
//  PFMemberViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/16/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFMemberCell.h"

#import "PFHistoryViewController.h"
#import "PFRewardViewController.h"

@protocol PFMemberViewControllerDelegate <NSObject>

- (void)HideTabbar;
- (void)ShowTabbar;

@end

@interface PFMemberViewController : UIViewController

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) IBOutlet UINavigationController *navController;
@property (weak, nonatomic  ) IBOutlet UINavigationItem *navItem;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *nomemberView;
@property (weak, nonatomic) IBOutlet UIView *memberView;

@property (weak, nonatomic) IBOutlet UIImageView *postermember;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

- (IBAction)posterTapped:(id)sender;
- (IBAction)addPointTapped:(id)sender;

@end
