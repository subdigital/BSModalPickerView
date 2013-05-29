//
//  BSModalDatePickerView.m
//  CustomPicker
//
//  Created by Seth Friedman on 5/22/13.
//  Copyright (c) 2013 Fickle Bits, LLC. All rights reserved.
//

#import "BSModalDatePickerView.h"

@interface BSModalDatePickerView () {
}

@end

@implementation BSModalDatePickerView

@synthesize selectedDate = _selectedDate;
@synthesize mode = _mode;

#pragma mark - Designated Initializer

- (id)initWithDate:(NSDate *)date {
    self = [super init];
    
    if (self) {
        self.selectedDate = date;
        self.mode = UIDatePickerModeDate;
    }
    
    return self;
}

#pragma mark - Custom Getters

- (UIView *)pickerWithFrame:(CGRect)pickerFrame {
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    
    if (_selectedDate) {
        datePicker.date = _selectedDate;
    }
    
    datePicker.datePickerMode = _mode;
    return datePicker;
}

- (NSDate *)selectedDate {
    UIDatePicker *datePicker = (UIDatePicker *)self.picker;
    _selectedDate = datePicker.date;
    return _selectedDate;
}

- (UIDatePickerMode)mode {
    UIDatePicker *datePicker = (UIDatePicker *)self.picker;
    _mode = datePicker.datePickerMode;
    
    return _mode;
}

#pragma mark - Custom Setters

- (void)setSelectedDate:(NSDate *)selectedDate {
    if (_selectedDate != selectedDate) {
        _selectedDate = selectedDate;
        
        if (_picker) {
            UIDatePicker *datePicker = (UIDatePicker *)self.picker;
            datePicker.date = _selectedDate;
        }
    }
}

- (void)setMode:(UIDatePickerMode)mode {
    if (_mode != mode) {
        _mode = mode;
        
        if (_picker) {
            UIDatePicker *datePicker = (UIDatePicker *)self.picker;
            datePicker.datePickerMode = _mode;
        }
    }
}

@end
