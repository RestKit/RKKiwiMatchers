//
//  RKTestFactory+GGEAdditions.m
//  RKKiwiExample
//
//  Created by Blake Watters on 3/27/13.
//  Copyright (c) 2013 RestKit. All rights reserved.
//

#import <RestKit/CoreData.h>
#import <RestKit/Testing.h>

@interface RKTestFactory (GGEAdditions)
@end

@implementation RKTestFactory (GGEAdditions)

/**
 Hook into initialization of the category. This occurs when the Test bundle is loaded.
 */
+ (void)load
{
    /**
     Configure RestKit to use the Unit Test bundle as the Fixture bundle. This bundle is the product built by the 'RKKiwiExampleTests' target. The identifier is configured via the 'Info' tab in the Target settings.
     */
    [RKTestFixture setFixtureBundle:[NSBundle bundleWithIdentifier:@"org.restkit.RKKiwiExampleTests"]];
    
    /**
     Configure a tear down step that deletes all entities from the database between tests. This helps ensure test isolation. An alternative approach is to tear down and recreate the Core Data stack between runs.
     
     This block is executed whenever `[RKTestFactory tearDown]` is invoked.
     */
    [self setTearDownBlock:^{
        RKManagedObjectStore *managedObjectStore = [RKManagedObjectStore defaultStore];
        if (managedObjectStore) {
            NSManagedObjectContext *managedObjectContext = managedObjectStore.persistentStoreManagedObjectContext;
            [managedObjectContext performBlockAndWait:^{
                NSError *error = nil;
                for (NSEntityDescription *entity in managedObjectStore.managedObjectModel) {
                    NSFetchRequest *fetchRequest = [NSFetchRequest new];
                    [fetchRequest setEntity:entity];
                    NSError *error = nil;
                    NSArray *objects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
                    for (NSManagedObject *object in objects) {
                        [managedObjectContext deleteObject:object];
                    }
                }
                [managedObjectContext save:&error];
                [managedObjectContext processPendingChanges];
            }];
        }
    }];
}

@end
