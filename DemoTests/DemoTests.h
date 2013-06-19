//
//  DemoTests.h
//  DemoTests
//
//  Created by Anurag Solanki on 19/06/13.
//  Copyright (c) 2013 Anurag Solanki. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "AppDelegate.h"
#import "ViewController.h"

@interface DemoTests : SenTestCase {
    AppDelegate* appDelegate;
    ViewController* viewController;
}

@end
