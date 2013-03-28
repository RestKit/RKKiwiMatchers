//
//  ContactSpec.m
//  RKKiwiExample
//
//  Created by Blake Watters on 3/27/13.
//  Copyright 2013 RestKit. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <RestKit/CoreData.h>
#import <RestKit/Testing.h>
#import <RKKiwiMatchers/RKKiwiMatchers.h>
#import "Contact.h"
#import "Tag.h"

SPEC_BEGIN(ContactSpec)

registerMatchers(@"RK");

context(@"when object mapping a Contact entity from a JSON file", ^{
    __block NSData *fixtureData;
    __block RKMappingTest *mappingTest;
    __block RKEntityMapping *entityMapping;
    __block RKEntityMapping *tagMapping;
    __block RKManagedObjectStore *managedObjectStore;
    
    beforeAll(^{
        managedObjectStore = [RKManagedObjectStore defaultStore]; // Configured by App Delegate        
        entityMapping = [RKEntityMapping mappingForEntityForName:@"Contact" inManagedObjectStore:managedObjectStore];
        [entityMapping addAttributeMappingsFromDictionary:@{
         @"first_name": @"firstName",
         @"last_name": @"lastName",
         @"email_address": @"emailAddress",
         @"created_at": @"creationDate",
         }];
        
        RKEntityMapping *tagMapping = [RKEntityMapping mappingForEntityForName:@"Tag" inManagedObjectStore:managedObjectStore];
        // Map each element in the array as a 'name'
        [tagMapping addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:nil toKeyPath:@"name"]];
        [entityMapping addRelationshipMappingWithSourceKeyPath:@"tags" mapping:tagMapping];
    });
    
    beforeEach(^{        
        fixtureData = [RKTestFixture parsedObjectWithContentsOfFixture:@"contact.json"];
        mappingTest = [RKMappingTest testForMapping:entityMapping sourceObject:fixtureData destinationObject:nil];
        RKFetchRequestManagedObjectCache *cache = [RKFetchRequestManagedObjectCache new];
        mappingTest.mappingOperationDataSource = [[RKManagedObjectMappingOperationDataSource alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext cache:cache];
    });
    
    // Attributes
    specify(^{ [[mappingTest should] mapKeyPath:@"first_name" toKeyPath:@"firstName" withValue:@"Blake"]; });
    specify(^{ [[mappingTest should] mapKeyPath:@"last_name" toKeyPath:@"lastName" withValue:@"Watters"]; });
    specify(^{ [[mappingTest should] mapKeyPath:@"email_address" toKeyPath:@"emailAddress" withValue:@"blake@restkit.org"]; });
    specify(^{ [[mappingTest should] mapKeyPath:@"created_at" toKeyPath:@"creationDate" withValue:RKDateFromString(@"2013-03-27T22:16:22-04:00")]; });
    
    // Relationships
    specify(^{ [[mappingTest should] mapKeyPath:@"tags" toKeyPath:@"tags" usingMapping:tagMapping]; });
    
});

SPEC_END
