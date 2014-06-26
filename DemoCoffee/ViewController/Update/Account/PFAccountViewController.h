//
//  PFAccountViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/20/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

#import "DCManager.h"

#import "PFEditAccountViewController.h"

@protocol PFAccountViewControllerDelegate <NSObject>

- (void)PFAccountViewController:(id)sender viewPicture:(NSString *)link;
- (void)PFAccountViewControllerBack;

@end

@interface PFAccountViewController : UIViewController

@property (strong, nonatomic) DCManager *Demoapi;
@property (assign, nonatomic) id <PFAccountViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *formView;

@property (strong, nonatomic) NSDictionary *obj;
@property (strong, nonatomic) NSDictionary *objUsersetting;

@property (retain, nonatomic) IBOutlet UIView *waitView;
@property (retain, nonatomic) IBOutlet UIView *popupwaitView;

@property (strong, nonatomic) IBOutlet UIView *facebookView;
@property (strong, nonatomic) IBOutlet UIView *emailView;
@property (strong, nonatomic) IBOutlet UIView *websiteView;
@property (strong, nonatomic) IBOutlet UIView *phoneView;
@property (strong, nonatomic) IBOutlet UIView *genderView;
@property (strong, nonatomic) IBOutlet UIView *birthdayView;

@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@property (strong, nonatomic) IBOutlet UIView *settingView;

@property (weak, nonatomic) IBOutlet UITextField *display_name;

@property (weak, nonatomic) IBOutlet AsyncImageView *thumUser;

@property (weak, nonatomic) IBOutlet UITextField *facebook;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *website;
@property (weak, nonatomic) IBOutlet UITextField *tel;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextField *birthday;

- (IBAction)switchNewsonoff:(id)sender;
- (IBAction)switchMessageonoff:(id)sender;

@property (strong, nonatomic) IBOutlet UISwitch *switchNews;
@property (strong, nonatomic) IBOutlet UISwitch *switchMessage;

- (IBAction)fullimgTapped:(id)sender;
- (IBAction)logoutTapped:(id)sender;

@end
