//
//  WSWebServices.h
//  MeteorologicalWeatherStation
//
//  Created by Vitaliy Vasilida on 11.01.17.
//  Copyright © 2017 Vitaliy Vasilida. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSWebServices : NSObject

- (void)loadDataWithUrl:(NSString *)path withComplitionBlock:(void(^)(NSData *data, NSError *error))complitionBlock;

@end
