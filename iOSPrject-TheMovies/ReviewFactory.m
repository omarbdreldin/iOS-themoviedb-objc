//
//  ReviewFactory.m
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import "ReviewFactory.h"

@implementation ReviewFactory

+ (NSMutableArray *) initListWithData:(id) data {
    NSMutableArray *reviewsList = [NSMutableArray new];
    NSDictionary *dictionary = data;
    
    // Parse data here..
    NSArray *jsonReviewsArray = dictionary[@"results"];
    
    for (NSDictionary * reviewDictionary in jsonReviewsArray) {
        Review *review = [Review new];
        review.author = reviewDictionary[@"author"];
        review.content = reviewDictionary[@"content"];
        
        [reviewsList addObject:review];
    }
    
    return reviewsList;
}

@end
