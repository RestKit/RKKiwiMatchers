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
#import "RKConnectionTestExpectation.h"

@interface RKMappingTestMatcher ()
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) id expectation;
@end

extern BOOL RKObjectIsEqualToObject(id sourceValue, id destinationValue);

@implementation RKMappingTestMatcher

#pragma mark -
#pragma mark Getting Matcher Strings

+ (NSArray *)matcherStrings
{
    return [NSArray arrayWithObjects:
            @"mapKeyPath:toKeyPath:",
            @"mapKeyPath:toKeyPath:withValue:",
            @"mapKeyPath:toKeyPath:passingTest:",
            @"mapKeyPath:toKeyPath:usingMapping:",
            @"mapAttribute:withValue:",
            @"mapRelationship:usingMapping:",
            @"connectRelationship:usingAttributes:withValue:",
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
    self.expectation = [RKPropertyMappingTestExpectation expectationWithSourceKeyPath:sourceKeyPath destinationKeyPath:destinationKeyPath];
}

- (void)mapKeyPath:(NSString *)sourceKeyPath toKeyPath:(NSString *)destinationKeyPath withValue:(id)value
{
    self.expectation = [RKPropertyMappingTestExpectation expectationWithSourceKeyPath:sourceKeyPath destinationKeyPath:destinationKeyPath value:value];
}

- (void)mapKeyPath:(NSString *)sourceKeyPath toKeyPath:(NSString *)destinationKeyPath usingMapping:(RKMapping *)mapping
{
    self.expectation = [RKPropertyMappingTestExpectation expectationWithSourceKeyPath:sourceKeyPath destinationKeyPath:destinationKeyPath mapping:mapping];
}

- (void)mapKeyPath:(NSString *)sourceKeyPath toKeyPath:(NSString *)destinationKeyPath passingTest:(RKMappingTestExpectationEvaluationBlock)evaluationBlock
{
    self.expectation = [RKPropertyMappingTestExpectation expectationWithSourceKeyPath:sourceKeyPath destinationKeyPath:destinationKeyPath evaluationBlock:evaluationBlock];
}

- (void)mapAttribute:(NSString *)attributeName withValue:(id)expectedValue
{
    self.expectation = [RKPropertyMappingTestExpectation expectationWithSourceKeyPath:attributeName destinationKeyPath:attributeName value:expectedValue];
}

- (void)mapRelationship:(NSString *)relationshipName usingMapping:(RKMapping *)mapping
{
    self.expectation = [RKPropertyMappingTestExpectation expectationWithSourceKeyPath:relationshipName destinationKeyPath:relationshipName mapping:mapping];
}

- (void)connectRelationship:(NSString *)relationshipName
            usingAttributes:(NSDictionary *)connectionAttributes
                  withValue:(id)expectedValue
{    
    self.expectation = [[RKConnectionTestExpectation alloc] initWithRelationshipName:relationshipName attributes:connectionAttributes value:expectedValue];
}

- (NSString *)description
{
    return [self.expectation description];
}

@end
