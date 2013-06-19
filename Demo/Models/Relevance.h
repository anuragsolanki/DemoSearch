//
//  Relevance.h
//  Demo
//
//  Created by Anurag Solanki on 19/06/13.
//  Copyright (c) 2013 Anurag Solanki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Keyword, Query, Webpage;

@interface Relevance : NSManagedObject

@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) Keyword *keyword;
@property (nonatomic, retain) Query *query;
@property (nonatomic, retain) Webpage *webpage;

@end
