//
//  ViewController.h
//  MeteorologicalWeatherStation
//
//  Created by Vitaliy Vasilida on 09.01.17.
//  Copyright © 2017 Vitaliy Vasilida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *dateTableView;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *tMaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *rainMMLabel;
@property (weak, nonatomic) IBOutlet UILabel *tMinLabel;
@property (weak, nonatomic) IBOutlet UILabel *afDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunHoursLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@end

