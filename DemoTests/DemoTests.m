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

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
	[MagicalRecord setDefaultModelFromClass:[self class]];
	[MagicalRecord setupCoreDataStackWithInMemoryStore];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    viewController = (ViewController *)appDelegate.window.rootViewController;
}

- (void)tearDown
{
    // Tear-down code here.
    [MagicalRecord cleanUp];

    [super tearDown];
}

//- (void)testExample
//{
//    STFail(@"Unit tests are not implemented yet in DemoTests");
//}

- (void)testCreationOfEntity
{
	Webpage *testEntity = [Webpage MR_createEntity];
    STAssertNotNil(testEntity, @"Could not create test subject.");
}

- (void)testApplicationDelegate {
    STAssertTrue([appDelegate isMemberOfClass:[AppDelegate class]], @"bad UIApplication delegate");
    STAssertTrue([viewController isMemberOfClass:[ViewController class]], @"bad mainViewController");
}

- (void)testViewController {
    
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


    
//    UITextField* nameTextField = (UITextField*)[nameViewController.view viewWithTag:2];
//    
//    nameTextField.text = @"Toto";
//    
//    [nextButton sendActionsForControlEvents:(UIControlEventTouchUpInside)];
//    
//    STAssertTrue([mainNavigationController.visibleViewController isMemberOfClass:[MapViewController class]], @"mapViewController not coming when touching next button");
}



@end
