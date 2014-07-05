//
//  PFMemberViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/16/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFMemberViewController.h"

@interface PFMemberViewController ()

@end

@implementation PFMemberViewController

BOOL refreshDataMember;

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
    
    // Navbar setup
    [[self.navController navigationBar] setBarTintColor:[UIColor colorWithRed:247.0f/255.0f green:148.0f/255.0f blue:30.0f/255.0f alpha:1.0f]];
    
    [[self.navController navigationBar] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                 [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName, nil]];
    
    [[self.navController navigationBar] setTranslucent:YES];
    [self.view addSubview:self.navController.view];
    
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    
    CALayer *postermember = [self.postermember layer];
    [postermember setMasksToBounds:YES];
    [postermember setCornerRadius:7.0f];
    
    CALayer *posternomember = [self.posternomember layer];
    [posternomember setMasksToBounds:YES];
    [posternomember setCornerRadius:7.0f];
    
    CALayer *signinButton = [self.signinButton layer];
    [signinButton setMasksToBounds:YES];
    [signinButton setCornerRadius:7.0f];
    
    CALayer *addButton = [self.addButton layer];
    [addButton setMasksToBounds:YES];
    [addButton setCornerRadius:7.0f];
        
    [self.Demoapi getStampStyle];
    
    //login
    if ([self.Demoapi checkLogin] != false){
        
        self.obj = [[NSDictionary alloc] init];
        self.objStamp = [[NSDictionary alloc] init];
        self.objStyle = [[NSDictionary alloc] init];
        self.arrObj = [[NSMutableArray alloc] init];
        
        self.tableView.tableHeaderView = self.memberView;
        UIView *fv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 52)];
        self.tableView.tableFooterView = fv;
    }else{
        //no login
        self.tableView.tableHeaderView = self.nomemberView;
        self.tableView.tableFooterView = self.footernomemberView;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)DCManager:(id)sender getStampStyleResponse:(NSDictionary *)response {
    self.objStyle = response;
    NSLog(@"Member nomemberview %@",response);
    
    [self.waitView removeFromSuperview];
    
    //login
    if ([self.Demoapi checkLogin] != false){
    
        self.stampurl = [response objectForKey:@"stamp_icon"];
    
        [DLImageLoader loadImageFromURL:[response objectForKey:@"poster"]
                          completed:^(NSError *error, NSData *imgData) {
                              self.postermember.image = [UIImage imageWithData:imgData];
                          }];
        
        NSLog(@"%@",[response objectForKey:@"poster"]);
    
        NSString *urlbg = [NSString stringWithFormat:@"%@%@",[response objectForKey:@"background"],@"?blur=30"];
    
        [DLImageLoader loadImageFromURL:urlbg
                          completed:^(NSError *error, NSData *imgData) {
                              self.bg.image = [UIImage imageWithData:imgData];
                          }];
        self.bg.layer.masksToBounds = YES;
        self.bg.contentMode = UIViewContentModeScaleAspectFill;
    
        [self.Demoapi getStamp];
        [self.Demoapi getReward];
    } else {
    //no login
        
        [DLImageLoader loadImageFromURL:[response objectForKey:@"poster"]
                            completed:^(NSError *error, NSData *imgData) {
                                self.posternomember.image = [UIImage imageWithData:imgData];
                              }];
     
        NSLog(@"%@",[response objectForKey:@"poster"]);
        
        NSString *urlbg = [NSString stringWithFormat:@"%@%@",[response objectForKey:@"background"],@"?blur=30"];
     
        [DLImageLoader loadImageFromURL:urlbg
                          completed:^(NSError *error, NSData *imgData) {
                              self.bg.image = [UIImage imageWithData:imgData];
                          }];
        
        self.bg.layer.masksToBounds = YES;
        self.bg.contentMode = UIViewContentModeScaleAspectFill;
    
        self.conditionnomember.text = [[NSString alloc] initWithString:[response objectForKey:@"condition_info"]];

        CGRect frame = self.conditionnomember.frame;
        frame.size = [self.conditionnomember sizeOfMultiLineLabel];
        [self.conditionnomember sizeOfMultiLineLabel];
        [self.conditionnomember setFrame:frame];
        int lines = self.conditionnomember.frame.size.height/15;
        self.conditionnomember.numberOfLines = lines;
        UILabel *descText = [[UILabel alloc] initWithFrame:frame];
        descText.text = self.conditionnomember.text;
        descText.numberOfLines = lines;
        [descText setFont:[UIFont systemFontOfSize:15]];
        descText.textColor = [UIColor colorWithRed:104.0/255.0 green:71.0/255.0 blue:56.0/255.0 alpha:1.0];
        self.conditionnomember.alpha = 0;
        [self.conditionnomemberView addSubview:descText];
        self.conditionnomemberView.frame = CGRectMake(self.conditionnomemberView.frame.origin.x, self.conditionnomemberView.frame.origin.y, self.conditionnomemberView.frame.size.width, self.conditionnomemberView.frame.size.height+descText.frame.size.height-15);
    
        self.footernomemberView.frame = CGRectMake(self.footernomemberView.frame.origin.x, self.footernomemberView.frame.origin.y+descText.frame.size.height-25, self.footernomemberView.frame.size.width, self.footernomemberView.frame.size.height);
    }
    
}

