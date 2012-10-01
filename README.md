RKKiwiMatchers
==============

This project provides a set of matchers for use in testing the RestKit framework via the Kiwi behavior driven development library.

## Installation

Recommended installation is via Cocoapods:

```ruby
target :test, :exclusive => true do
  pod 'RKKiwiMatchers'
  pod 'Kiwi', '1.1.0'
end
```

Otherwise add all files in `Code` directory to your unit testing bundle target.

## Usage

``` objective-c
#import "RKMappingTestMatcher.h"

SPEC_BEGIN(GGMappingsSpec)

registerMatchers(@"RK");

context(@"when object mapping a GGAirline", ^{
    beforeEach(^{
        fixtureData = [RKTestFixture parsedObjectWithContentsOfFixture:@"Fixtures/airlines/1.json"];
        mappingTest = [RKMappingTest testForMapping:[mappings airlineResponseMapping] sourceObject:fixtureData destinationObject:nil];
        mappingTest.mappingOperationDataSource = [[RKManagedObjectMappingOperationDataSource alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext cache:nil];
        mappingTest.rootKeyPath = @"airline";
    });

    specify(^{ [[mappingTest should] mapKeyPath:@"id" toKeyPath:@"airlineID" withValue:@1234]; });
    specify(^{ [[mappingTest should] mapKeyPath:@"code" toKeyPath:@"code" withValue:@"DL"]; });
    specify(^{ [[mappingTest should] mapKeyPath:@"name" toKeyPath:@"name" withValue:@"Delta Air Lines"]; });
    specify(^{ [[mappingTest should] mapKeyPath:@"favorite" toKeyPath:@"favorite" withValue:@NO]; });
    specify(^{ [[mappingTest should] mapKeyPath:@"created_at" toKeyPath:@"createdAt" withValue:RKDateFromString(@"2012-01-07T12:00:00Z")]; });
});

```

## License

RKKiwiMatchers is available under the terms of the Apache2 license. See the LICENSE file for more info.

## Credits

[Blake Watters](http://github.com/blakewatters)  
[@blakewatters](https://twitter.com/blakewatters)
