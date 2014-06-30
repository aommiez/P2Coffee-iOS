//
//  PFAccountViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/20/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFAccountViewController.h"

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
    
    CALayer *settingView = [self.settingView layer];
    [settingView setMasksToBounds:YES];
    [settingView setCornerRadius:5.0f];
    
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    
    self.obj = [[NSDictionary alloc] init];
   
    self.rowCount = [[NSString alloc] init];
    
    [self.Demoapi me];
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
    self.objUsersetting = response;
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
    
//    editView.delegate = self;
//    editView.objAccount = self.obj;
//    editView.objUsersetting = self.objUsersetting;
    [self presentModalViewController:profileView animated:YES];
}

- (IBAction)fullimgTapped:(id)sender {
    
    NSString *picStr = [[NSString alloc] initWithString:[[self.obj objectForKey:@"picture"] objectForKey:@"link"]];
    [self.delegate PFAccountViewController:self viewPicture:picStr];
    
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
    [self.tutorialScrollView addSubview:self.tutorialDetailView];
    self.tutorialScrollView.contentSize = CGSizeMake(self.tutorialDetailView.frame.size.width,self.tutorialDetailView.frame.size.height);
    [self.navigationController.view addSubview:self.tutorialMainView];
}
- (IBAction)closeTutorialView:(id)sender {
    [self.tutorialMainView removeFromSuperview];
}
- (void) PFEditAccountViewControllerBack {
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
