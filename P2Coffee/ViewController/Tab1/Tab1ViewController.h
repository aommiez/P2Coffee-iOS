//
//  Tab1ViewController.h
//  P2Coffee
//
//  Created by Pariwat on 6/9/14.
//  Copyright (c) 2014 pla2fusion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Tab1ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UINavigationController *navController;
@property (weak, nonatomic  ) IBOutlet UINavigationItem *navItem;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end
