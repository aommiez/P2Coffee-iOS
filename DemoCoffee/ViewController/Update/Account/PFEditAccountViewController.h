//
//  PFEditAccountViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/20/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "SDImageCache.h"
#import "DCManager.h"

@protocol PFEditAccountViewControllerDelegate <NSObject>

- (void)PFEditAccountViewControllerBack;

@end

@interface PFEditAccountViewController : UIViewController <UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) DCManager *Demoapi;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *formView;

@property (strong, nonatomic) NSDictionary *objAccount;
@property (strong, nonatomic) NSDictionary *objUsersetting;

@property (strong, nonatomic) IBOutlet UIView *imgView;
@property (strong, nonatomic) IBOutlet UIView *passwordView;
@property (strong, nonatomic) IBOutlet UIView *changepasswordView;

@property (strong, nonatomic) IBOutlet UIView *blurView;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (weak, nonatomic) IBOutlet UITextField *display_name;

@property (weak, nonatomic) IBOutlet AsyncImageView *thumUser;

@property (weak, nonatomic) IBOutlet UITextField *facebook;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *website;
@property (weak, nonatomic) IBOutlet UITextField *tel;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextField *birthday;

@property (weak, nonatomic) IBOutlet UIButton *facebook_bt;
@property (weak, nonatomic) IBOutlet UIButton *email_bt;
@property (weak, nonatomic) IBOutlet UIButton *website_bt;
@property (weak, nonatomic) IBOutlet UIButton *tel_bt;
@property (weak, nonatomic) IBOutlet UIButton *gender_bt;
@property (weak, nonatomic) IBOutlet UIButton *birthday_bt;

@property (strong, nonatomic) NSString *facebookSetting;
@property (strong, nonatomic) NSString *emailSetting;
@property (strong, nonatomic) NSString *websiteSetting;
@property (strong, nonatomic) NSString *telSetting;
@property (strong, nonatomic) NSString *genderSetting;
@property (strong, nonatomic) NSString *birthdaySetting;

- (IBAction)selectgenderTapped:(id)sender;

- (IBAction)uploadPictureTapped:(id)sender;

- (IBAction)bgTapped:(id)sender;
- (IBAction)changepasswordTapped:(id)sender;

- (IBAction)facebookTapped:(id)sender;
- (IBAction)emailTapped:(id)sender;
- (IBAction)websiteTapped:(id)sender;
- (IBAction)telTapped:(id)sender;
- (IBAction)genderTapped:(id)sender;
- (IBAction)birthdayTapped:(id)sender;

- (IBAction)saveTapped:(id)sender;

@end
