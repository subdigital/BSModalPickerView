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

- (NSUInteger)indexForSelectedValue:(id)value {
    __block NSUInteger result = 0;
    
    if (value && [value isKindOfClass:[NSDate class]]) {
        NSTimeInterval valueTimeOnly = [self timeIntervalOnlyForDate:value];
        
        [self.rangeValues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDate *rangeValue = (NSDate *)obj;
            NSTimeInterval rangeValueTimeOnly = [self timeIntervalOnlyForDate:rangeValue];
            
            if (rangeValueTimeOnly == valueTimeOnly) {
                result = idx;
                *stop = YES;
            }
        }];
    }
    
    return result;
}

- (NSTimeInterval)timeIntervalOnlyForDate:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar]
                                        components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit
                                        fromDate:date];
    
    [dateComponents setHour:0];
    [dateComponents setMinute:0];
    
    NSDate *dateWithNoTime = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    NSTimeInterval timeOnly = [date timeIntervalSinceDate:dateWithNoTime];
    
    return timeOnly;
}

@end
