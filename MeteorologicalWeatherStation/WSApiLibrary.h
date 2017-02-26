//
//  ApiLibrary.h
//  MeteorologicalWeatherStation
//
//  Created by Vitaliy Vasilida on 01.02.17.
//  Copyright © 2017 Vitaliy Vasilida. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSApiLibrary : NSObject

- (void)downloadStationData:(NSString *)urlString;
- (NSArray *)parseData:(NSNotification *)notification;
- (NSDictionary *)allStationsDict;

@end
