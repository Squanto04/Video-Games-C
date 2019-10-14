//
//  JLVideoGameController.h
//  Video Games-C
//
//  Created by Jordan Lamb on 10/10/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLVideoGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLVideoGameController : NSObject

+ (instancetype)sharedInstance;

- (void)fetchGamesWith:(NSString *)searchTerm completion:(void(^)(NSArray<JLVideoGame *> *searchResults))completion;

- (void)fetchIconImage:(JLVideoGame *)icon completion:(void (^)(UIImage * _Nullable))completion;

- (void)fetchSuperImage:(JLVideoGame *)image completion:(void (^)(UIImage * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
