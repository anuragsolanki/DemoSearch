//
//  ViewController.m
//  Demo
//
//  Created by Anurag Solanki on 19/06/13.
//  Copyright (c) 2013 Anurag Solanki. All rights reserved.
//

#import "ViewController.h"
#import "Webpage.h"
#import "Query.h"
#import "Relevance.h"
#import "Keyword.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Actions


// Action gets called on tapping compute button : the required result is computed here
- (IBAction)computeResult:(id)sender
{
    NSLog(@"compute clicked");
    
    // First step: remove all data from db
    [Query MR_truncateAll];
    [Relevance MR_truncateAll];
    [Webpage MR_truncateAll];
    [Keyword MR_truncateAll];
    
    _resultView.text = @"";
    
    // Second step: populate all records
    for (int i = 1; i <= 12; i++) {
        UITextField *textField = (UITextField *)[self.view viewWithTag:i];
        
        NSArray *keywordsArray = [textField.text componentsSeparatedByString:@" "];
        if ( ([keywordsArray count] > 0) && [[keywordsArray[0] lowercaseString] isEqualToString:@"p"]) {
            NSMutableArray *onlyKeywords = [keywordsArray mutableCopy];
            [onlyKeywords removeObjectAtIndex:0];
            [Webpage newFromArray:onlyKeywords];
        }
        else if (([keywordsArray count] > 0) && [[keywordsArray[0] lowercaseString] isEqualToString:@"q"]) {
            NSMutableArray *onlyKeywords = [keywordsArray mutableCopy];
            [onlyKeywords removeObjectAtIndex:0];
            [Query newFromArray:onlyKeywords];
        }
        
    }
    
    // Third Step: find webpages for each query in priority
    
    // Get the local context
    NSManagedObjectContext *localContext = [NSManagedObjectContext MR_contextForCurrentThread];

    // Query to find all the webpages store into the database
    NSArray *webpages = [Webpage MR_findAllSortedBy:@"uniqueID" ascending:YES inContext:localContext];
    
    // Query to find all the queries store into the database
    NSArray *queries = [Query MR_findAllSortedBy:@"uniqueID" ascending:YES inContext:localContext];
    
    for (Query *query in queries) {
        NSArray *allWebpages = [Webpage MR_findAllInContext:localContext];
        for (Webpage *w in allWebpages) {
            w.strength = 0;
        }
        [localContext MR_saveToPersistentStoreAndWait];

        NSSet *keywords = query.keywords;
        for (Keyword *keyword in keywords) {
            for (Webpage *webpage in webpages) {
//                if ([webpage.keywords containsObject:keyword]) {
                NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"keyword = %@ AND webpage = %@", keyword, webpage];
                Relevance *webpageRelevance = [Relevance MR_findFirstWithPredicate:predicate1 inContext:localContext];
                NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"keyword = %@ AND query = %@", keyword, query];
                Relevance *queryRelevance = [Relevance MR_findFirstWithPredicate:predicate2 inContext:localContext];
                if ((webpageRelevance != nil) && (queryRelevance != nil)) {
                    webpage.strength += ([webpageRelevance.amount integerValue] * [queryRelevance.amount integerValue]);
                }
            }
        }

        // predicate so that webpages with 0 strength are not visible in result
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"strength != 0"];
        NSArray *webpages = [Webpage MR_findAllSortedBy:@"strength" ascending:NO withPredicate:predicate inContext:localContext];
        NSString *result1 = [NSString stringWithFormat:@"Q%i:", query.uniqueID];
        for (int i = 0; i < [webpages count]; i++) {
//            NSLog(@"webpage: %i", ((Webpage *)webpages[i]).strength);
            result1 = [result1 stringByAppendingString:[NSString stringWithFormat:@" P%i", ((Webpage *)webpages[i]).uniqueID]];
        }
//        NSLog(@"%@", result1);
        
        // Final Step: Update textView's text and display result
        _resultView.text = [_resultView.text stringByAppendingString:[NSString stringWithFormat:@"\n %@", result1]];
        NSLog(@"result %@", _resultView.text);
    }
    
    
//    NSLog(@" all webpage %@", [Webpage MR_findAll]);
//    NSLog(@"%@", [Keyword MR_findAll]);
//    NSLog(@"%@", [Relevance MR_findAll]);
}

@end
