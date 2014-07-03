//
//  PFAccountViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/20/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFAccountViewController.h"
#import "UIView+MTAnimation.h"

@interface PFAccountViewController ()

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
    
    [FBSession.activeSession closeAndClearTokenInformation];
    [self.Demoapi logOut];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)tutorialTapped:(id)sender {
    
//    self.tutorialView = [PFTutorialViewController alloc];
//    self.tutorialView.delegate = self;
//    [self.view addSubview:self.tutorialView.view];
    self.tutorialScrollView.contentSize = CGSizeMake(self.tutorialDetailView.frame.size.width,self.tutorialDetailView.frame.size.height);
    [self.tutorialScrollView addSubview:self.tutorialDetailView];
    
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.tutorialMainView];

}

- (IBAction)closeTutorialView:(id)sender {
    [self.tutorialMainView removeFromSuperview];
    [self.Demoapi saveAppKey:self.testcode.text];
    [self viewDidLoad];
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
        [self.Demoapi saveAppKey:appkey.text];
        [self viewDidLoad];
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
