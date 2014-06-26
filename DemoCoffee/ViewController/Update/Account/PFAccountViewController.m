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
    
    self.navigationItem.title = @"Profile Setting";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleDone target:self action:@selector(editProfileTapped)];
    [rightButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont fontWithName:@"Helvetica" size:17.0],NSFontAttributeName,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.scrollView.contentSize = CGSizeMake(self.formView.frame.size.width, self.formView.frame.size.height+20);
    self.formView.frame = CGRectMake(10, 10, self.formView.frame.size.width,self.formView.frame.size.height);
    [self.scrollView addSubview:self.formView];
    
    CALayer *facebookView = [self.facebookView layer];
    [facebookView setMasksToBounds:YES];
    [facebookView setCornerRadius:5.0f];
    
    CALayer *emailView = [self.emailView layer];
    [emailView setMasksToBounds:YES];
    [emailView setCornerRadius:5.0f];
    
    CALayer *websiteView = [self.websiteView layer];
    [websiteView setMasksToBounds:YES];
    [websiteView setCornerRadius:5.0f];
    
    CALayer *phoneView = [self.phoneView layer];
    [phoneView setMasksToBounds:YES];
    [phoneView setCornerRadius:5.0f];
    
    CALayer *genderView = [self.genderView layer];
    [genderView setMasksToBounds:YES];
    [genderView setCornerRadius:5.0f];
    
    CALayer *birthdayView = [self.birthdayView layer];
    [birthdayView setMasksToBounds:YES];
    [birthdayView setCornerRadius:5.0f];
    
    CALayer *logoutButton = [self.logoutButton layer];
    [logoutButton setMasksToBounds:YES];
    [logoutButton setCornerRadius:5.0f];
    
    CALayer *settingView = [self.settingView layer];
    [settingView setMasksToBounds:YES];
    [settingView setCornerRadius:5.0f];
    
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    [self.Demoapi me];
    [self.Demoapi getUserSetting];
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
    
    self.facebook.text = [response objectForKey:@"display_name"];
    self.email.text = [response objectForKey:@"email"];
    self.website.text = [response objectForKey:@"website"];
    self.tel.text = [response objectForKey:@"mobile_phone"];
    self.gender.text = [response objectForKey:@"gender"];
    self.birthday.text = [[response objectForKey:@"birth_date"] objectForKey:@"date"];
    
}

- (void)DCManager:(id)sender meErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void)DCManager:(id)sender getUserSettingResponse:(NSDictionary *)response {
    NSLog(@"getUserSetting %@",response);
    
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

- (void)editProfileTapped {
    PFEditAccountViewController *editView = [[PFEditAccountViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        editView = [[PFEditAccountViewController alloc] initWithNibName:@"PFEditAccountViewController_Wide" bundle:nil];
    } else {
        editView = [[PFEditAccountViewController alloc] initWithNibName:@"PFEditAccountViewController" bundle:nil];
    }
    
    editView.delegate = self;
    editView.objAccount = self.obj;
    [self.navigationController pushViewController:editView animated:YES];
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
