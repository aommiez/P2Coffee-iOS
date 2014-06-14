//
//  PFAppDelegate.h
//  P2Coffee
//
//  Created by MRG on 6/10/2557 BE.
//  Copyright (c) 2557 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFTabBarViewController.h"

#import "Tab1ViewController.h"
#import "Tab2ViewController.h"
#import "Tab3ViewController.h"
#import "PFContactViewController.h"

@interface PFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PFTabBarViewController *tabBarViewController;

@property (strong, nonatomic) Tab1ViewController *tab1;
@property (strong, nonatomic) Tab2ViewController *tab2;
@property (strong, nonatomic) Tab3ViewController *tab3;
@property (strong, nonatomic) PFContactViewController *contact;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
