RKKiwiMatchers
==============

This project provides a set of matchers for use in testing the RestKit framework via the Kiwi behavior driven development library.

## Example App

There is an example app available in the Example directory that can be helpful for referencing configuration and use.

## Installation

Recommended installation is via Cocoapods:

```ruby
# Link RestKit and testing support into Application Target
pod 'RestKit', '~> 0.20.0'
pod 'RestKit/Testing', '~> 0.20.0'

# Link Kiwi and the matchers into the Unit Test Bundle Target
target :test, :exclusive => true do
  pod 'RKKiwiMatchers'
  pod 'Kiwi', '~> 2.0.0'
end
```

Otherwise add all files in `Code` directory to your unit testing bundle target.

## Usage

``` objective-c
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import <RestKit/Testing.h>
#import <RKKiwiMatchers/RKKiwiMatchers.h>

SPEC_BEGIN(GGMappingsSpec)

registerMatchers(@"RK");

context(@"when object mapping a GGAirline", ^{
    __block NSData *fixtureData;
    __block RKMappingTest *mappingTest;
        
    beforeEach(^{
        RKManagedObjectStore *managedObjectStore = [RKManagedObjectStore defaultStore];
        fixtureData = [RKTestFixture parsedObjectWithContentsOfFixture:@"Fixtures/airlines/1.json"];
        mappingTest = [RKMappingTest testForMapping:[mappings airlineResponseMapping] sourceObject:fixtureData destinationObject:nil];
        mappingTest.mappingOperationDataSource = [[RKManagedObjectMappingOperationDataSource alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext cache:nil];
        mappingTest.rootKeyPath = @"airline";
    });

	// Attributes
    specify(^{ [[mappingTest should] mapKeyPath:@"id" toKeyPath:@"airlineID" withValue:@1234]; });
    specify(^{ [[mappingTest should] mapKeyPath:@"code" toKeyPath:@"code" withValue:@"DL"]; });
    specify(^{ [[mappingTest should] mapKeyPath:@"name" toKeyPath:@"name" withValue:@"Delta Air Lines"]; });
    specify(^{ [[mappingTest should] mapKeyPath:@"favorite" toKeyPath:@"favorite" withValue:@NO]; });
    specify(^{ [[mappingTest should] mapKeyPath:@"created_at" toKeyPath:@"createdAt" withValue:RKDateFromString(@"2012-01-07T12:00:00Z")]; });
    
    // Relationships
    specify(^{ [[mappingTest should] mapKeyPath:@"terminals" toKeyPath:@"terminals" usingMapping:[mappings terminalResponseMapping]]; });
    
    // Connect to the Airports this Airline operates out of
    specify(^{
        NSManagedObject *managedObject = [RKTestFactory insertManagedObjectForEntityForName:@"Airport" inManagedObjectContext:nil withProperties:@{@"airportID" : @12345}];
        [managedObject.managedObjectContext saveToPersistentStore:nil];
        [[mappingTest should] connectRelationship:@"airports" usingAttributes:@{ @"airportIDs": @"airportID" } withValue:managedObject];
    });
});

```

## License

RKKiwiMatchers is available under the terms of the Apache2 license. See the LICENSE file for more info.

## Credits

[Blake Watters](http://github.com/blakewatters)  
[@blakewatters](https://twitter.com/blakewatters)
