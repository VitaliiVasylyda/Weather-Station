//
//  WSParser.m
//  MeteorologicalWeatherStation
//
//  Created by Vitaliy Vasilida on 01.02.17.
//  Copyright © 2017 Vitaliy Vasilida. All rights reserved.
//

#import "WSParser.h"
#import "WSStationsList.h"

@interface WSParser()
@property (strong, nonatomic) NSMutableArray *mutArray;
@end




@implementation WSParser
- (instancetype)initParser {
    self = [super init];
    if (self) {
        self.mutArray = [NSMutableArray new];
}
     return self;
}

-(NSArray *)parseTxtFile:(NSNotification *)notification{
    NSString *string = [notification.userInfo valueForKey:@"text"];
    NSArray *array = [string componentsSeparatedByString:@"\n"];
    self.mutArray = [NSMutableArray arrayWithCapacity:array.count];
    NSMutableDictionary *mutDict = [NSMutableDictionary new];
    NSDictionary *dict = [NSDictionary new];
    //I create an array with keys.
    NSArray *arrayWithKeys = [NSArray arrayWithObjects:@"year", @"month",@"tMax", @"tMin", @"days", @"rainMM", @"sunHours", nil];
    int keyCounter = 0;
    //I read each line in the array.
    for (NSString *lineStr in array) {
        //if a line starts with a number, condition is true.
        if ([lineStr hasPrefix:@"   1"] || [lineStr hasPrefix:@"   2"]) {
            NSArray *seperatedValues = [lineStr componentsSeparatedByString:@" "];
            //I read each word in the line.
            for (NSString *word in seperatedValues) {
                if (![word isEqualToString:@""]) {
                    //each word is added to the dictionary according to the key.
                    if (keyCounter <= 6) {
                        [mutDict setValue:word forKey:arrayWithKeys[keyCounter]];
                    }
                    if (keyCounter == 7) {
                        NSString *sunHours = [NSString stringWithFormat:@"%@ %@", mutDict[@"sunHours"], word];
                        [mutDict setValue:sunHours forKey:@"sunHours"];
                    }
                    keyCounter++;
                }
            }
            //I have seven keys and when the last word is added to the dictionary, I copy the dictionary to the mutable array.
            dict = [mutDict mutableCopy];
            [self.mutArray addObject:dict];
            keyCounter = 0;
        }
    }
    return self.mutArray;
}
// I get a list of all weather stations.
- (NSDictionary *)weatherStationsList{
    NSDictionary *allStations = @{@"Aberporth" : Aberporth,
                                  @"Armagh" : Armagh,
                                  @"Ballypatrick Forest" : BallypatrickForest,
                                  @"Bradford" : Bradford,
                                  @"Braemar" : Braemar,
                                  @"Camborne" : Camborne,
                                  @"Cambridge NIAB" : CambridgeNIAB,
                                  @"Bute Park" : CardiffButePark,
                                  @"Chivenor" : Chivenor,
                                  @"Cwmystwyth" : Cwmystwyth,
                                  @"Dunstaffnage" : Dunstaffnage,
                                  @"Durham" : Durham,
                                  @"Eastbourne" : Eastbourne,
                                  @"Eskdalemuir" : Eskdalemuir,
                                  @"Heathrow" : Heathrow,
                                  @"Hurn" : Hurn,
                                  @"Lerwick" : Lerwick,
                                  @"Leuchars" : Leuchars,
                                  @"Lowestoft" : Lowestoft,
                                  @"Manston" : Manston,
                                  @"Nairn" : Nairn,
                                  @"Newton Rigg" : NewtonRigg,
                                  @"Oxford" : Oxford,
                                  @"Paisley" : Paisley,
                                  @"Ringway" : Ringway,
                                  @"Ross-on-Wye" : RossonWye,
                                  @"Shawbury" : Shawbury,
                                  @"Sheffield" : Sheffield,
                                  @"Southampton" : Southampton,
                                  @"Stornoway Airport" : StornowayAirport,
                                  @"Sutton Bonington" : SuttonBonington,
                                  @"Tiree" : Tiree,
                                  @"Valley" : Valley,
                                  @"Waddington" : Waddington,
                                  @"Whitby" : Whitby,
                                  @"Wick Airport" : WickAirport,
                                  @"Yeovilton" : Yeovilton};
    return allStations;
}

@end