- (void)DCManager:(id)sender getStampStyleErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void)DCManager:(id)sender getStampResponse:(NSDictionary *)response {
    self.objStamp = response;
    NSLog(@"Member nomemberview getStamp %@",response);
    
    self.showpoint.text = [[NSString alloc] initWithFormat:@"%@",[response objectForKey:@"point"]];
    
    //
    //stamp
    self.light1.hidden = YES;   self.light2.hidden = YES;
    self.light3.hidden = YES;   self.light4.hidden = YES;
    self.light5.hidden = YES;   self.light6.hidden = YES;
    self.light7.hidden = YES;   self.light8.hidden = YES;
    self.light9.hidden = YES;   self.light10.hidden = YES;
    
    self.num1.hidden = NO;      self.num2.hidden = NO;
    self.num3.hidden = NO;      self.num4.hidden = NO;
    self.num5.hidden = NO;      self.num6.hidden = NO;
    self.num7.hidden = NO;      self.num8.hidden = NO;
    self.num9.hidden = NO;      self.num10.hidden = NO;
    
    [UIView animateWithDuration:0.70f delay:0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        [self.light1 setAlpha:0.2]; [self.light1 setAlpha:1.5];
        [self.light2 setAlpha:0.2]; [self.light2 setAlpha:1.5];
        [self.light3 setAlpha:0.2]; [self.light3 setAlpha:1.5];
        [self.light4 setAlpha:0.2]; [self.light4 setAlpha:1.5];
        [self.light5 setAlpha:0.2]; [self.light5 setAlpha:1.5];
        [self.light6 setAlpha:0.2]; [self.light6 setAlpha:1.5];
        [self.light7 setAlpha:0.2]; [self.light7 setAlpha:1.5];
        [self.light8 setAlpha:0.2]; [self.light8 setAlpha:1.5];
        [self.light9 setAlpha:0.2]; [self.light9 setAlpha:1.5];
        [self.light10 setAlpha:0.2]; [self.light10 setAlpha:1.5];
    } completion:nil];
    
    //
    
    int pointValue = [self.showpoint.text intValue];
    int count = pointValue % 10;
    //if pointValue = ? --> point-count
    int mod = pointValue - count;
    
    int num1 = mod+1;   int num2 = mod+2;   int num3 = mod+3;   int num4 = mod+4;   int num5 = mod+5;
    int num6 = mod+6;   int num7 = mod+7;   int num8 = mod+8;   int num9 = mod+9;   int num10 = mod+10;
    
    self.num1.text = [NSString stringWithFormat:@"%d",num1];
    self.num2.text = [NSString stringWithFormat:@"%d",num2];
    self.num3.text = [NSString stringWithFormat:@"%d",num3];
    self.num4.text = [NSString stringWithFormat:@"%d",num4];
    self.num5.text = [NSString stringWithFormat:@"%d",num5];
    self.num6.text = [NSString stringWithFormat:@"%d",num6];
    self.num7.text = [NSString stringWithFormat:@"%d",num7];
    self.num8.text = [NSString stringWithFormat:@"%d",num8];
    self.num9.text = [NSString stringWithFormat:@"%d",num9];
    self.num10.text = [NSString stringWithFormat:@"%d",num10];
    
    if (pointValue != 0) {
        if (count == 1) {
            
            NSURL *url = [NSURL URLWithString:self.stampurl];
            NSData *data = [NSData dataWithContentsOfURL : url];
            
            self.stamp1.image = [UIImage imageWithData: data];
            self.stamp2.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp3.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp4.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp5.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp6.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp7.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp8.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp9.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp10.image = [UIImage imageNamed:@"button_point.png"];
            
            self.num1.hidden = YES;     self.light1.hidden = NO;
            
            NSString *newest = [response objectForKey:@"newest"];
            int count1 = [newest intValue];
            if (count1 == 0) {
                self.light1.hidden = YES;
            }
            
        } else if (count == 2) {
            
            NSURL *url = [NSURL URLWithString:self.stampurl];
            NSData *data = [NSData dataWithContentsOfURL : url];
            
            self.stamp1.image = [UIImage imageWithData: data];
            self.stamp2.image = [UIImage imageWithData: data];
            self.stamp3.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp4.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp5.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp6.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp7.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp8.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp9.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp10.image = [UIImage imageNamed:@"button_point.png"];
            
            self.num1.hidden = YES;     self.num2.hidden = YES;
            
            self.light1.hidden = NO;    self.light2.hidden = NO;
            
            NSString *newest = [response objectForKey:@"newest"];
            int count2 = [newest intValue];
            if (count2 == 0) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
            } else if (count2 == 1) {
                self.light1.hidden = YES;
            }
            
        } else if (count == 3) {
            
            NSURL *url = [NSURL URLWithString:self.stampurl];
            NSData *data = [NSData dataWithContentsOfURL : url];
            
            self.stamp1.image = [UIImage imageWithData: data];
            self.stamp2.image = [UIImage imageWithData: data];
            self.stamp3.image = [UIImage imageWithData: data];
            self.stamp4.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp5.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp6.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp7.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp8.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp9.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp10.image = [UIImage imageNamed:@"button_point.png"];
            
            self.num1.hidden = YES;     self.num2.hidden = YES;
            self.num3.hidden = YES;     self.light1.hidden = NO;
            self.light2.hidden = NO;    self.light3.hidden = NO;
            
            NSString *newest = [response objectForKey:@"newest"];
            int count3 = [newest intValue];
            if (count3 == 0) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;
            } else if (count3 == 1) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
            } else if (count3 == 2) {
                self.light1.hidden = YES;
            }
            
        } else if (count == 4) {
            
            NSURL *url = [NSURL URLWithString:self.stampurl];
            NSData *data = [NSData dataWithContentsOfURL : url];
            
            self.stamp1.image = [UIImage imageWithData: data];
            self.stamp2.image = [UIImage imageWithData: data];
            self.stamp3.image = [UIImage imageWithData: data];
            self.stamp4.image = [UIImage imageWithData: data];
            self.stamp5.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp6.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp7.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp8.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp9.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp10.image = [UIImage imageNamed:@"button_point.png"];
            
            self.num1.hidden = YES;     self.num2.hidden = YES;
            self.num3.hidden = YES;     self.num4.hidden = YES;
            
            self.light1.hidden = NO;    self.light2.hidden = NO;
            self.light3.hidden = NO;    self.light4.hidden = NO;
            
            NSString *newest = [response objectForKey:@"newest"];
            int count4 = [newest intValue];
            if (count4 == 0) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
            } else if (count4 == 1) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;
            } else if (count4 == 2) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
            } else if (count4 == 3) {
                self.light1.hidden = YES;
            }
            
        } else if (count == 5) {
            
            NSURL *url = [NSURL URLWithString:self.stampurl];
            NSData *data = [NSData dataWithContentsOfURL : url];
            
            self.stamp1.image = [UIImage imageWithData: data];
            self.stamp2.image = [UIImage imageWithData: data];
            self.stamp3.image = [UIImage imageWithData: data];
            self.stamp4.image = [UIImage imageWithData: data];
            self.stamp5.image = [UIImage imageWithData: data];
            self.stamp6.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp7.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp8.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp9.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp10.image = [UIImage imageNamed:@"button_point.png"];
            
            self.num1.hidden = YES;     self.num2.hidden = YES;
            self.num3.hidden = YES;     self.num4.hidden = YES;
            self.num5.hidden = YES;
            
            self.light1.hidden = NO;    self.light2.hidden = NO;
            self.light3.hidden = NO;    self.light4.hidden = NO;
            self.light5.hidden = NO;
            
            NSString *newest = [response objectForKey:@"newest"];
            int count5 = [newest intValue];
            if (count5 == 0) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
                self.light5.hidden = YES;
            } else if (count5 == 1) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
            } else if (count5 == 2) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;
            } else if (count5 == 3) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
            } else if (count5 == 4) {
                self.light1.hidden = YES;
            }
            
        } else if (count == 6) {
            
            NSURL *url = [NSURL URLWithString:self.stampurl];
            NSData *data = [NSData dataWithContentsOfURL : url];
            
            self.stamp1.image = [UIImage imageWithData: data];
            self.stamp2.image = [UIImage imageWithData: data];
            self.stamp3.image = [UIImage imageWithData: data];
            self.stamp4.image = [UIImage imageWithData: data];
            self.stamp5.image = [UIImage imageWithData: data];
            self.stamp6.image = [UIImage imageWithData: data];
            self.stamp7.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp8.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp9.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp10.image = [UIImage imageNamed:@"button_point.png"];
            
            self.num1.hidden = YES;     self.num2.hidden = YES;
            self.num3.hidden = YES;     self.num4.hidden = YES;
            self.num5.hidden = YES;     self.num6.hidden = YES;
            
            self.light1.hidden = NO;    self.light2.hidden = NO;
            self.light3.hidden = NO;    self.light4.hidden = NO;
            self.light5.hidden = NO;    self.light6.hidden = NO;
            
            NSString *newest = [response objectForKey:@"newest"];
            int count6 = [newest intValue];
            if (count6 == 0) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
                self.light5.hidden = YES;    self.light6.hidden = YES;
            } else if (count6 == 1) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
                self.light5.hidden = YES;
            } else if (count6 == 2) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
            } else if (count6 == 3) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;
            } else if (count6 == 4) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
            } else if (count6 == 5) {
                self.light1.hidden = YES;
            }
            
        } else if (count == 7) {
            
            NSURL *url = [NSURL URLWithString:self.stampurl];
            NSData *data = [NSData dataWithContentsOfURL : url];
            
            self.stamp1.image = [UIImage imageWithData: data];
            self.stamp2.image = [UIImage imageWithData: data];
            self.stamp3.image = [UIImage imageWithData: data];
            self.stamp4.image = [UIImage imageWithData: data];
            self.stamp5.image = [UIImage imageWithData: data];
            self.stamp6.image = [UIImage imageWithData: data];
            self.stamp7.image = [UIImage imageWithData: data];
            self.stamp8.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp9.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp10.image = [UIImage imageNamed:@"button_point.png"];
            
            self.num1.hidden = YES;   self.num2.hidden = YES;
            self.num3.hidden = YES;   self.num4.hidden = YES;
            self.num5.hidden = YES;   self.num6.hidden = YES;
            self.num7.hidden = YES;   self.light1.hidden = NO;
            
            self.light2.hidden = NO;    self.light3.hidden = NO;
            self.light4.hidden = NO;    self.light5.hidden = NO;
            self.light6.hidden = NO;    self.light7.hidden = NO;
            
            NSString *newest = [response objectForKey:@"newest"];
            int count7 = [newest intValue];
            if (count7 == 0) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
                self.light5.hidden = YES;    self.light6.hidden = YES;
                self.light7.hidden = YES;
            } else if (count7 == 1) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
                self.light5.hidden = YES;    self.light6.hidden = YES;
            } else if (count7 == 2) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
                self.light5.hidden = YES;
            } else if (count7 == 3) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
            } else if (count7 == 4) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;
            } else if (count7 == 5) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
            } else if (count7 == 6) {
                self.light1.hidden = YES;
            }
            
        } else if (count == 8) {
            
            NSURL *url = [NSURL URLWithString:self.stampurl];
            NSData *data = [NSData dataWithContentsOfURL : url];
            
            self.stamp1.image = [UIImage imageWithData: data];
            self.stamp2.image = [UIImage imageWithData: data];
            self.stamp3.image = [UIImage imageWithData: data];
            self.stamp4.image = [UIImage imageWithData: data];
            self.stamp5.image = [UIImage imageWithData: data];
            self.stamp6.image = [UIImage imageWithData: data];
            self.stamp7.image = [UIImage imageWithData: data];
            self.stamp8.image = [UIImage imageWithData: data];
            self.stamp9.image = [UIImage imageNamed:@"button_point.png"];
            self.stamp10.image = [UIImage imageNamed:@"button_point.png"];
            
            self.num1.hidden = YES;     self.num2.hidden = YES;
            self.num3.hidden = YES;     self.num4.hidden = YES;
            self.num5.hidden = YES;     self.num6.hidden = YES;
            self.num7.hidden = YES;     self.num8.hidden = YES;
            
            self.light1.hidden = NO;    self.light2.hidden = NO;
            self.light3.hidden = NO;    self.light4.hidden = NO;
            self.light5.hidden = NO;    self.light6.hidden = NO;
            self.light7.hidden = NO;    self.light8.hidden = NO;
            
            NSString *newest = [response objectForKey:@"newest"];
            int count8 = [newest intValue];
            if (count8 == 0) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
                self.light5.hidden = YES;    self.light6.hidden = YES;
                self.light7.hidden = YES;    self.light8.hidden = YES;
            } if (count8 == 1) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
                self.light5.hidden = YES;    self.light6.hidden = YES;
                self.light7.hidden = YES;
            } else if (count8 == 2) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
                self.light5.hidden = YES;    self.light6.hidden = YES;
            } else if (count8 == 3) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
                self.light5.hidden = YES;
            } else if (count8 == 4) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
            } else if (count8 == 5) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;
            } else if (count8 == 6) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
            } else if (count8 == 7) {
                self.light1.hidden = YES;
            }
            
        } else if (count == 9) {
            
            NSURL *url = [NSURL URLWithString:self.stampurl];
            NSData *data = [NSData dataWithContentsOfURL : url];
            
            self.stamp1.image = [UIImage imageWithData: data];
            self.stamp2.image = [UIImage imageWithData: data];
            self.stamp3.image = [UIImage imageWithData: data];
            self.stamp4.image = [UIImage imageWithData: data];
            self.stamp5.image = [UIImage imageWithData: data];
            self.stamp6.image = [UIImage imageWithData: data];
            self.stamp7.image = [UIImage imageWithData: data];
            self.stamp8.image = [UIImage imageWithData: data];
            self.stamp9.image = [UIImage imageWithData: data];
            self.stamp10.image = [UIImage imageNamed:@"button_point.png"];
            
            self.num1.hidden = YES;
            self.num2.hidden = YES;
            self.num3.hidden = YES;
            self.num4.hidden = YES;
            self.num5.hidden = YES;
            self.num6.hidden = YES;
            self.num7.hidden = YES;
            self.num8.hidden = YES;
            self.num9.hidden = YES;
            
            self.light1.hidden = NO;
            self.light2.hidden = NO;
            self.light3.hidden = NO;
            self.light4.hidden = NO;
            self.light5.hidden = NO;
            self.light6.hidden = NO;
            self.light7.hidden = NO;
            self.light8.hidden = NO;
            self.light9.hidden = NO;
            
            NSString *newest = [response objectForKey:@"newest"];
            int count9 = [newest intValue];
            if (count9 == 0) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
                self.light5.hidden = YES;    self.light6.hidden = YES;
                self.light7.hidden = YES;    self.light8.hidden = YES;
                self.light9.hidden = YES;
            } else if (count9 == 1) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
                self.light5.hidden = YES;    self.light6.hidden = YES;
                self.light7.hidden = YES;    self.light8.hidden = YES;
            } else if (count9 == 2) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
                self.light5.hidden = YES;    self.light6.hidden = YES;
                self.light7.hidden = YES;
            } else if (count9 == 3) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
                self.light5.hidden = YES;    self.light6.hidden = YES;
            } else if (count9 == 4) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
                self.light5.hidden = YES;
            } else if (count9 == 5) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;    self.light4.hidden = YES;
            } else if (count9 == 6) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
                self.light3.hidden = YES;
            } else if (count9 == 7) {
                self.light1.hidden = YES;    self.light2.hidden = YES;
            } else if (count9 == 8) {
                self.light1.hidden = YES;
            }
            
        } else if (count == 0) {
            
            NSURL *url = [NSURL URLWithString:self.stampurl];
            NSData *data = [NSData dataWithContentsOfURL : url];
            
            self.stamp1.image = [UIImage imageWithData: data];
            self.stamp2.image = [UIImage imageWithData: data];
            self.stamp3.image = [UIImage imageWithData: data];
            self.stamp4.image = [UIImage imageWithData: data];
            self.stamp5.image = [UIImage imageWithData: data];
            self.stamp6.image = [UIImage imageWithData: data];
            self.stamp7.image = [UIImage imageWithData: data];
            self.stamp8.image = [UIImage imageWithData: data];
            self.stamp9.image = [UIImage imageWithData: data];
            self.stamp10.image = [UIImage imageWithData: data];
            
            self.num1.hidden = YES;     self.num2.hidden = YES;
            self.num3.hidden = YES;     self.num4.hidden = YES;
            self.num5.hidden = YES;     self.num6.hidden = YES;
            self.num7.hidden = YES;     self.num8.hidden = YES;
            self.num9.hidden = YES;     self.num10.hidden = YES;
            
            self.light1.hidden = NO;    self.light2.hidden = NO;
            self.light3.hidden = NO;    self.light4.hidden = NO;
            self.light5.hidden = NO;    self.light6.hidden = NO;
            self.light7.hidden = NO;    self.light8.hidden = NO;
            self.light9.hidden = NO;    self.light10.hidden = NO;
            
            NSString *newest = [response objectForKey:@"newest"];
            int count10 = [newest intValue];
            if (count10 == 0) {
                _light1.hidden = YES;    _light2.hidden = YES;    _light3.hidden = YES;    _light4.hidden = YES;    _light5.hidden = YES;
                _light6.hidden = YES;    _light7.hidden = YES;    _light8.hidden = YES;    _light9.hidden = YES;    _light10.hidden = YES;
            } else if (count10 == 1) {
                _light1.hidden = YES;    _light2.hidden = YES;    _light3.hidden = YES;    _light4.hidden = YES;    _light5.hidden = YES;
                _light6.hidden = YES;    _light7.hidden = YES;    _light8.hidden = YES;    _light9.hidden = YES;
            } else if (count10 == 2) {
                _light1.hidden = YES;    _light2.hidden = YES;    _light3.hidden = YES;    _light4.hidden = YES;    _light5.hidden = YES;
                _light6.hidden = YES;    _light7.hidden = YES;    _light8.hidden = YES;
            } else if (count10 == 3) {
                _light1.hidden = YES;    _light2.hidden = YES;    _light3.hidden = YES;    _light4.hidden = YES;    _light5.hidden = YES;
                _light6.hidden = YES;    _light7.hidden = YES;
            } else if (count10 == 4) {
                _light1.hidden = YES;    _light2.hidden = YES;    _light3.hidden = YES;    _light4.hidden = YES;    _light5.hidden = YES;
                _light6.hidden = YES;
            } else if (count10 == 5) {
                _light1.hidden = YES;    _light2.hidden = YES;    _light3.hidden = YES;    _light3.hidden = YES;    _light5.hidden = YES;
            } else if (count10 == 6) {
                _light1.hidden = YES;    _light2.hidden = YES;    _light3.hidden = YES;    _light3.hidden = YES;
            } else if (count10 == 7) {
                _light1.hidden = YES;    _light2.hidden = YES;    _light3.hidden = YES;
            } else if (count10 == 8) {
                _light1.hidden = YES;    _light2.hidden = YES;
            } else if (count10 == 9) {
                _light1.hidden = YES;
            }
        }
        
    } else {
        self.stamp1.image = [UIImage imageNamed:@"button_point.png"];
        self.stamp2.image = [UIImage imageNamed:@"button_point.png"];
        self.stamp3.image = [UIImage imageNamed:@"button_point.png"];
        self.stamp4.image = [UIImage imageNamed:@"button_point.png"];
        self.stamp5.image = [UIImage imageNamed:@"button_point.png"];
        self.stamp6.image = [UIImage imageNamed:@"button_point.png"];
        self.stamp7.image = [UIImage imageNamed:@"button_point.png"];
        self.stamp8.image = [UIImage imageNamed:@"button_point.png"];
        self.stamp9.image = [UIImage imageNamed:@"button_point.png"];
        self.stamp10.image = [UIImage imageNamed:@"button_point.png"];
        
        self.num1.hidden = NO;      self.num2.hidden = NO;
        self.num3.hidden = NO;      self.num4.hidden = NO;
        self.num5.hidden = NO;      self.num6.hidden = NO;
        self.num7.hidden = NO;      self.num8.hidden = NO;
        self.num9.hidden = NO;      self.num10.hidden = NO;
        
        self.light1.hidden = YES;   self.light2.hidden = YES;
        self.light3.hidden = YES;   self.light4.hidden = YES;
        self.light5.hidden = YES;   self.light6.hidden = YES;
        self.light7.hidden = YES;   self.light8.hidden = YES;
        self.light9.hidden = YES;   self.light10.hidden = YES;
    }

    //
    
}

