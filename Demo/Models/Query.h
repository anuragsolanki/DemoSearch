//
//  Query.h
//  Demo
//
//  Created by Anurag Solanki on 19/06/13.
//  Copyright (c) 2013 Anurag Solanki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Keyword, Relevance;

@interface Query : NSManagedObject

@property (nonatomic) int16_t uniqueID;
@property (nonatomic, retain) NSSet *keywords;
@property (nonatomic, retain) NSSet *relevances;
@end

@interface Query (CoreDataGeneratedAccessors)

- (void)addKeywordsObject:(Keyword *)value;
- (void)removeKeywordsObject:(Keyword *)value;
- (void)addKeywords:(NSSet *)values;
- (void)removeKeywords:(NSSet *)values;

- (void)addRelevancesObject:(Relevance *)value;
- (void)removeRelevancesObject:(Relevance *)value;
- (void)addRelevances:(NSSet *)values;
- (void)removeRelevances:(NSSet *)values;

+ (void)newFromArray:(NSMutableArray *)arr;

@end
