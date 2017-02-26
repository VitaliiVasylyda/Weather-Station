//
//  WSWebServices.m
//  MeteorologicalWeatherStation
//
//  Created by Vitaliy Vasilida on 11.01.17.
//  Copyright © 2017 Vitaliy Vasilida. All rights reserved.
//

#import "WSWebServices.h"
#import "WSStationsList.h"


@implementation WSWebServices
- (void)loadDataWithUrl:(NSString *)path withComplitionBlock:(void (^)(NSData *, NSError *))complitionBlock {
    complitionBlock = [complitionBlock copy];
    NSURL *url = [NSURL URLWithString:path];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error){
                NSLog(@"%@", [error localizedDescription]);
            }
            else {
                complitionBlock(data, error);
            }
        });
    }];
    [dataTask resume];
}

@end
