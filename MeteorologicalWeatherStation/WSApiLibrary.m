//
//  ApiLibrary.m
//  MeteorologicalWeatherStation
//
//  Created by Vitaliy Vasilida on 01.02.17.
//  Copyright © 2017 Vitaliy Vasilida. All rights reserved.
//

#import "WSApiLibrary.h"
#import "WSWebServices.h"
#import "WSParser.h"


@interface WSApiLibrary()

@property (strong, nonatomic) WSWebServices *webServices;
@property (strong, nonatomic) WSParser *parser;
@property (strong, nonatomic) NSArray *weatherInfo;

@end

@implementation WSApiLibrary
- (instancetype)init{
    self = [super init];
    if (self) {
        self.webServices = [WSWebServices new];
        self.parser = [WSParser new];
        self.weatherInfo = [NSArray new];
    }
    return self;
}

+ (WSApiLibrary *)sharedInstance{
    //create a singleton.
    static WSApiLibrary *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[WSApiLibrary alloc]init];
    });
    return _sharedInstance;
}

- (NSArray *)parseData:(NSNotification *)notification{
    return self.weatherInfo = [self.parser parseTxtFile:notification];
}

- (NSDictionary *)allStationsDict{
    return [self.parser weatherStationsList];
}

- (void)downloadStationData:(NSString *)urlString {
    [self.webServices loadDataWithUrl:urlString withComplitionBlock:^(NSData *data, NSError *error) {
        //when a block gets back data, I convert data to string and then create a notification that data is downloaded.
        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dataDict = [NSDictionary dictionaryWithObject:string forKey:@"text"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"WSDownloadComplete" object:self userInfo:dataDict];
    }];
}
@end
