//
//  JLVideoGame.m
//  Video Games-C
//
//  Created by Jordan Lamb on 10/10/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

#import "JLVideoGame.h"

@implementation JLVideoGame

- (JLVideoGame *)initWithName:(NSString *)name gameDescription:(NSString *)gameDescription platforms:(NSArray *)platforms rating:(NSString *)rating siteDetailURL:(NSString *)siteDetailURL iconImageURL:(NSString *)iconImageURL superImageURL:(NSString *)superImageURL gameGUID:(NSString *) gameGUID
{
    self = [super init];
    if (self)
    {
        _name = name;
        _gameDescription = gameDescription;
        _platforms = platforms;
        _rating = rating;
        _siteDetailURL = siteDetailURL;
        _iconImageURL = iconImageURL;
        _superImageURL = superImageURL;
        _gameGUID = gameGUID;
    }
    return self;
}

@end
