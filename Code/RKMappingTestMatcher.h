//
//  RKMappingTestMatcher.h
//  RestKit
//
//  Created by Blake Watters on 9/29/12.
//  Copyright (c) 2009-2012 RestKit. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "RKMappingTest.h"
#import "Kiwi.h"

/**
 The `RKMappingTestMatcher` class is a Kiwi matcher for use with a `RKMappingTest` object. It provides support for verifying object mapping expectations within the Kiwi behavior driven development testing framework.
 
 ## Usage
 
    context(@"when object mapping a GGAirline", ^{
        beforeEach(^{
            fixtureData = [RKTestFixture parsedObjectWithContentsOfFixture:@"Fixtures/gateguruapp.com/airlines/1.json"];
            mappingTest = [RKMappingTest testForMapping:[mappings airlineResponseMapping] sourceObject:fixtureData destinationObject:nil];
            RKFetchRequestManagedObjectCache *cache = [RKFetchRequestManagedObjectCache new];
            mappingTest.mappingOperationDataSource = [[RKManagedObjectMappingOperationDataSource alloc] initWithManagedObjectContext:managedObjectStore.mainQueueManagedObjectContext cache:managedObjectCache];
            mappingTest.rootKeyPath = @"airline";
            mappingTest.verifiesOnExpect = YES;
        });
 
        specify(^{ [[mappingTest should] mapKeyPath:@"id" toKeyPath:@"airlineID" withValue:@1]; });
        specify(^{ [[mappingTest should] mapKeyPath:@"code" toKeyPath:@"code" withValue:@"0B"]; });
        specify(^{ [[mappingTest should] mapKeyPath:@"name" toKeyPath:@"name" withValue:@"Blue Air"]; });
        specify(^{ [[mappingTest should] mapKeyPath:@"favorite" toKeyPath:@"favorite" withValue:@NO]; });
    });
 
 */
@interface RKMappingTestMatcher : KWMatcher

///---------------------------
/// @name Configuring Matchers
///---------------------------

/**
 Sets an expectation that a given source key path will be mapped to a destination key path.
 
 @param sourceKeyPath The key path on the source object representation from which the mapped value is expected to be read.
 @param destinationKeyPath The key path on the destination object representation at which the mapped value is expected to be set.
 */
- (void)mapKeyPath:(NSString *)sourceKeyPath toKeyPath:(NSString *)destinationKeyPath;

/**
 Sets an expectation that a given source key path will be mapped to a destination key path with a given value.
 
 @param sourceKeyPath The key path on the source object representation from which the mapped value is expected to be read.
 @param destinationKeyPath The key path on the destination object representation at which the mapped value is expected to be set.
 @param expectedValue The value that is expected to be mapped.
 */
- (void)mapKeyPath:(NSString *)sourceKeyPath toKeyPath:(NSString *)destinationKeyPath withValue:(id)expectedValue;

/**
 Sets an expectation that a given source key path will be mapped to a destination key path using a a given mapping.
 
 @param sourceKeyPath The key path on the source object representation from which the mapped value is expected to be read.
 @param destinationKeyPath The key path on the destination object representation at which the mapped value is expected to be set.
 @param mapping The mapping object that is expected to be used.
 */
- (void)mapKeyPath:(NSString *)sourceKeyPath toKeyPath:(NSString *)destinationKeyPath usingMapping:(RKMapping *)mapping;

/**
 Sets an expectation that a given source key path will be mapped to a destination key path and that the mapping satisfies the expectations of the given block.
 
 @param sourceKeyPath The key path on the source object representation from which the mapped value is expected to be read.
 @param destinationKeyPath The key path on the destination object representation at which the mapped value is expected to be set.
 @param evaluationBlock A block that accepts the property mapping that was used to perform the mapping and the mapped value and returns a Boolean value indicating if the expectations of the block are satisfied by the mapping.
 */
- (void)mapKeyPath:(NSString *)sourceKeyPath
         toKeyPath:(NSString *)destinationKeyPath
       passingTest:(RKMappingTestExpectationEvaluationBlock)evaluationBlock;

/**
 Sets an expectation that an attribute will be mapped with a given value.
 
 @param attributeName The attribute expected to be mapped. The is the identical key path on the source and destination object representations.
 @param expectedValue The value that is expected to be mapped.
 */
- (void)mapAttribute:(NSString *)attributeName withValue:(id)expectedValue;

/**
 Sets an expectation that a relationship will be mapped with a given value.
 
 @param relationshipName The relationship expected to be mapped. The is the identical key path on the source and destination object representations.
 @param mapping The mapping object that is expected to be used.
 */
- (void)mapRelationship:(NSString *)relationshipName usingMapping:(RKMapping *)mapping;

#ifdef _COREDATADEFINES_H

/**
 Sets an expectation that the relationship with the given name will be connected to related entities using the specified connection attributes.
 
 @param relationshipName The name of the relationship to be connected.
 @param connectionAttributes The key path on the source object representation from which the mapped value is expected to be read.
 @param expectedValue The value of the destination key path for entities that are to be connected to object under test.
 */
- (void)connectRelationship:(NSString *)relationshipName
            usingAttributes:(NSDictionary *)connectionAttributes
                  withValue:(id)expectedValue;

#endif // _COREDATADEFINES_H

@end
