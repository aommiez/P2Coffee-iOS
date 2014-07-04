//
//  PFAccountViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/20/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFAccountViewController.h"

@interface PFAccountViewController () <UIScrollViewDelegate>

@end

@implementation PFAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.waitView];
    
    CALayer *popup = [self.popupwaitView layer];
    [popup setMasksToBounds:YES];
    [popup setCornerRadius:7.0f];
    
    self.navigationItem.title = @"Setting";
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    
    CALayer *tutorialButton = [self.tutorialButton layer];
    [tutorialButton setMasksToBounds:YES];
    [tutorialButton setCornerRadius:5.0f];
    
    CALayer *next1tutorialButton = [self.next1tutorialButton layer];
    [next1tutorialButton setMasksToBounds:YES];
    [next1tutorialButton setCornerRadius:5.0f];
    
    CALayer *next2tutorialButton = [self.next2tutorialButton layer];
    [next2tutorialButton setMasksToBounds:YES];
    [next2tutorialButton setCornerRadius:5.0f];
    
    CALayer *next3tutorialButton = [self.next3tutorialButton layer];
    [next3tutorialButton setMasksToBounds:YES];
    [next3tutorialButton setCornerRadius:5.0f];
    
    CALayer *donetutorialButton = [self.donetutorialButton layer];
    [donetutorialButton setMasksToBounds:YES];
    [donetutorialButton setCornerRadius:5.0f];
    
    CALayer *logoutButton = [self.logoutButton layer];
    [logoutButton setMasksToBounds:YES];
    [logoutButton setCornerRadius:5.0f];
    
    CALayer *settingView = [self.settingView layer];
    [settingView setMasksToBounds:YES];
    [settingView setCornerRadius:5.0f];
    
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    
    self.obj = [[NSDictionary alloc] init];
   
    self.rowCount = [[NSString alloc] init];
    
    [self.Demoapi me];
    
    self.appkey.text = [self.Demoapi getAppKey];
    self.testcode.text = [self.Demoapi getAppKey];
    
    self.tutorialScrollView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)DCManager:(id)sender meResponse:(NSDictionary *)response {
    self.obj = response;
    NSLog(@"Me %@",response);
    
    [self.waitView removeFromSuperview];
    
    self.display_name.text = [response objectForKey:@"display_name"];
    
    NSString *picStr = [[response objectForKey:@"picture"] objectForKey:@"link"];
    self.thumUser.layer.masksToBounds = YES;
    self.thumUser.contentMode = UIViewContentModeScaleAspectFill;
    self.thumUser.imageURL = [[NSURL alloc] initWithString:picStr];
    
    [self.Demoapi getUserSetting];
    
}

- (void)DCManager:(id)sender meErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void)DCManager:(id)sender getUserSettingResponse:(NSDictionary *)response {
    NSLog(@"getUserSetting %@",response);
    
    //switch
    
    if ([[response objectForKey:@"notify_news"] intValue] == 1) {
        self.switchNews.on = YES;
    } else {
        self.switchNews.on = NO;
    }
    
    if ([[response objectForKey:@"notify_message"] intValue] == 1) {
        self.switchMessage.on = YES;
    } else {
        self.switchMessage.on = NO;
    }
    
}

- (void)DCManager:(id)sender getUserSettingErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (IBAction)switchNewsonoff:(id)sender{
    
    if(self.switchNews.on) {
        NSLog(@"NewsOn");
        [self.Demoapi settingNews:@"1"];
    } else {
        NSLog(@"NewsOff");
        [self.Demoapi settingNews:@"0"];
    }
    
}

- (IBAction)switchMessageonoff:(id)sender{
    
    if(self.switchMessage.on) {
        NSLog(@"MessageOn");
        [self.Demoapi settingMessage:@"1"];
    } else {
        NSLog(@"MessageOff");
        [self.Demoapi settingMessage:@"0"];
    }
    
}

- (void)DCManager:(id)sender settingNewsResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
}

