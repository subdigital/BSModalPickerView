//
//  ViewController.m
//  ModalPickerDemo
//
//  Created by ben on 5/29/13.
//  Copyright (c) 2013 Fickle Bits. All rights reserved.
//

#import "ViewController.h"
#import "BSModalPickerView.h"
#import "BSModalDatePickerView.h"
#import "BSModalFloatRangePickerView.h"
#import "BSModalTimeRangePickerView.h"

@interface ViewController () {
    NSInteger _lastSelectedIndex;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)onSelectColor:(id)sender {
    NSArray *colors = @[
                        @"Green",
                        @"Red",
                        @"Blue",
                        @"Black"
                        ];
    
    NSDictionary *namesToColors = @{
                                    @"Red": [UIColor colorWithRed:0.574 green:0.077 blue:0.005 alpha:1.000],
                                    @"Blue": [UIColor colorWithRed:0.136 green:0.402 blue:1.000 alpha:1.000],
                                    @"Green": [UIColor colorWithRed:0.5 green:0.75 blue:0.62 alpha:1.0],
                                    @"Black": [UIColor blackColor]
                                    };
    BSModalPickerView *pickerView = [[BSModalPickerView alloc] initWithValues:colors];
    pickerView.selectedIndex = _lastSelectedIndex;
    [pickerView presentInView:self.view
                    withBlock:^(BOOL madeChoice) {
                        if (madeChoice) {
                            _lastSelectedIndex = pickerView.selectedIndex;
                            NSString *colorName = pickerView.selectedValue;
                            UIColor *color = namesToColors[colorName];
                            self.view.backgroundColor = color;
                        }
                    }];
}

- (IBAction)onSelectDate:(id)sender {
    BSModalDatePickerView *datePicker = [[BSModalDatePickerView alloc] initWithDate:[NSDate date]];
    datePicker.showTodayButton = YES;
    [datePicker presentInView:self.view
                    withBlock:^(BOOL madeChoice) {
                        if (madeChoice) {
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                            [dateFormatter setDateStyle:NSDateFormatterLongStyle];
                            [self.resultLabel setText:[dateFormatter stringFromDate:datePicker.selectedDate]];
                        }
                    }];
}

- (IBAction)onSelectFloatRange:(id)sender {
    BSModalFloatRangePickerView *floatRangePicker = [[BSModalFloatRangePickerView alloc] initWithFloatInterval:0.525 andMinRange:0.0 andMaxRange:10.5];
    [floatRangePicker presentInView:self.view
                    withBlock:^(BOOL madeChoice) {
                        if (madeChoice) {
                            NSNumber *selectedMin = [floatRangePicker selectedMinValue];
                            NSNumber *selectedMax = [floatRangePicker selectedMaxValue];
                            
                            NSString *rangeString = [NSString stringWithFormat:@"%@ - %@", [selectedMin stringValue], [selectedMax stringValue]];

                            [self.resultLabel setText:rangeString];
                        }
                    }];
}

- (IBAction)onSelectTimeRange:(id)sender {
    // Get a minimum value starting at the last half hour
    NSDateComponents *time = [[NSCalendar currentCalendar]
                              components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit
                              fromDate:[NSDate date]];
    NSInteger minutes = [time minute];
    float minuteUnit = floor((float) minutes / 30.0);
    minutes = minuteUnit * 30.0;
    [time setMinute: minutes];
    NSDate *minRangeDate =  [[NSCalendar currentCalendar] dateFromComponents:time];

    // Get a maximum value ending 6 hours away or end of day, end of the hour
    minutes = 0;
    NSInteger hours = [time hour];
    
    if (hours + 6 < 24) {
        [time setHour:hours + 6];
    } else {
        [time setHour:23];
    }
    
    NSDate *maxRangeDate =  [[NSCalendar currentCalendar] dateFromComponents:time];

    BSModalTimeRangePickerView *timeRangePicker = [[BSModalTimeRangePickerView alloc] initWithTimeInterval:15 andMinRange:minRangeDate andMaxRange:maxRangeDate];
    [timeRangePicker presentInView:self.view
                          withBlock:^(BOOL madeChoice) {
                              if (madeChoice) {
                                  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                  [dateFormatter setDateStyle:NSDateFormatterNoStyle];
                                  [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
                                  [dateFormatter setLocale:[NSLocale currentLocale]];
                                  
                                  NSString *selectedMin = [dateFormatter stringFromDate:[timeRangePicker selectedMinValue]];
                                  NSString *selectedMax = [dateFormatter stringFromDate:[timeRangePicker selectedMaxValue]];
                                  
                                  NSString *rangeString = [NSString stringWithFormat:@"%@ - %@", selectedMin, selectedMax];
                                  
                                  [self.resultLabel setText:rangeString];
                              }
                          }];
}

@end
