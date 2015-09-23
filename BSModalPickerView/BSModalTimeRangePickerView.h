//
//  BSModalTimeRangePickerView.h
//  GolfNow
//
//  Created by Daryll Herberger on 3/24/15.
//  Copyright (c) 2015 Vertigo. All rights reserved.
//

#import "BSModalRangePickerBase.h"

@interface BSModalTimeRangePickerView : BSModalRangePickerBase

- (instancetype)initWithTimeInterval:(double)timeInterval andMinRange:(NSDate*)minRangeValue andMaxRange:(NSDate *)maxRangeValue;

@end
