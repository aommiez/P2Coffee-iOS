//
//  PFAccountViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/20/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "AsyncImageView.h"

#import "DCManager.h"

#import "PFAccountCell.h"
#import "PFProfileViewController.h"

@protocol PFAccountViewControllerDelegate <NSObject>

- (void)PFAccountViewController:(id)sender viewPicture:(NSString *)link;
- (void)PFAccountViewControllerBack;
- (void)Tutorial;

@end

@interface PFAccountViewController : UIViewController

@property (strong, nonatomic) DCManager *Demoapi;
@property (assign, nonatomic) id <PFAccountViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (strong, nonatomic) NSDictionary *obj;
@property (strong, nonatomic) NSDictionary *objUsersetting;

@property (strong, nonatomic) NSString *rowCount;

@property (retain, nonatomic) IBOutlet UIView *waitView;
@property (retain, nonatomic) IBOutlet UIView *popupwaitView;

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *tutorialButton;

@property (strong, nonatomic) IBOutlet UIView *settingView;

@property (weak, nonatomic) IBOutlet UITextField *display_name;

@property (weak, nonatomic) IBOutlet AsyncImageView *thumUser;

- (IBAction)editProfile:(id)sender;

- (IBAction)switchNewsonoff:(id)sender;
- (IBAction)switchMessageonoff:(id)sender;

@property (strong, nonatomic) IBOutlet UISwitch *switchNews;
@property (strong, nonatomic) IBOutlet UISwitch *switchMessage;

- (IBAction)fullimgTapped:(id)sender;
- (IBAction)logoutTapped:(id)sender;
- (IBAction)tutorialTapped:(id)sender;

@end
