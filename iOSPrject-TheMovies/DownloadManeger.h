//
//  DownloadManeger.h
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/6/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadMoviesCallBackProtocol.h"
#import "DownloadVideosCallBackProtocol.h"
#import "DownloadReviewsCallBackProtocol.h"
#import <AFHTTPSessionManager.h>
#import "MovieFactory.h"
#import "ReviewFactory.h"
#import "VideoFactory.h"

typedef void (^DownloadMoviesHandler)(NSURLResponse *response, id responseObject, NSError *error);

@interface DownloadManeger : NSObject

@property id<DownloadMoviesCallBackProtocol> downloadMoviesProtocol;
@property id<DownloadVideosCallBackProtocol> downloadVideosProtocol;
@property id<DownloadReviewsCallBackProtocol> downloadReviewsProtocol;

@property AFHTTPSessionManager *maneger;

- (void) downloadPopularMoviesListWithPage:(NSNumber *) pageNumber;
- (void) downloadTopRatedMoviesListWithPage:(NSNumber *) pageNumber;

- (void) downloadReviewsForMovie:(Movie *) movie;
- (void) getVideosUrlsForMovie:(Movie *) movie;

@end
