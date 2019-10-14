//
//  JLVideoGameController.m
//  Video Games-C
//
//  Created by Jordan Lamb on 10/10/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

#import "JLVideoGameController.h"
#import "JLVideoGame.h"
#import <UIKit/UIKit.h>

static NSString * const kBaseURLString = @"https://www.giantbomb.com/api";
static NSString * const kSearchKey = @"search";
static NSString * const kApiKey = @"api_key";
static NSString * const kApiValue = @"1176dea47fc305cea065c156863d528ace492028";
static NSString * const kFormatKey = @"format";
static NSString * const kjsonValue = @"json";
static NSString * const kQueryKey = @"query";
static NSString * const kResourcesKey = @"resourses";
static NSString * const kGameKey = @"game";

@implementation JLVideoGameController

+ (instancetype)sharedInstance
{
    static JLVideoGameController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [JLVideoGameController new];
    });
    return sharedInstance;
}

- (void)fetchGamesWith:(NSString *)searchTerm completion:(void (^)(NSArray<JLVideoGame *> * _Nullable))completion
{
    // Goal URL: https://www.giantbomb.com/api/search/?api_key=1176dea47fc305cea065c156863d528ace492028&format=json&query=SearchTerm&resources=game
    NSURL *baseURL = [NSURL URLWithString:kBaseURLString];
    NSURL *searchURL = [baseURL URLByAppendingPathComponent:kSearchKey];
    NSURLComponents *components = [NSURLComponents componentsWithURL:searchURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *apiKeyQuery = [NSURLQueryItem queryItemWithName:kApiKey value:kApiValue];
    NSURLQueryItem *formatQuery = [NSURLQueryItem queryItemWithName:kFormatKey value:kjsonValue];
    NSURLQueryItem *searchQuery = [NSURLQueryItem queryItemWithName:kQueryKey value:searchTerm];
    NSURLQueryItem *resourceQuery = [NSURLQueryItem queryItemWithName:kResourcesKey value:kGameKey];
    components.queryItems = @[apiKeyQuery,formatQuery,searchQuery,resourceQuery];
    NSURL *finalURL = components.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if(!data)
        {
            NSLog(@"Error fetching Video Game DATA from search term: %@", error);
            completion(nil);
            return;
        }
        
        NSDictionary *gameTLD = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
        
        if (!gameTLD)
        {
            NSLog(@"Error fetching json data: %@", error);
            completion(nil);
            return;
        }
        
        NSArray *secondLevelJSON = gameTLD[@"results"];
        NSMutableArray *arrayOfResults = [NSMutableArray new];
        for (NSDictionary *currentDictionary in secondLevelJSON)
             {
                 NSString *name = currentDictionary[@"name"];
                 NSString *gameDescription = currentDictionary[@"deck"];
                 NSString *siteDetailURL = currentDictionary[@"site_detail_url"];
                 NSString *gameGUID = currentDictionary[@"guid"];
                 
                 NSMutableArray *resultPlatforms = [NSMutableArray<NSString *> new];
                 NSArray *arrayOfCurrentPlatforms = currentDictionary[@"platforms"];
                 for (NSDictionary *platformsDictionary in arrayOfCurrentPlatforms)
                 {
                     NSString *platform = platformsDictionary[@"name"];
                     [resultPlatforms addObject:platform];
                 }
                 
                 NSString *rating = [NSString new];
                 NSArray *resultRatings = currentDictionary[@"original_game_rating"];
                 if ( resultRatings != (NSArray *) [ NSNull null])
                 {
                     for (NSDictionary *resultsDictionary in resultRatings)
                     {
                         if ([resultsDictionary[@"id"]  isEqual: @16])
                         {
                             NSString *newRating = resultsDictionary[@"name"];
                             rating = newRating;
                         }
                     }
                 }
                 NSDictionary *image = currentDictionary[@"image"];
                 NSString *iconImageURL = image[@"icon_url"];
                 NSString *superImageURL = image[@"super_url"];
                     
                 JLVideoGame *videoGame = [[JLVideoGame alloc] initWithName:name gameDescription:gameDescription platforms:resultPlatforms rating:rating siteDetailURL:siteDetailURL iconImageURL:iconImageURL superImageURL:superImageURL gameGUID:gameGUID];
                 
                 [arrayOfResults addObject:videoGame];
             }
        completion(arrayOfResults);
    }] resume ];
}

- (void)fetchIconImage:(JLVideoGame *)icon completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL *iconImageURL = [NSURL URLWithString: icon.iconImageURL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:iconImageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (data)
        {
            UIImage *image = [UIImage imageWithData:data];
            completion(image);
        }
    }] resume];
}

- (void)fetchSuperImage:(JLVideoGame *)image completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL *superImageURL = [NSURL URLWithString: image.superImageURL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:superImageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (data)
        {
            UIImage *image = [UIImage imageWithData:data];
            completion(image);
        }
    }] resume];
}

@end
