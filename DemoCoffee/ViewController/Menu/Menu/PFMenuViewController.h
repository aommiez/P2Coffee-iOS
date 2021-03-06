//
//  PFMenuViewController.h
//  MingMitr
//
//  Created by Pariwat on 6/11/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIERealTimeBlurView.h"
#import "AMBlurView.h"

#import "PFMenuCell.h"
#import "PFDetailCell.h"
#import "PFFranchiseCell.h"
#import "PFF1ViewController.h"
#import "PFD1ViewController.h"

#import "DCManager.h"

@protocol PFMenuViewControllerDelegate <NSObject>

- (void)PFImageViewController:(id)sender viewPicture:(NSString *)link;
- (void)PFGalleryViewController:(id)sender sum:(NSMutableArray *)sum current:(NSString *)current;
- (void)HideTabbar;
- (void)ShowTabbar;

@end

@interface PFMenuViewController : UIViewController <UINavigationControllerDelegate>

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) DCManager *Demoapi;
@property (strong, nonatomic) NSMutableArray *arrObj;
@property (strong, nonatomic) NSDictionary *obj;

@property (strong, nonatomic) IBOutlet UINavigationController *navController;
@property (strong, nonatomic  ) IBOutlet UINavigationItem *navItem;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *waitView;
@property (strong, nonatomic) IBOutlet UIView *popupwaitView;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmented;

@property (strong, nonatomic) NSString *paging;

@end
