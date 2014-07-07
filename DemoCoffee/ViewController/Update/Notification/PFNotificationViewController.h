//
//  PFNotificationViewController.h
//  DemoCoffee
//
//  Created by Pariwat on 6/17/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFNotificationCell.h"
#import "AMBlurView.h"

#import "DCManager.h"

@protocol PFNotificationViewControllerDelegate <NSObject>

- (void)PFNotificationViewControllerBack;

@end

@interface PFNotificationViewController : UIViewController

@property (assign, nonatomic) id <PFNotificationViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) DCManager *Demoapi;

@property (strong, nonatomic) NSArray *tableData;
@property (strong, nonatomic) NSDictionary *obj;
@property (strong, nonatomic) NSString *nString;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) IBOutlet AMBlurView *blurView;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end
