//
//  PFAppDelegate.m
//  P2Coffee
//
//  Created by MRG on 6/10/2557 BE.
//  Copyright (c) 2557 Platwo fusion. All rights reserved.
//

#import "PFAppDelegate.h"

@implementation PFAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.update = [[PFUpdateViewController alloc] init];
    self.menu = [[PFMenuViewController alloc] init];
    self.member = [[PFMemberViewController alloc] init];
    self.contact = [[PFContactViewController alloc] init];
    
    if (IS_WIDESCREEN) {
        self.update = [[PFUpdateViewController alloc] initWithNibName:@"PFUpdateViewController_Wide" bundle:nil];
        self.menu = [[PFMenuViewController alloc] initWithNibName:@"PFMenuViewController_Wide" bundle:nil];
        self.member = [[PFMemberViewController alloc] initWithNibName:@"PFMemberViewController_Wide" bundle:nil];
        self.contact = [[PFContactViewController alloc] initWithNibName:@"PFContactViewController_Wide" bundle:nil];
        
    } else {
        self.update = [[PFUpdateViewController alloc] initWithNibName:@"PFUpdateViewController" bundle:nil];
        self.menu = [[PFMenuViewController alloc] initWithNibName:@"PFMenuViewController" bundle:nil];
        self.member = [[PFMemberViewController alloc] initWithNibName:@"PFMemberViewController" bundle:nil];
        self.contact = [[PFContactViewController alloc] initWithNibName:@"PFContactViewController" bundle:nil];
        
    }
    
    self.tabBarViewController = [[PFTabBarViewController alloc] initWithBackgroundImage:nil viewControllers:self.update,self.menu,self.member,self.contact,nil];
    
//    self.update.delegate = self;
//    self.menu.delegate = self;
//    self.member.delegate = self;
    self.contact.delegate = self;
    
    if(IS_WIDESCREEN){
        
        PFTabBarItemButton *item0 = [self.tabBarViewController.itemButtons objectAtIndex:0];
        [item0 setHighlightedImage:[UIImage imageNamed:@"update_light"]];
        [item0 setStanbyImage:[UIImage imageNamed:@"update_standby"]];
        
        PFTabBarItemButton *item1 = [self.tabBarViewController.itemButtons objectAtIndex:1];
        [item1 setHighlightedImage:[UIImage imageNamed:@"menu_light"]];
        [item1 setStanbyImage:[UIImage imageNamed:@"menu_standby"]];
        
        PFTabBarItemButton *item2 = [self.tabBarViewController.itemButtons objectAtIndex:2];
        [item2 setHighlightedImage:[UIImage imageNamed:@"member_light"]];
        [item2 setStanbyImage:[UIImage imageNamed:@"member_standby"]];
        
        PFTabBarItemButton *item3 = [self.tabBarViewController.itemButtons objectAtIndex:3];
        [item3 setHighlightedImage:[UIImage imageNamed:@"contact_light"]];
        [item3 setStanbyImage:[UIImage imageNamed:@"contact_standby"]];
        
    }else{
        
        PFTabBarItemButton *item0 = [self.tabBarViewController.itemButtons objectAtIndex:0];
        [item0 setHighlightedImage:[UIImage imageNamed:@"update_light"]];
        [item0 setStanbyImage:[UIImage imageNamed:@"update_standby"]];
        
        PFTabBarItemButton *item1 = [self.tabBarViewController.itemButtons objectAtIndex:1];
        [item1 setHighlightedImage:[UIImage imageNamed:@"menu_light"]];
        [item1 setStanbyImage:[UIImage imageNamed:@"menu_standby"]];
        
        PFTabBarItemButton *item2 = [self.tabBarViewController.itemButtons objectAtIndex:2];
        [item2 setHighlightedImage:[UIImage imageNamed:@"member_light"]];
        [item2 setStanbyImage:[UIImage imageNamed:@"member_standby"]];
        
        PFTabBarItemButton *item3 = [self.tabBarViewController.itemButtons objectAtIndex:3];
        [item3 setHighlightedImage:[UIImage imageNamed:@"contact_light"]];
        [item3 setStanbyImage:[UIImage imageNamed:@"contact_standby"]];
        
    }
    [self.tabBarViewController setSelectedIndex:3];
    [self.tabBarViewController setSelectedIndex:2];
    [self.tabBarViewController setSelectedIndex:1];
    [self.tabBarViewController setSelectedIndex:0];
    [self.window setRootViewController:self.tabBarViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"P2Coffee" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"P2Coffee.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)HideTabbar {
    [self.tabBarViewController hideTabBarWithAnimation:YES];
}

- (void)ShowTabbar {
    [self.tabBarViewController showTabBarWithAnimation:YES];
}

@end
