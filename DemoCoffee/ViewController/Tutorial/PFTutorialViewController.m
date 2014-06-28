//
//  PFTutorialViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/27/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFTutorialViewController.h"
#import "PagedImageScrollView.h"

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
    
//    self.pageImages = @[@"01_vector_box.png", @"02_vector_box.png", @"03_vector_box.png", @"04_vector_box.png"];
//    
//    PagedImageScrollView *pageScrollView = [[PagedImageScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
//    pageScrollView.delegate = self;
//    [pageScrollView setScrollViewContents:self.pageImages];
//    pageScrollView.pageControlPos = PageControlPositionCenterBottom;
//    [self.view addSubview:pageScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
