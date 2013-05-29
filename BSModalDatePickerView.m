//
//  BSModalDatePickerView.m
//  CustomPicker
//
//  Created by Seth Friedman on 5/22/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BSModalDatePickerView.h"
#import "BSModalPickerView.h"

@interface BSModalDatePickerView () {
    UIView *_picker;
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

- (UIView *)picker {
    if (!_picker) {
        UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, BSMODALPICKER_TOOLBAR_HEIGHT, self.bounds.size.width, BSMODALPICKER_PANEL_HEIGHT - BSMODALPICKER_TOOLBAR_HEIGHT)];
        
        if (_selectedDate) {
            datePicker.date = _selectedDate;
        }
        
        datePicker.datePickerMode = _mode;
        
        _picker = datePicker;
    }
    
    return _picker;
}

- (NSDate *)selectedDate {
    if ([self.picker isKindOfClass:[UIDatePicker class]]) {
        UIDatePicker *datePicker = (UIDatePicker *)self.picker;
        _selectedDate = datePicker.date;
    }
    
    return _selectedDate;
}

- (UIDatePickerMode)mode {
    if ([self.picker isKindOfClass:[UIDatePicker class]]) {
        UIDatePicker *datePicker = (UIDatePicker *)self.picker;
        _mode = datePicker.datePickerMode;
    }
    
    return _mode;
}

#pragma mark - Custom Setters

- (void)setSelectedDate:(NSDate *)selectedDate {
    if (_selectedDate != selectedDate) {
        _selectedDate = selectedDate;
        
        UIDatePicker *datePicker = (UIDatePicker *)self.picker;
        datePicker.date = _selectedDate;
    }
}

- (void)setMode:(UIDatePickerMode)mode {
    if (_mode != mode) {
        _mode = mode;
        
        UIDatePicker *datePicker = (UIDatePicker *)self.picker;
        datePicker.datePickerMode = _mode;
    }
}

@end
