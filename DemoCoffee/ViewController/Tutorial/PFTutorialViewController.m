//
//  PFTutorialViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/27/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFTutorialViewController.h"

@interface PFTutorialViewController ()

@end

@implementation PFTutorialViewController

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
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(IBAction)closeTapped:(id)sender{
    [self.view removeFromSuperview];
}

@end
