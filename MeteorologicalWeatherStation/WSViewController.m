//
//  ViewController.m
//  MeteorologicalWeatherStation
//
//  Created by Vitaliy Vasilida on 09.01.17.
//  Copyright © 2017 Vitaliy Vasilida. All rights reserved.
//

#import "WSViewController.h"
#import "WSWebServices.h"
#import "WSApiLibrary.h"
#import "WSDateTableViewCell.h"


 static NSString *const kUrlWeatherStation = @"http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/bradforddata.txt";

@interface WSViewController () <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSArray *infoArray;
@property (strong, nonatomic) NSArray *keyArray;
@property (strong, nonatomic) NSArray *allStationsList;
@property (strong, nonatomic) NSArray *stationsName;
@property (strong, nonatomic) NSDictionary *dict;
@property (strong, nonatomic) WSApiLibrary *apiLibrary;

@end

@implementation WSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.infoArray = [NSArray new];
    self.apiLibrary = [WSApiLibrary new];
    //download a txt file from the server.
    [self.apiLibrary downloadStationData:kUrlWeatherStation];
    //when the txt file is downloaded, I transmit data to the parse method.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(parseData:) name:@"WSDownloadComplete" object:nil];
    self.yearLabel.text = @"Year";
    self.monthLabel.text = @"Month";
    self.tMaxLabel.text = @"tMax";
    self.tMinLabel.text = @"tMin";
    self.afDaysLabel.text = @"daysF";
    self.rainMMLabel.text = @"rain MM";
    self.sunHoursLabel.text = @"sunH";
    //get all weather stations list.
    self.dict = [self.apiLibrary allStationsDict];
    self.allStationsList = [[self.dict allKeys]sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}
#pragma mark - privat methods
- (void)parseData:(NSNotification *)notification{
   self.infoArray = [self.apiLibrary parseData:notification];
    //when I get parse data, I reload table view.
    [self.dateTableView reloadData];
    self.dateTableView.hidden = NO;
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidesWhenStopped = YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const kCellIdintifaer = @"dateCell";
    WSDateTableViewCell *dateCell = [tableView dequeueReusableCellWithIdentifier:kCellIdintifaer];
        NSDictionary *dict = self.infoArray[indexPath.row];
        dateCell.yearLabel.text = dict[@"year"];
        dateCell.montheLabel.text = dict[@"month"];
        dateCell.tMaxLabel.text = dict[@"tMax"];
        dateCell.tMinLabel.text = dict[@"tMin"];
        dateCell.afDaysLabel.text = dict[@"days"];
        dateCell.rainMMLabel.text = dict[@"rainMM"];
        dateCell.sunHoursLabel.text = dict[@"sunHours"];
    
        return dateCell;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.allStationsList.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.allStationsList[row];;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //when a user selected a weather station, the application downloads the weather data.
    NSString *stationURL = [NSString stringWithFormat:@"http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/%@.txt", [self.dict valueForKey:self.allStationsList[row]]];
    [self.apiLibrary downloadStationData:stationURL];
    self.dateTableView.hidden = YES;
    [self.activityIndicator startAnimating];
}
@end
