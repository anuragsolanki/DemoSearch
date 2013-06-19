//
//  Keyword.h
//  Demo
//
//  Created by Anurag Solanki on 19/06/13.
//  Copyright (c) 2013 Anurag Solanki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Query, Relevance, Webpage;

@interface Keyword : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *queries;
@property (nonatomic, retain) NSSet *relevances;
@property (nonatomic, retain) NSSet *webpages;
@end

@interface Keyword (CoreDataGeneratedAccessors)

- (void)addQueriesObject:(Query *)value;
- (void)removeQueriesObject:(Query *)value;
- (void)addQueries:(NSSet *)values;
- (void)removeQueries:(NSSet *)values;

- (void)addRelevancesObject:(Relevance *)value;
- (void)removeRelevancesObject:(Relevance *)value;
- (void)addRelevances:(NSSet *)values;
- (void)removeRelevances:(NSSet *)values;

- (void)addWebpagesObject:(Webpage *)value;
- (void)removeWebpagesObject:(Webpage *)value;
- (void)addWebpages:(NSSet *)values;
- (void)removeWebpages:(NSSet *)values;

@end
