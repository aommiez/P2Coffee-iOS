//
//  PFProfileViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/30/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "SDImageCache.h"
#import "DCManager.h"

#import "PFEditViewController.h"

@protocol PFProfileViewControllerDelegate <NSObject>

- (void)PFAccountViewController:(id)sender viewPicture:(NSString *)link;
- (void)PFProfileViewControllerBack;

@end

@interface PFProfileViewController : UIViewController

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) DCManager *Demoapi;

@property (retain, nonatomic) IBOutlet UIView *waitView;
@property (retain, nonatomic) IBOutlet UIView *popupwaitView;

@property (strong, nonatomic) NSDictionary *objAccount;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UITextField *display_name;

@property (weak, nonatomic) IBOutlet AsyncImageView *thumUser;

@property (weak, nonatomic) IBOutlet UITextField *facebook;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *website;
@property (weak, nonatomic) IBOutlet UITextField *tel;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextField *birthday;

@property (strong, nonatomic) NSString *facebookSetting;
@property (strong, nonatomic) NSString *emailSetting;
@property (strong, nonatomic) NSString *websiteSetting;
@property (strong, nonatomic) NSString *telSetting;
@property (strong, nonatomic) NSString *genderSetting;
@property (strong, nonatomic) NSString *birthdaySetting;

@property (weak, nonatomic) IBOutlet UIButton *edit_bt;

@property (weak, nonatomic) IBOutlet UIButton *facebook_bt;
@property (weak, nonatomic) IBOutlet UIButton *email_bt;
@property (weak, nonatomic) IBOutlet UIButton *website_bt;
@property (weak, nonatomic) IBOutlet UIButton *tel_bt;
@property (weak, nonatomic) IBOutlet UIButton *gender_bt;
@property (weak, nonatomic) IBOutlet UIButton *birthday_bt;

- (IBAction)fullimgTapped:(id)sender;

- (IBAction)editTapped:(id)sender;

- (IBAction)facebookTapped:(id)sender;
- (IBAction)emailTapped:(id)sender;
- (IBAction)websiteTapped:(id)sender;
- (IBAction)telTapped:(id)sender;
- (IBAction)genderTapped:(id)sender;
- (IBAction)birthdayTapped:(id)sender;

@end
