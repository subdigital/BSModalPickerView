//
//  BSModalFloatRangePickerView.m
//  GolfNow
//
//  Created by Cameron Hall on 3/26/15.
//  Copyright (c) 2015 Vertigo. All rights reserved.
//

#import "BSModalFloatRangePickerView.h"

@interface BSModalFloatRangePickerView()

@property (nonatomic) CGFloat floatInterval;

@property (nonatomic) CGFloat minRangeValue;
@property (nonatomic) CGFloat maxRangeValue;

@end

@implementation BSModalFloatRangePickerView

- (instancetype)initWithFloatInterval:(CGFloat)floatInterval andMinRange:(CGFloat)minRangeValue andMaxRange:(CGFloat)maxRangeValue {
    if (self = [super init]) {
        self.minRangeValue = minRangeValue;
        self.maxRangeValue = maxRangeValue;
        self.floatInterval = floatInterval;
        
        if (self.minRangeValue > self.maxRangeValue) {
            self.maxRangeValue = self.minRangeValue;
        }
        
        [self calculateRangeValues];
    }
    
    return self;
}

#pragma mark - BSModalRangePickerBase

- (void)calculateRangeValues {
    CGFloat rangeDiff = self.maxRangeValue - self.minRangeValue;
    NSInteger numberOfValues = rangeDiff / self.floatInterval + 1;
    NSMutableArray *rangeValues = [NSMutableArray array];
    
    for (NSInteger i = 0; i < numberOfValues; ++i) {
        NSNumber *value = [NSNumber numberWithFloat:i * self.floatInterval];
        [rangeValues addObject:value];
    }
    
    self.rangeValues = rangeValues;
}

- (NSString *)formatValue:(id)value forComponent:(NSInteger)component {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;

    NSString *formattedValue = [numberFormatter stringFromNumber:value];
    return formattedValue;
}

#pragma mark - Public

- (void)setSelectedMinValue:(CGFloat)minValue {
    for (NSNumber *value in self.rangeValues) {
        if ([BSModalFloatRangePickerView floatValue:[value floatValue] isEqualToFloat:minValue]) {
            [self setSelectedMinRowIndex:[self.rangeValues indexOfObject:value]];
            break;
        }
    }
}

- (void)setSelectedMaxValue:(CGFloat)maxValue {
    for (NSNumber *value in self.rangeValues) {
        if ([BSModalFloatRangePickerView floatValue:[value floatValue] isEqualToFloat:maxValue]) {
            [self setSelectedMaxRowIndex:[self.rangeValues indexOfObject:value]];
            break;
        }
    }
}

#pragma mark - Private

+ (BOOL)floatValue:(CGFloat)firstValue isEqualToFloat:(CGFloat)secondValue {
    double diff = fabs(firstValue - secondValue);
    firstValue = fabs(firstValue);
    secondValue = fabs(secondValue);
    double largest = (secondValue > firstValue) ? secondValue : firstValue;
    return (diff <= largest * FLT_EPSILON);
}

@end