- (void)DCManager:(id)sender getStampErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void)DCManager:(id)sender getRewardResponse:(NSDictionary *)response {
    NSLog(@"Member memberview getReward %@",response);
    
    //login
    if (!refreshDataMember) {
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObj addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    } else {
        [self.arrObj removeAllObjects];
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObj addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    }
    
    [self reloadData:YES];
    
}

- (void)DCManager:(id)sender getRewardErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void)reloadData:(BOOL)animated
{
    [self.tableView reloadData];
    self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width,self.tableView.contentSize.height);
}

- (IBAction)posterTapped:(id)sender {
    
    [self.delegate HideTabbar];
    
    PFHistoryViewController *history = [[PFHistoryViewController alloc] init];
    
    if(IS_WIDESCREEN){
        history = [[PFHistoryViewController alloc] initWithNibName:@"PFHistoryViewController_Wide" bundle:nil];
    } else {
        history = [[PFHistoryViewController alloc] initWithNibName:@"PFHistoryViewController" bundle:nil];
    }
    history.delegate = self;
    history.detailhistory = [self.objStyle objectForKey:@"condition_info"];
    [self.navController pushViewController:history animated:YES];
}

- (IBAction)posternoTapped:(id)sender {
    
    [self.delegate HideTabbar];
    
    PFHistoryViewController *history = [[PFHistoryViewController alloc] init];
    
    if(IS_WIDESCREEN){
        history = [[PFHistoryViewController alloc] initWithNibName:@"PFHistoryViewController_Wide" bundle:nil];
    } else {
        history = [[PFHistoryViewController alloc] initWithNibName:@"PFHistoryViewController" bundle:nil];
    }
    history.delegate = self;
    history.detailhistory = [self.objStyle objectForKey:@"condition_info"];
    [self.navController pushViewController:history animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.Demoapi checkLogin] != false){
        return [self.arrObj count];
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFMemberCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFMemberCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CALayer *bgView = [cell.bgView layer];
    [bgView setMasksToBounds:YES];
    [bgView setCornerRadius:7.0f];
    
    CALayer *bgPoint = [cell.bgPoint layer];
    [bgPoint setMasksToBounds:YES];
    [bgPoint setCornerRadius:7.0f];
    
    NSString *img = [[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"picture"] objectForKey:@"link"];
    NSString *urlimg = [[NSString alloc] initWithFormat:@"%@%@",img,@"?width=100&height=100"];
    cell.image.imageURL = [[NSURL alloc] initWithString:urlimg];
    cell.name.text = [[NSString alloc] initWithString:[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"name"]];
    NSString *point = [[NSString alloc] initWithFormat:@"%@",[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"point"]];
    cell.point.text = point;
    
    if ([self.showpoint.text intValue] >= [cell.point.text intValue]) {
        cell.bgPoint.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:222.0/255.0 blue:23.0/255.0 alpha:1.0];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.Demoapi checkLogin] != false){
    
        if ([self.showpoint.text intValue] >= [[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"point"] intValue]) {
    
            [self.delegate HideTabbar];
    
            PFRewardViewController *reward = [[PFRewardViewController alloc] init];
    
            if(IS_WIDESCREEN){
                reward = [[PFRewardViewController alloc] initWithNibName:@"PFRewardViewController_Wide" bundle:nil];
            } else {
            reward = [[PFRewardViewController alloc] initWithNibName:@"PFRewardViewController" bundle:nil];
            }
            reward.delegate = self;
            reward.reward_id = [[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"id"];
            [self.navController pushViewController:reward animated:YES];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"DemoCoffee"
                                    message:@"แลกกาแฟนี้ไม่ได้ เนื่องจากสแตมป์ของคุณมีน้อยกว่าเงื่อนไข"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        }
    } else {
        self.loginView = [PFLoginViewController alloc];
        self.loginView.menu = @"member";
        self.loginView.delegate = self;
        [self.view addSubview:self.loginView.view];
    }

}

