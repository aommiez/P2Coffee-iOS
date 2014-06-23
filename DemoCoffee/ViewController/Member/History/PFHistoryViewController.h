//
//  PFHistoryViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/17/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFHistoryCell.h"

@protocol PFHistoryViewControllerDelegate <NSObject>

- (void) PFHistoryViewControllerBack;

@end

@interface PFHistoryViewController : UIViewController

@property (assign, nonatomic) id <PFHistoryViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@end
