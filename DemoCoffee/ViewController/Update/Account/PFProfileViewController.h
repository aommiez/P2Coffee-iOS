//
//  PFProfileViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/30/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFEditAccountViewController.h"

@interface PFProfileViewController : UIViewController

@property (strong, nonatomic) IBOutlet UINavigationController *navController;
@property (weak, nonatomic  ) IBOutlet UINavigationItem *navItem;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIButton *facebook_bt;
@property (weak, nonatomic) IBOutlet UIButton *email_bt;
@property (weak, nonatomic) IBOutlet UIButton *website_bt;
@property (weak, nonatomic) IBOutlet UIButton *tel_bt;
@property (weak, nonatomic) IBOutlet UIButton *gender_bt;
@property (weak, nonatomic) IBOutlet UIButton *birthday_bt;

- (IBAction)editTapped:(id)sender;

@end
