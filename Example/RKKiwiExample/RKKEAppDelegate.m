//
//  RKKEAppDelegate.m
//  RKKiwiExample
//
//  Created by Blake Watters on 12/8/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import "RKKEAppDelegate.h"

@implementation RKKEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // Setup Core Data
    NSURL *modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"RKKiwiExample" ofType:@"momd"]];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    NSError *error = nil;
    BOOL success = [managedObjectStore addInMemoryPersistentStore:&error];
    NSAssert(success, @"Adding in memory store failed with error: %@", error);
    [managedObjectStore createManagedObjectContexts];
    [RKManagedObjectStore setDefaultStore:managedObjectStore];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

@end
