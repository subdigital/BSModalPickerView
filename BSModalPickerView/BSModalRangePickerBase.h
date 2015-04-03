//
//  BSModalRangePickerBase.h
//  GolfNow
//
//  Created by Cameron Hall on 3/26/15.
//  Copyright (c) 2015 Vertigo. All rights reserved.
//

#import "BSModalPickerBase.h"

@interface BSModalRangePickerBase : BSModalPickerBase<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *rangeValues;

@property (nonatomic) NSUInteger selectedMinRowIndex;
@property (nonatomic) NSUInteger selectedMaxRowIndex;

@property (nonatomic) id selectedMaxValue;
@property (nonatomic) id selectedMinValue;

@end
