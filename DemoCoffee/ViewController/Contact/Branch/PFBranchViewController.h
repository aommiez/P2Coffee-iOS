//
//  PFBranchViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/16/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLImageLoader.h"

#import "PFMapViewController.h"

@protocol PFBranchViewControllerDelegate <NSObject>

- (void)PFBranchViewControllerBack;

@end

@interface PFBranchViewController : UIViewController

@property (assign, nonatomic) id <PFBranchViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *branchView;

@property (strong, nonatomic) NSDictionary *obj;

@property (weak, nonatomic) IBOutlet UIImageView *mapImage;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lng;

- (IBAction)mapTapped:(id)sender;
- (IBAction)callTapped:(id)sender;

@end
