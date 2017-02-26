//
//  WSParser.h
//  MeteorologicalWeatherStation
//
//  Created by Vitaliy Vasilida on 01.02.17.
//  Copyright © 2017 Vitaliy Vasilida. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSParser : NSObject

- (instancetype)initParser;
- (NSArray *)parseTxtFile:(NSNotification *)notification;
- (NSDictionary *)weatherStationsList;

@end