- (void)DCManager:(id)sender settingNewsErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (IBAction)editProfile:(id)sender {
    PFProfileViewController *profileView = [[PFProfileViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        profileView = [[PFProfileViewController alloc] initWithNibName:@"PFProfileViewController_Wide" bundle:nil];
    } else {
        profileView = [[PFProfileViewController alloc] initWithNibName:@"PFProfileViewController" bundle:nil];
    }
    
    profileView.delegate = self;
    profileView.objAccount = self.obj;
    [self.navigationController pushViewController:profileView animated:YES];
    //[self presentModalViewController:profileView animated:YES];
}

- (void)PFAccountViewController:(id)sender viewPicture:(NSString *)link{
    [self.delegate PFAccountViewController:self viewPicture:link];
}

- (IBAction)logoutTapped:(id)sender {
    [self.Demoapi removeAppKeyCheck];
    [FBSession.activeSession closeAndClearTokenInformation];
    [self.Demoapi logOut];
    [self.Demoapi removeAppKey];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)tutorialTapped:(id)sender {
    self.tutorialScrollView.contentSize = CGSizeMake(self.tutorialDetailView.frame.size.width,self.tutorialDetailView.frame.size.height);
    [self.tutorialScrollView addSubview:self.tutorialDetailView];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.tutorialMainView];
}

- (IBAction)closeTutorialView:(id)sender {
    [self.tutorialScrollView setContentOffset:CGPointMake(0,0) animated:YES];
    self.pageControl.currentPage = 0;
    [self.tutorialMainView removeFromSuperview];
    [self.Demoapi saveAppKey:self.testcode.text];
    [self viewDidLoad];
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

- (IBAction)appkeyTextTutorial:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Test Code" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeNumberPad;
    alertTextField.placeholder = @"Test code";
    [alertTextField setText:self.appkey.text];
    [alert show];
}

- (IBAction)testcodeTextTutorial:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Test Code" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeNumberPad;
    alertTextField.placeholder = @"Test code";
    [alertTextField setText:self.appkey.text];
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

- (IBAction)newappkeyTutorial:(id)sender {
    [self.Demoapi appRequest];
}

- (IBAction)newtestcodeTutorial:(id)sender {
    [self.Demoapi appRequest];
}

- (void)DCManager:(id)sender appRequestResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
    NSString *app_key = [[NSString alloc] initWithFormat:@"%@",[response objectForKey:@"app_key"]];
    self.testcode.text = app_key;
    self.appkey.text = app_key;
    [self.Demoapi saveAppKey:app_key];
}

- (void)DCManager:(id)sender appRequestErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void) PFProfileViewControllerBack {
    [self viewDidLoad];
}

#pragma scrollviewdelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"1");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSString *removeBreckets = [[NSString alloc] init];
    removeBreckets = @"0";
    
    NSString *contentOffSet = [NSString stringWithFormat:@"%@", NSStringFromCGPoint(self.tutorialScrollView.contentOffset)];
    removeBreckets = [contentOffSet stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"{ ,0}"]];
    
    if ([removeBreckets intValue] <= 0) {
        self.pageControl.currentPage = 0;
    }
    if ([removeBreckets intValue] == 32) {
        self.pageControl.currentPage = 1;
    }
    if ([removeBreckets intValue] == 64) {
        self.pageControl.currentPage = 2;
    }
    if ([removeBreckets intValue] == 96) {
        self.pageControl.currentPage = 3;
    }

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

}

- (IBAction)next1tutorialTapped:(id)sender {
    [self.tutorialScrollView setContentOffset:CGPointMake(320,0) animated:YES];
    self.pageControl.currentPage = 1;
}

- (IBAction)next2tutorialTapped:(id)sender {
    [self.tutorialScrollView setContentOffset:CGPointMake(640,0) animated:YES];
    self.pageControl.currentPage = 2;
}

- (IBAction)next3tutorialTapped:(id)sender {
    [self.tutorialScrollView setContentOffset:CGPointMake(960,0) animated:YES];
    self.pageControl.currentPage = 3;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // 'Back' button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        if([self.delegate respondsToSelector:@selector(PFAccountViewControllerBack)]){
            [self.delegate PFAccountViewControllerBack];
        }
    }
    
}

@end
