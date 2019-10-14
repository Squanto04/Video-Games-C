//
//  JLVideoGame.h
//  Video Games-C
//
//  Created by Jordan Lamb on 10/10/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JLVideoGame : NSObject

@property (nonatomic, copy, readonly, nullable) NSString *name;
@property (nonatomic, copy, readonly, nullable) NSString *gameDescription;
@property (nonatomic, copy, readonly, nullable) NSArray<NSString *> *platforms;
@property (nonatomic, copy, readonly, nullable) NSString *rating;
@property (nonatomic, copy, readonly, nullable) NSString *siteDetailURL;
@property (nonatomic, copy, readonly, nullable) NSString *iconImageURL;
@property (nonatomic, copy, readonly, nullable) NSString *superImageURL;
@property (nonatomic, copy, readonly, nullable) NSString *gameGUID;

- (JLVideoGame *)initWithName:(NSString *)name
             gameDescription:(NSString *)gameDescription
                   platforms:(NSArray *)platforms
                      rating:(NSString *)rating
                siteDetailURL:(NSString *)siteDetailURL
                   iconImageURL:(NSString *)iconImageURL
                superImageURL:(NSString *)superImageURL
                     gameGUID:(NSString *)gameGUID;

@end

NS_ASSUME_NONNULL_END
