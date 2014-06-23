//
//  PFAccountViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/20/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFEditAccountViewController.h"

@protocol PFAccountViewControllerDelegate <NSObject>

- (void)PFAccountViewControllerBack;

@end

@interface PFAccountViewController : UIViewController

@property (assign, nonatomic) id <PFAccountViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *formView;

@property (strong, nonatomic) IBOutlet UIView *facebookView;
@property (strong, nonatomic) IBOutlet UIView *emailView;
@property (strong, nonatomic) IBOutlet UIView *websiteView;
@property (strong, nonatomic) IBOutlet UIView *phoneView;
@property (strong, nonatomic) IBOutlet UIView *genderView;
@property (strong, nonatomic) IBOutlet UIView *birthdayView;

@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@property (strong, nonatomic) IBOutlet UIView *settingView;

- (IBAction)logoutTapped:(id)sender;

@end
