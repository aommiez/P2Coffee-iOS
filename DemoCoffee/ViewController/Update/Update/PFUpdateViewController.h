//
//  PFUpdateViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/16/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFUpdateCell.h"

#import "PFAccountViewController.h"
#import "PFNotificationViewController.h"

@protocol PFUpdateViewControllerDelegate <NSObject>

- (void)HideTabbar;
- (void)ShowTabbar;

@end

@interface PFUpdateViewController : UIViewController

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) IBOutlet UINavigationController *navController;
@property (weak, nonatomic  ) IBOutlet UINavigationItem *navItem;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
