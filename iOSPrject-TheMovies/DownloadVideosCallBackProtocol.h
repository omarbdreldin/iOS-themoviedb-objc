//
//  DownloadVideosCallBackProtocol.h
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DownloadVideosCallBackProtocol <NSObject>

- (void) videosListIsDownLoaded:(NSMutableArray *) videosList;

@end
