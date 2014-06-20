//
//  PFRewardViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/17/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PFRewardViewControllerDelegate <NSObject>

- (void) PFRewardViewControllerBack;

@end

@interface PFRewardViewController : UIViewController

@property (assign, nonatomic) id <PFRewardViewControllerDelegate> delegate;

@end
