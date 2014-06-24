//
//  PFAppDelegate.h
//  DemoCoffee
//
//  Created by Pariwat on 6/17/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFTabBarViewController.h"

#import "PFUpdateViewController.h"
#import "PFMenuViewController.h"
#import "PFMemberViewController.h"
#import "PFContactViewController.h"

#import <MobileCoreServices/UTCoreTypes.h>
#import "SDImageCache.h"
#import "MWPhoto.h"
#import "MWPhotoBrowser.h"

@interface PFAppDelegate : UIResponder <UIApplicationDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MWPhotoBrowserDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PFTabBarViewController *tabBarViewController;

@property (strong, nonatomic) PFUpdateViewController *update;
@property (strong, nonatomic) PFMenuViewController *menu;
@property (strong, nonatomic) PFMemberViewController *member;
@property (strong, nonatomic) PFContactViewController *contact;

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
