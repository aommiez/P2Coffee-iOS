//
//  Tab2ViewController.h
//  P2Coffee
//
//  Created by Pariwat on 6/9/14.
//  Copyright (c) 2014 pla2fusion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Tab2ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UINavigationController *navController;
@property (weak, nonatomic  ) IBOutlet UINavigationItem *navItem;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
