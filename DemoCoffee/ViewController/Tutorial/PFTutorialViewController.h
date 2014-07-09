//
//  PFTutorialViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 7/4/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DCManager.h"

@protocol PFTutorialViewControllerDelegate <NSObject>

- (void)PFTutorialViewController:(id)sender;

@end

@interface PFTutorialViewController : UIViewController

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) DCManager *Demoapi;

#pragma mark - tut

@property (strong, nonatomic) IBOutlet UIScrollView *tutorialScrollView;
@property (strong, nonatomic) IBOutlet UIView *tutorialDetailView;

@property (strong, nonatomic) IBOutlet UITextField *testcode;
@property (strong, nonatomic) IBOutlet UIButton *nexttutorialButton;

@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

- (IBAction)nexttutorialTapped:(id)sender;

- (IBAction)appstoreTutorial:(id)sender;
- (IBAction)testcodeTextTutorial:(id)sender;
- (IBAction)linkTutorial:(id)sender;
- (IBAction)newtestcodeTutorial:(id)sender;

@end
