//
//  PFLoginViewController.h
//  MingMitr
//
//  Created by Pariwat on 6/11/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIERealTimeBlurView.h"
#import "UIView+MTAnimation.h"
#import <QuartzCore/QuartzCore.h>
#import <FacebookSDK/FacebookSDK.h>

#import "DCManager.h"

@protocol PFLoginViewControllerDelegate <NSObject>

- (void)PFMemberViewController:(id)sender;
- (void)PFAccountViewController:(id)sender;
- (void)PFNotifyViewController:(id)sender;

@end

@interface PFLoginViewController : UIViewController <FBLoginViewDelegate,UITextFieldDelegate>

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) DCManager *Demoapi;
@property (strong, nonatomic) IBOutlet UIView *registerView;
@property (strong, nonatomic) IBOutlet UIView *blurView;
@property (strong, nonatomic) IBOutlet UIView *loginView;

@property (weak, nonatomic) IBOutlet UITextField *emailSignIn;
@property (weak, nonatomic) IBOutlet UITextField *passwordSignIn;

@property (weak, nonatomic) IBOutlet UIButton *signin_bt;
@property (weak, nonatomic) IBOutlet UIButton *signup_bt;
@property (weak, nonatomic) IBOutlet UIButton *create_bt;

- (IBAction)bgTapped:(id)sender;
- (IBAction)signinTapped:(id)sender;
- (IBAction)signupTapeed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *emailSignUp;
@property (weak, nonatomic) IBOutlet UITextField *passwordSignUp;
@property (weak, nonatomic) IBOutlet UITextField *confirmSignUp;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthSignUp;
@property (weak, nonatomic) IBOutlet UITextField *gender;

- (IBAction)dateBTapped:(id)sender;
- (IBAction)genderTapped:(id)sender;

- (IBAction)closedateTapped:(id)sender;
- (IBAction)closegenderTapped:(id)sender;

@property (retain, nonatomic) UIDatePicker *pick;
@property (retain, nonatomic) UIButton *pickDone;

- (IBAction)sumitTapped:(id)sender;

@property (strong, nonatomic) NSString *menu;

@end