- (IBAction)signinTapped:(id)sender {
    self.loginView = [PFLoginViewController alloc];
    //self.loginView.menu = @"member";
    self.loginView.delegate = self;
    [self.view addSubview:self.loginView.view];
}

- (void)PFMemberViewController:(id)sender{
    [self.delegate ShowTabbar];
}

- (IBAction)addPointTapped:(id)sender {
    if ([self.Demoapi checkLogin] != false){
        
        [self.view addSubview:self.blurView];
        [self.addPointView.layer setCornerRadius:4.0f];
        [self.addPointView setBackgroundColor:RGB(248, 246, 244)];
        self.addPointView.frame = CGRectMake(35, 120, self.addPointView.frame.size.width, self.addPointView.frame.size.height);
        [self.view addSubview:self.addPointView];
    } else {
        self.loginView = [PFLoginViewController alloc];
        self.loginView.menu = @"member";
        self.loginView.delegate = self;
        [self.view addSubview:self.loginView.view];
    }
    
}

- (IBAction)removeAmountTapped:(id)sender {
    NSString *amount;
    int amountValue = [self.amountLabel.text intValue];
    if (amountValue>1) {
        int amountTotal = amountValue - 1;
        amount = [[NSString alloc] initWithFormat:@"%d",amountTotal];
        self.amountLabel.text = amount;
    } else  {
        amount = [[NSString alloc] initWithFormat:@"%d",amountValue];
        self.amountLabel.text = amount;
    }
}

