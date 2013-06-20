//
//  ViewController.h
//  Demo
//
//  Created by Anurag Solanki on 19/06/13.
//  Copyright (c) 2013 Anurag Solanki. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Root View Controller to display user interface for input of data and output of computed result
 */

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *computeBttn; // Tap this button to compute result
@property (weak, nonatomic) IBOutlet UITextView *resultView;    // The result gets displayed in this view

@end
