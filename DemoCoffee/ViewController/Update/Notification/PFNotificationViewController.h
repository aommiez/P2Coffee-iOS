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
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) DCManager *Demoapi;

@property (retain, nonatomic) NSArray *tableData;
@property (retain, nonatomic) NSDictionary *obj;
@property (retain, nonatomic) NSString *nString;
@property (retain, nonatomic) NSString *type;
@property (retain, nonatomic) IBOutlet AMBlurView *blurView;
@property (retain, nonatomic) IBOutlet UITextView *textView;

@end
