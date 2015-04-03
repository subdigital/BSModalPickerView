//
//  BSModalRangePickerBase.m
//  GolfNow
//
//  Created by Cameron Hall on 3/26/15.
//  Copyright (c) 2015 Vertigo. All rights reserved.
//

#import "BSModalRangePickerBase.h"

@implementation BSModalRangePickerBase

- (UIView *)pickerWithFrame:(CGRect)pickerFrame {
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    self.picker = pickerView;
    
    return pickerView;
}

#pragma mark - Private

- (id)valueAtIndex:(NSInteger)index forComponent:(NSInteger)component {
    
    if (component == 1) {
        index += self.selectedMinRowIndex;
    }
        
    return [self.rangeValues objectAtIndex:index];
}

- (NSInteger)indexOfValue:(id)value forComponent:(NSInteger)component {
    NSInteger result = [self.rangeValues indexOfObject:value];
    
    if (component == 1) {
        result -= self.selectedMinRowIndex;
    }
    
    return result;
}

- (NSString *)formattedValueAtIndex:(NSInteger)index forComponent:(NSInteger)component {
    id value = [self valueAtIndex:index forComponent:component];
    return [self formatValue:value forComponent:component];
}

#pragma mark - Public

- (id)selectedMaxValue {
    NSInteger index = self.selectedMaxRowIndex + self.selectedMinRowIndex;
    
    if (self.rangeValues && [self.rangeValues count] > index) {
        return [self.rangeValues objectAtIndex:index];
    }
    
    return nil;
}

- (id)selectedMinValue {
    if (self.rangeValues && [self.rangeValues count] > self.selectedMinRowIndex) {
        return [self.rangeValues objectAtIndex:self.selectedMinRowIndex];
    }
    
    return nil;
}

- (void)setSelectedMinValue:(id)selectedMinValue {
    NSUInteger index = [self indexForSelectedValue:selectedMinValue];
    
    if ([self.rangeValues count] > index) {
        [self setSelectedMinRowIndex:index];
        
        UIPickerView *pickerView = (UIPickerView *)self.picker;
        
        if (pickerView) {
            [pickerView selectRow:index inComponent:0 animated:NO];
        }
    }
}

- (void)setSelectedMaxValue:(id)selectedMaxValue {
    NSUInteger index = [self indexForSelectedValue:selectedMaxValue];
    
    if (self.selectedMinRowIndex <= index) {
        index -= self.selectedMinRowIndex;
    }
    
    if ([self.rangeValues count] > index) {
        [self setSelectedMaxRowIndex:index];
        
        UIPickerView *pickerView = (UIPickerView *)self.picker;
        
        if (pickerView) {
            [pickerView selectRow:index inComponent:1 animated:NO];
        }
    }
}

#pragma mark - Subclass-implemented methods

- (void)calculateRangeValues {
    [NSException raise:NSGenericException
                format:@"calculateRangeValues: must be implemented by a subclass"];
}

- (NSString *)formatValue:(id)value forComponent:(NSInteger)component {
    [NSException raise:NSGenericException
                format:@"formatValue:forComponent: must be implemented by a subclass"];
    return nil;
}

- (NSUInteger)indexForSelectedValue:(id)value {
    [NSException raise:NSGenericException
                format:@"indexForSelectedValue: must be implemented by a subclass"];
    return 0;
}

#pragma mark - Picker View Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger rowCount = [self.rangeValues count];
    
    if (component == 1) {
        rowCount -= self.selectedMinRowIndex;
    }
    
    return rowCount;
}

#pragma mark - Picker View Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *result = [self formattedValueAtIndex:row forComponent:component];
    
    return result;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        id maxValue = [self valueAtIndex:self.selectedMaxRowIndex forComponent:1];
        
        self.selectedMinRowIndex = row;
        [pickerView reloadAllComponents];
        
        NSInteger newMaxValueIndex = [self indexOfValue:maxValue forComponent:1];
       
        if (newMaxValueIndex < 0) {
            newMaxValueIndex = 0;
        }
        
        if ([self.rangeValues count] <= newMaxValueIndex) {
            newMaxValueIndex = [self.rangeValues count] - 1;
        }
        
        self.selectedMaxRowIndex = newMaxValueIndex;
        
        [pickerView selectRow:newMaxValueIndex inComponent:1 animated:NO];
    } else {
        self.selectedMaxRowIndex = row;
    }
}

@end
