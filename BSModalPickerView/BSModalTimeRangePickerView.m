//
//  BSModalTimeRangePickerView.m
//  GolfNow
//
//  Created by Daryll Herberger on 3/24/15.
//  Copyright (c) 2015 Vertigo. All rights reserved.
//

#import "BSModalTimeRangePickerView.h"

@interface BSModalTimeRangePickerView ()

@property (nonatomic) double numberOfMinutesInRange;
@property (nonatomic) NSUInteger rangeIntervalInMinutes;

@property (nonatomic, strong) NSDate *maxRangeValue;
@property (nonatomic, strong) NSDate *minRangeValue;

@end

@implementation BSModalTimeRangePickerView

- (instancetype)initWithTimeInterval:(double)timeInterval andMinRange:(NSDate *)minRangeValue andMaxRange:(NSDate *)maxRangeValue {
    if (self = [super init]) {
        self.rangeIntervalInMinutes = timeInterval;
        self.minRangeValue = minRangeValue;
        self.maxRangeValue = maxRangeValue;
        
        if ([minRangeValue earlierDate:maxRangeValue] == maxRangeValue) {
            self.minRangeValue = maxRangeValue;
        }
        
        [self calculateRangeValues];
    }
    
    return self;
}

#pragma mark - BSModalRangePickerBase

- (void)calculateRangeValues {
    self.numberOfMinutesInRange = [self.maxRangeValue timeIntervalSinceDate:self.minRangeValue] / 60;
    
    NSMutableArray *values = [NSMutableArray array];
    NSInteger numberOfRowsInComponent = self.numberOfMinutesInRange / self.rangeIntervalInMinutes;

    for (NSInteger i = 0; i < numberOfRowsInComponent; i++) {
        NSInteger numberOfMinutesFromRangeMin = self.rangeIntervalInMinutes * i;
        NSDate *componentRowValue = [self.minRangeValue dateByAddingTimeInterval:numberOfMinutesFromRangeMin * 60];
        [values addObject:componentRowValue];
    }

    self.rangeValues = values;
}

- (NSString *)formatValue:(id)value forComponent:(NSInteger)component {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];

    NSString *result = [dateFormatter stringFromDate:value];

    return result;
}

#pragma mark - Public

- (void)setSelectedMinValue:(NSDate *)minValue {
    if (minValue) {
        for (NSDate *value in self.rangeValues) {
            if ([value timeIntervalSinceDate:minValue] == 0) {
                [self setSelectedMinRowIndex:[self.rangeValues indexOfObject:value]];
                break;
            }
        }
    }
}

- (void)setSelectedMaxValue:(NSDate *)maxValue {
    if (maxValue) {
        for (NSDate *value in self.rangeValues) {
            if ([value timeIntervalSinceDate:maxValue] == 0) {
                [self setSelectedMaxRowIndex:[self.rangeValues indexOfObject:value]];
                break;
            }
        }
    }
}

@end
