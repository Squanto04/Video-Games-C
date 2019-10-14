//
//  JLVGSearch.h
//  Video Games-C
//
//  Created by Jordan Lamb on 10/10/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JLVGSearch : NSObject

@property (nonatomic, copy, readonly) NSArray *searchResults;
@property (nonatomic, readonly) NSInteger *resultsPerPage;
@property (nonatomic, readonly) NSInteger *totalResults;

- (JLVGSearch *)initWithsearchResults:(NSArray *)searchResults
                       resultsPerPage:(NSInteger *)resultsPerPage
                         totalResults:(NSInteger *)totalResults;

@end

NS_ASSUME_NONNULL_END
