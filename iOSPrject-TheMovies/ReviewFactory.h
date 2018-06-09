//
//  ReviewFactory.h
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Review.h"

@interface ReviewFactory : NSObject

+ (NSMutableArray *) initListWithData:(id) data;

@end
