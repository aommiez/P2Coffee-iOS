//
//  PFEditAccountViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/20/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFEditAccountViewController : UIViewController

@property (assign, nonatomic) id delegate;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *formView;

@property (strong, nonatomic) IBOutlet UIView *imgView;
@property (strong, nonatomic) IBOutlet UIView *passwordView;
@property (strong, nonatomic) IBOutlet UIView *settingView;

@end
