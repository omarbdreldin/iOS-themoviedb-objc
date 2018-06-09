//
//  VideoFactory.m
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import "VideoFactory.h"

@implementation VideoFactory

+ (NSMutableArray *) initListWithData:(id) data {
        NSMutableArray *videosList = [NSMutableArray new];
        NSDictionary *dictionary = data;
        
        // Parse data here..
        NSArray *jsonVideosArray = dictionary[@"results"];
        
        for (NSDictionary * videoDictionary in jsonVideosArray) {
            [videosList addObject:videoDictionary[@"key"]];
        }
        
        return videosList;
}

@end
