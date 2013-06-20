//
//  Query.m
//  Demo
//
//  Created by Anurag Solanki on 19/06/13.
//  Copyright (c) 2013 Anurag Solanki. All rights reserved.
//

#import "Query.h"
#import "Keyword.h"
#import "Relevance.h"


@implementation Query

@dynamic uniqueID;
@dynamic keywords;
@dynamic relevances;

/**
 Create a new query object using array of keywords
 */

+ (void)newFromArray:(NSMutableArray *)arr
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_contextForCurrentThread];
    
    // Create a new query in the current thread context
    Query *query                        = [Query MR_createInContext:localContext];
    query.uniqueID                      = [Query MR_countOfEntitiesWithContext:localContext];
    
    [localContext MR_saveToPersistentStoreAndWait];
    
    //Loop through all keywords for this webpage
    for (int i = 0; i < [arr count]; i++) {
        NSString *keyword = [arr[i] lowercaseString];
        
        Keyword *newKeyword;
        NSArray *temp = [Keyword MR_findByAttribute:@"name" withValue:keyword];
        if ([temp count] > 0) {
            // keyword exists
            newKeyword = temp[0];
        }
        else { // make a new keyword
            newKeyword = [Keyword MR_createInContext:localContext];
            newKeyword.name = keyword;
        }
        
        Relevance *relevance = [Relevance MR_createInContext:localContext];
        relevance.amount = [NSNumber numberWithInt:(MAXITEMS - i)];
        
        // Save the modification in the local context
        [localContext MR_saveToPersistentStoreAndWait];
        
        // Add relations
        [newKeyword addRelevancesObject:relevance];
        [query addKeywordsObject:newKeyword];
        [query addRelevancesObject:relevance];
    }    
}

@end