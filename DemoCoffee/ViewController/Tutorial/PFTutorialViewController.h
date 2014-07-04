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

@property (weak, nonatomic) IBOutlet UITextField *testcode;
@property (weak, nonatomic) IBOutlet UIButton *next1tutorialButton;
@property (weak, nonatomic) IBOutlet UIButton *next2tutorialButton;
@property (weak, nonatomic) IBOutlet UIButton *next3tutorialButton;
@property (weak, nonatomic) IBOutlet UIButton *donetutorialButton;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

- (IBAction)next1tutorialTapped:(id)sender;
- (IBAction)next2tutorialTapped:(id)sender;
- (IBAction)next3tutorialTapped:(id)sender;
- (IBAction)closeTutorialView:(id)sender;

- (IBAction)appstoreTutorial:(id)sender;
- (IBAction)testcodeTextTutorial:(id)sender;
- (IBAction)linkTutorial:(id)sender;
- (IBAction)newtestcodeTutorial:(id)sender;

@end
