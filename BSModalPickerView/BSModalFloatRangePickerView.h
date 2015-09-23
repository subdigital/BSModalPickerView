//
//  BSModalFloatRangePickerView.h
//  GolfNow
//
//  Created by Cameron Hall on 3/26/15.
//  Copyright (c) 2015 Vertigo. All rights reserved.
//
//

#import "BSModalRangePickerBase.h"

@interface BSModalFloatRangePickerView : BSModalRangePickerBase

- (instancetype)initWithFloatInterval:(CGFloat)floatInterval andMinRange:(CGFloat)minRangeValue andMaxRange:(CGFloat)maxRangeValue;

@end