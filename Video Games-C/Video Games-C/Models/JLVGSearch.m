//
//  JLVGSearch.m
//  Video Games-C
//
//  Created by Jordan Lamb on 10/10/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

#import "JLVGSearch.h"

@implementation JLVGSearch

- (JLVGSearch *)initWithsearchResults:(NSArray *)searchResults resultsPerPage:(NSInteger *)resultsPerPage totalResults:(NSInteger *)totalResults
{
    self = [super init];
    if (self)
    {
        _searchResults = searchResults;
        _resultsPerPage = resultsPerPage;
        _totalResults = totalResults;
    }
    return self;
}

@end
