//
//  PFEditAccountViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/20/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "DCManager.h"

@protocol PFEditAccountViewControllerDelegate <NSObject>

- (void)PFEditAccountViewControllerBack;

@end

@interface PFEditAccountViewController : UIViewController

@property (assign, nonatomic) id delegate;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *formView;

@property (strong, nonatomic) NSDictionary *objAccount;

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

- (IBAction)fullimgTapped:(id)sender;
- (IBAction)bgTapped:(id)sender;
- (IBAction)changepasswordTapped:(id)sender;
- (IBAction)saveTapped:(id)sender;

@end
