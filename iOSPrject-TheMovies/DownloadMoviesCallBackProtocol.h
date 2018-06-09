//
//  DownloadCallBackProtocol.h
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/6/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DownloadMoviesCallBackProtocol <NSObject>
- (void) popularMoviesListIsDownloaded:(NSMutableArray *) moviesList;
- (void) topRatedMoviesListIsDownloaded:(NSMutableArray *) moviesList;
- (void) downloadManagerDidFail;
@end
