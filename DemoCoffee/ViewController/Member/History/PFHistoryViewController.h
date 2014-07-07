//
//  PFHistoryViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/17/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+UILabelDynamicHeight.h"

#import "PFHistoryCell.h"

#import "DCManager.h"

@protocol PFHistoryViewControllerDelegate <NSObject>

- (void) PFHistoryViewControllerBack;

@end

@interface PFHistoryViewController : UIViewController

@property (strong, nonatomic) DCManager *Demoapi;
@property (assign, nonatomic) id <PFHistoryViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *historyView;

@property (strong, nonatomic) NSMutableArray *arrObj;

@property (strong, nonatomic) NSString *detailhistory;

@property (strong, nonatomic) IBOutlet UILabel_UILabelDynamicHeight *conditionnomember;


@end