- (IBAction)addAmountTapped:(id)sender {
    int amountValue = [self.amountLabel.text intValue];
    int amountTotal = amountValue + 1;
    NSString *amount = [[NSString alloc] initWithFormat:@"%d",amountTotal];
    self.amountLabel.text = amount;
}

- (IBAction)confirmTapped:(id)sender {
    [self.Demoapi addPoint:self.amountLabel.text password:self.password.text];
}

- (IBAction)cancelTapped:(id)sender {
    [self.addPointView removeFromSuperview];
    [self.blurView removeFromSuperview];
    
    self.amountLabel.text = @"1";
    self.password.text = @"";
    
}

- (IBAction)amountFinishOkTapped:(id)sender {
    [self.amountFinishView removeFromSuperview];
    [self.blurView removeFromSuperview];
    
    self.amountLabel.text = @"1";
    self.password.text = @"";
    [self viewDidLoad];
}

- (IBAction)FailTapped:(id)sender {
    [self.amountFailView removeFromSuperview];
    [self.blurView removeFromSuperview];
    
    self.amountLabel.text = @"1";
    self.password.text = @"";
    [self viewDidLoad];
}

- (void)DCManager:(id)sender addPointResponse:(NSDictionary *)response {
    self.obj = response;
    
    if ([[[response objectForKey:@"error"] objectForKey:@"type"] isEqualToString:@"Main\\CTL\\Exception\\InvalidPasswordException"]) {
        
        [self.addPointView removeFromSuperview];
        [self.amountFailView.layer setCornerRadius:4.0f];
        [self.amountFailView setBackgroundColor:RGB(248, 246, 244)];
        self.amountFailView.frame = CGRectMake(20, 180, self.amountFailView.frame.size.width, self.amountFailView.frame.size.height);
        [self.view addSubview:self.amountFailView];
        
    } else {
        
        NSString *show = [[NSString alloc] initWithFormat:@"Add %@ Stamp FINISH",self.amountLabel.text];
        [self.finishamount setText:show];
        
        [self.addPointView removeFromSuperview];
        [self.amountFinishView.layer setCornerRadius:4.0f];
        [self.amountFinishView setBackgroundColor:RGB(248, 246, 244)];
        self.amountFinishView.frame = CGRectMake(20, 120, self.amountFinishView.frame.size.width, self.amountFinishView.frame.size.height);
        [self.view addSubview:self.amountFinishView];
        
    }
}

- (void)DCManager:(id)sender addPointErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (IBAction)bgTapped:(id)sender {
    [self hideKeyboard];
}

- (void)hideKeyboard {
    [self.password resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField  {
    [self.password resignFirstResponder];
    return YES;
}

- (void) PFRewardViewControllerBack {
    [self viewDidLoad];
    [self.delegate ShowTabbar];
}

- (void) PFHistoryViewControllerBack {
    [self viewDidLoad];
    [self.delegate ShowTabbar];
}

@end
