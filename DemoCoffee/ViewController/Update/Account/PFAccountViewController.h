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

@interface PFAccountViewController : UIViewController < UITextViewDelegate >

@property (strong, nonatomic) DCManager *Demoapi;
@property (assign, nonatomic) id <PFAccountViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (strong, nonatomic) NSDictionary *obj;

@property (strong, nonatomic) NSString *rowCount;

@property (strong, nonatomic) IBOutlet UIView *waitView;
@property (strong, nonatomic) IBOutlet UIView *popupwaitView;

@property (strong, nonatomic) IBOutlet UIView *settingView;
@property (strong, nonatomic) IBOutlet AsyncImageView *thumUser;
@property (strong, nonatomic) IBOutlet UITextField *display_name;

@property (strong, nonatomic) IBOutlet UIButton *logoutButton;

- (IBAction)editProfile:(id)sender;

- (IBAction)switchNewsonoff:(id)sender;
- (IBAction)switchMessageonoff:(id)sender;

@property (strong, nonatomic) IBOutlet UISwitch *switchNews;
@property (strong, nonatomic) IBOutlet UISwitch *switchMessage;

- (IBAction)logoutTapped:(id)sender;

#pragma mark - tut

@property (strong, nonatomic) IBOutlet UIView *tutorialMainView;
@property (strong, nonatomic) IBOutlet UIScrollView *tutorialScrollView;
@property (strong, nonatomic) IBOutlet UIView *tutorialDetailView;

@property (strong, nonatomic) IBOutlet UITextField *testcode;
@property (strong, nonatomic) IBOutlet UITextField *appkey;
@property (strong, nonatomic) IBOutlet UIButton *tutorialButton;
@property (strong, nonatomic) IBOutlet UIButton *next1tutorialButton;
@property (strong, nonatomic) IBOutlet UIButton *next2tutorialButton;
@property (strong, nonatomic) IBOutlet UIButton *next3tutorialButton;
@property (strong, nonatomic) IBOutlet UIButton *donetutorialButton;

@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

- (IBAction)tutorialTapped:(id)sender;
- (IBAction)next1tutorialTapped:(id)sender;
- (IBAction)next2tutorialTapped:(id)sender;
- (IBAction)next3tutorialTapped:(id)sender;
- (IBAction)closeTutorialView:(id)sender;

- (IBAction)appkeyTextTutorial:(id)sender;
- (IBAction)testcodeTextTutorial:(id)sender;

- (IBAction)appstoreTutorial:(id)sender;
- (IBAction)linkTutorial:(id)sender;
- (IBAction)newappkeyTutorial:(id)sender;
- (IBAction)newtestcodeTutorial:(id)sender;

@end