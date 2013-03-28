# RKKiwiMatchers Example App

This is a simple example application that shows to Unit Test Core Data object mappings using RestKit and Kiwi.

Unit Tests are configured using the standard Apple generated boilterplate configuration that is emitted when you select the "Include Unit Tests" checkbox when provisioning an application. This configuration uses an application target and an external Unit Tests bundle that is injected into the application when the tests are run. This is known as an "Application Tests" configuration and is distinct from "Logic Tests" in that the tests are dependent on a running app. The same configuration can be applied to a Logic Test setup as well.

## Running the Example

To run the example, execute `pod install` to install the pre-requisites and then use the **Product** menu > **Test** action to run the tests. The test code is in `RKKiwiExampleTests/ContactSpec.m`

## Navigating the Example Code

There are only a few files of interest to understanding the setup:

1. `RKKiwiExample/RKKEAppDelegate.m` - Sets up the RestKit Core Data stack when the App launches
1. `RKKiwiExampleTests/contact.json` - A JSON Fixture file used in testing.
1. `RKKiwiExampleTests/RKTestFactory+GGEAdditions.m` - A category added to the RestKit `RKTestFactory` class that is used for configuring the test environment.
1. `RKKiwiExampleTests/ContactSpec.m` - The actual Kiwi spec. This is where most of the action is. This test file configures a RestKit mapping, loads a fixture file, and then uses the Kiwi matchers to exercise the mapping and validate the results.

### Credits

Blake Watters <blake@restkit.org>
