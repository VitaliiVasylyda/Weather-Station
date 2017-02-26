//
//  WSDateTableViewCell.h
//  MeteorologicalWeatherStation
//
//  Created by Vitaliy Vasilida on 13.02.17.
//  Copyright © 2017 Vitaliy Vasilida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSDateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *montheLabel;
@property (weak, nonatomic) IBOutlet UILabel *tMaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *rainMMLabel;

@property (weak, nonatomic) IBOutlet UILabel *tMinLabel;
@property (weak, nonatomic) IBOutlet UILabel *afDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunHoursLabel;
@end
