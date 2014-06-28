//
//  PFTutorialViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/27/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PFTutorialViewControllerDelegate <NSObject>

@end

@interface PFTutorialViewController : UIViewController

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) NSArray *pageImages;

- (IBAction)closeTapped:(id)sender;

@end
