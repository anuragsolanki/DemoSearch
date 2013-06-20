//
//  DemoTests.m
//  DemoTests
//
//  Created by Anurag Solanki on 19/06/13.
//  Copyright (c) 2013 Anurag Solanki. All rights reserved.
//

#import "DemoTests.h"
#import "Webpage.h"

@implementation DemoTests

/** 
 Setup testcases
 */

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
	[MagicalRecord setDefaultModelFromClass:[self class]];
	[MagicalRecord setupCoreDataStackWithInMemoryStore];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    viewController = (ViewController *)appDelegate.window.rootViewController;
}

/** 
 Tear down testcase code called after completion of testcases
 */

- (void)tearDown
{
    // Tear-down code here.
    [MagicalRecord cleanUp];

    [super tearDown];
}

#pragma mark Tests

//- (void)testExample
//{
//    STFail(@"Unit tests are not implemented yet in DemoTests");
//}

/**
 Test Creation Of Core Data Model Entities
 */

- (void)testCreationOfEntity
{
	Webpage *testEntity = [Webpage MR_createEntity];
    STAssertNotNil(testEntity, @"Could not create test subject.");
}

/**
 Test App Delegate and View Controller
 */

- (void)testApplicationDelegate {
    STAssertTrue([appDelegate isMemberOfClass:[AppDelegate class]], @"bad UIApplication delegate");
    STAssertTrue([viewController isMemberOfClass:[ViewController class]], @"bad mainViewController");
}

/**
 Test Result of Main View Controller using Dummy Test Data
 */

- (void)testViewControllerResult {
    STAssertTrue([viewController isMemberOfClass:[ViewController class]], @"");
    
    UITextField* textField1 = (UITextField*)[viewController.view viewWithTag:1];
    textField1.text = @"P Ford Car Review";
    
    UITextField* textField2 = (UITextField*)[viewController.view viewWithTag:2];
    textField2.text = @"P Review Car";

    UITextField* textField3 = (UITextField*)[viewController.view viewWithTag:3];
    textField3.text = @"Q Review";

    UIButton* computeButton = (UIButton*)viewController.computeBttn;
    [computeButton sendActionsForControlEvents:(UIControlEventTouchUpInside)];
    
    STAssertNotNil(viewController.resultView.text, @"Result should not be nil");
    STAssertTrue([viewController.resultView.text isEqualToString:@"\n Q1: P2 P1"], @"Proper Result should be displayed");
}

/**
 Test Result of Main View Controller using Supplied Test Data
 */

- (void)testViewControllerResultUsingSuppliedTestData {
    NSArray *sampleInput = @[ @"P Ford Car Review", @"P Review Car", @"P Review Ford", @"P Toyota Car", @"P Honda Car", @"P Car", @"Q Ford", @"Q Car", @"Q Review", @"Q Ford Review", @"Q Ford Car", @"Q cooking French" ];
    
    for (int i = 1; i <= [sampleInput count]; i++) {
        UITextField* textField = (UITextField*)[viewController.view viewWithTag:i];
        textField.text = sampleInput[i-1];
    }
    
    UIButton* computeButton = (UIButton*)viewController.computeBttn;
    [computeButton sendActionsForControlEvents:(UIControlEventTouchUpInside)];
    
    STAssertNotNil(viewController.resultView.text, @"Result should not be nil");
    STAssertTrue([viewController.resultView.text rangeOfString:@"Q1: P1 P3"].location != NSNotFound, @"Proper Result should be displayed for first query");
    STAssertTrue([viewController.resultView.text rangeOfString:@"Q4: P3 P1 P2"].location != NSNotFound, @"Proper Result should be displayed for fourth query");
    STAssertTrue([viewController.resultView.text rangeOfString:@"Q6:"].location != NSNotFound, @"Proper Result should be displayed for last query");
    STAssertTrue([viewController.resultView.text rangeOfString:@"Q6: "].location == NSNotFound, @"Last query should output no result");
    
    // Note: Testing only specific query output because some queries output is not same always as more than one webpage has same relevance
}



@end