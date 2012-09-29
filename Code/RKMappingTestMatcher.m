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

#import "RKMappingTestMatcher.h"
#import "RKConnectionMapping.h"

@interface RKMappingTestMatcher ()
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) RKMappingTestExpectation *expectation;
@end

extern BOOL RKValueIsEqualToValue(id sourceValue, id destinationValue);

@implementation RKMappingTestMatcher

#pragma mark -
#pragma mark Getting Matcher Strings

+ (NSArray *)matcherStrings
{
    return [NSArray arrayWithObjects:
            @"mapKeyPath:toKeyPath:",
            @"mapKeyPath:toKeyPath:withValue:",
            @"mapKeyPath:toKeyPath:usingMapping:(RKMapping *)mapping",
            @"mapKeyPath:toKeyPath:passingEvaluationBlock:",
            @"mapAttribute:withValue:",
            @"mapRelationship:usingMapping:",
            @"connectRelationship:fromKeyPath:toKeyPath:withValue:",
            nil];
}

- (BOOL)evaluate
{
    NSError *localError = nil;
    BOOL success = [(RKMappingTest *)self.subject evaluateExpectation:self.expectation error:&localError];
    self.error = localError;
    return success;
}

- (NSString *)failureMessageForShould
{
    return [self.error localizedDescription];
}

- (void)mapKeyPath:(NSString *)sourceKeyPath toKeyPath:(NSString *)destinationKeyPath
{
    self.expectation = [RKMappingTestExpectation expectationWithSourceKeyPath:sourceKeyPath destinationKeyPath:destinationKeyPath];
}

- (void)mapKeyPath:(NSString *)sourceKeyPath toKeyPath:(NSString *)destinationKeyPath withValue:(id)value
{
    self.expectation = [RKMappingTestExpectation expectationWithSourceKeyPath:sourceKeyPath destinationKeyPath:destinationKeyPath value:value];
}

- (void)mapKeyPath:(NSString *)sourceKeyPath toKeyPath:(NSString *)destinationKeyPath usingMapping:(RKMapping *)mapping
{
    self.expectation = [RKMappingTestExpectation expectationWithSourceKeyPath:sourceKeyPath destinationKeyPath:destinationKeyPath mapping:mapping];
}

- (void)mapKeyPath:(NSString *)sourceKeyPath toKeyPath:(NSString *)destinationKeyPath passingTest:(RKMappingTestExpectationEvaluationBlock)evaluationBlock
{
    self.expectation = [RKMappingTestExpectation expectationWithSourceKeyPath:sourceKeyPath destinationKeyPath:destinationKeyPath evaluationBlock:evaluationBlock];
}

- (void)mapAttribute:(NSString *)attributeName withValue:(id)expectedValue
{
    self.expectation = [RKMappingTestExpectation expectationWithSourceKeyPath:attributeName destinationKeyPath:attributeName value:expectedValue];
}

- (void)mapRelationship:(NSString *)relationshipName usingMapping:(RKMapping *)mapping
{
    self.expectation = [RKMappingTestExpectation expectationWithSourceKeyPath:relationshipName destinationKeyPath:relationshipName mapping:mapping];
}

- (void)connectRelationship:(NSString *)relationshipName fromKeyPath:(NSString *)sourceKeyPath toKeyPath:(NSString *)destinationKeyPath withValue:(id)expectedValue
{
    self.expectation = [RKMappingTestExpectation expectationWithSourceKeyPath:sourceKeyPath destinationKeyPath:destinationKeyPath evaluationBlock:^BOOL(RKMappingTestExpectation *expectation, RKPropertyMapping *mapping, id mappedValue, NSError *__autoreleasing *error) {
        // Mapping mismatch
        RKMappingTestExpectationTestCondition([mapping isKindOfClass:[RKConnectionMapping class]], error, @"expected a property mapping of type `RKConnectionMapping` but instead got a `%@`", [mapping class]);
        
        // Wrong relationship
        RKConnectionMapping *connectionMapping = (RKConnectionMapping *)mapping;
        RKMappingTestExpectationTestCondition([connectionMapping.relationship.name isEqualToString:relationshipName], error, @"Expected to the connect the relationship named '%@', but instead connected '%@'", relationshipName, connectionMapping.relationship.name);
        
        // Wrong objects
        if (expectedValue) RKMappingTestExpectationTestCondition(mappedValue, error, @"unexpectedly connected to nil object set (%@)", mappedValue);
        if (expectedValue == nil) RKMappingTestExpectationTestCondition(mappedValue == nil, error, @"unexpectedly connected to non-nil object set (%@)", mappedValue);
        RKMappingTestExpectationTestCondition(RKValueIsEqualToValue(mappedValue, expectedValue), error, @"connected to unexpected %@ value '%@'", [mappedValue class], mappedValue);
        
        return YES;
    }];
}

- (NSString *)description
{
    return [self.expectation description];
}

@end
