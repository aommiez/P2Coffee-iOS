//
//  PFTutorialViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 7/4/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFTutorialViewController.h"

@interface PFTutorialViewController ()

@end

@implementation PFTutorialViewController

NSString *removeBreckets;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    removeBreckets = [[NSString alloc] init];
    removeBreckets = @"0";
    
    [self.nexttutorialButton setTitle:@"Next" forState:UIControlStateNormal];
    [self.nexttutorialButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.nexttutorialButton setBackgroundColor:[UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:242.0/255.0 alpha:1.0]];
    
    CALayer *nexttutorialButton = [self.nexttutorialButton layer];
    [nexttutorialButton setMasksToBounds:YES];
    [nexttutorialButton setCornerRadius:5.0f];
    
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    
    self.testcode.text = [self.Demoapi getAppKey];
    
    self.tutorialScrollView.delegate = self;
    
    self.tutorialScrollView.contentSize = CGSizeMake(self.tutorialDetailView.frame.size.width,self.tutorialDetailView.frame.size.height);
    [self.tutorialScrollView addSubview:self.tutorialDetailView];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (IBAction)appstoreTutorial:(id)sender {
    [self.Demoapi appinfo];
}

- (void)DCManager:(id)sender appinfoResponse:(NSDictionary *)response {
    NSLog(@"appinfo %@",response);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[response objectForKey:@"admin_ios_store"]]];
}

- (void)DCManager:(id)sender appinfoErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (IBAction)linkTutorial:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://app.pla2.com/"]];
}

- (IBAction)testcodeTextTutorial:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Test Code" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeNumberPad;
    alertTextField.placeholder = @"Test code";
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]) {
        UITextField *appkey = [alertView textFieldAtIndex:0];
        if (![appkey.text length]==0) {
            [self.Demoapi saveAppKey:appkey.text];
            [self viewDidLoad];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"DemoCoffee"
                                        message:@"Please fill Test code."
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    }
}

- (IBAction)newtestcodeTutorial:(id)sender {
    [self.Demoapi appRequest];
}

- (void)DCManager:(id)sender appRequestResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
    NSString *app_key = [[NSString alloc] initWithFormat:@"%@",[response objectForKey:@"app_key"]];
    self.testcode.text = app_key;
    [self.Demoapi saveAppKey:app_key];
}

- (void)DCManager:(id)sender appRequestErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

#pragma scrollviewdelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"1");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSString *contentOffSet = [NSString stringWithFormat:@"%@", NSStringFromCGPoint(self.tutorialScrollView.contentOffset)];
    removeBreckets = [contentOffSet stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"{ ,0}"]];
    
    if ([removeBreckets intValue] <= 0) {
        self.pageControl.currentPage = 0;
        [self.nexttutorialButton setTitle:@"Next" forState:UIControlStateNormal];
        [self.nexttutorialButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.nexttutorialButton setBackgroundColor:[UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:242.0/255.0 alpha:1.0]];
        
    }
    if ([removeBreckets intValue] == 32) {
        self.pageControl.currentPage = 1;
        [self.nexttutorialButton setTitle:@"Next" forState:UIControlStateNormal];
        [self.nexttutorialButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.nexttutorialButton setBackgroundColor:[UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:242.0/255.0 alpha:1.0]];
        
    }
    if ([removeBreckets intValue] == 64) {
        self.pageControl.currentPage = 2;
        [self.nexttutorialButton setTitle:@"Next" forState:UIControlStateNormal];
        [self.nexttutorialButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.nexttutorialButton setBackgroundColor:[UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:242.0/255.0 alpha:1.0]];
        
    }
    if ([removeBreckets intValue] == 96) {
        self.pageControl.currentPage = 3;
        [self.nexttutorialButton setTitle:@"Done" forState:UIControlStateNormal];
        [self.nexttutorialButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.nexttutorialButton setBackgroundColor:[UIColor colorWithRed:37.0/255.0 green:107.0/255.0 blue:176.0/255.0 alpha:1.0]];
        
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

- (IBAction)nexttutorialTapped:(id)sender {
    
    if ([removeBreckets intValue] <= 0) {
        [self.tutorialScrollView setContentOffset:CGPointMake(320,0) animated:YES];
        self.pageControl.currentPage = 1;
        removeBreckets = @"32";
        
    } else if ([removeBreckets intValue] == 32) {
        [self.tutorialScrollView setContentOffset:CGPointMake(640,0) animated:YES];
        self.pageControl.currentPage = 2;
        removeBreckets = @"64";
        
    } else if ([removeBreckets intValue] == 64) {
        [self.tutorialScrollView setContentOffset:CGPointMake(960,0) animated:YES];
        self.pageControl.currentPage = 3;
        removeBreckets = @"96";
        [self.nexttutorialButton setTitle:@"Done" forState:UIControlStateNormal];
        [self.nexttutorialButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.nexttutorialButton setBackgroundColor:[UIColor colorWithRed:37.0/255.0 green:107.0/255.0 blue:176.0/255.0 alpha:1.0]];
        
    } else if ([removeBreckets intValue] == 96) {
        [self.tutorialScrollView setContentOffset:CGPointMake(0,0) animated:YES];
        self.pageControl.currentPage = 0;
        [self.view removeFromSuperview];
        [self.Demoapi saveAppKey:self.testcode.text];
        [self.Demoapi saveAppKeyCheck:@"123"];
        [self.delegate PFTutorialViewController:self];
    }
}

@end
