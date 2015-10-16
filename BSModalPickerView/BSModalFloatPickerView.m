//
//  BSModalFloatPickerView.m
//
//  Created by Daryll Herberger on 10/28/13.
//

#import "BSModalFloatPickerView.h"

@interface BSModalFloatPickerView () {
    CGFloat _selectedValue;
}

@property (nonatomic, weak) UIPickerView *shownPicker;

@end

@implementation BSModalFloatPickerView

#pragma mark - Custom Getters

- (UIView *)pickerWithFrame:(CGRect)pickerFrame {
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
	pickerView.backgroundColor = [UIColor whiteColor];
    
    NSInteger selectedIntegerPart = _selectedValue;
    [pickerView selectRow:selectedIntegerPart inComponent:0 animated:NO];
    
    for (int i = 0; i < self.precision; i++) {
        NSInteger decimalPlace = i + 1;
        double integer_part;
        NSInteger selectedFractionalPart = modf(_selectedValue, &integer_part) * (10 * decimalPlace);
        [pickerView selectRow:selectedFractionalPart inComponent:decimalPlace animated:NO];
    }
    
    self.shownPicker = pickerView;
    
    return pickerView;
}

#pragma mark - Custom Setters

- (void)setSelectedValue:(CGFloat)selectedValue {
    _selectedValue = selectedValue;
    
    if (_maxValue < _selectedValue) {
        _selectedValue = _maxValue;
    }
    
    if (self.shownPicker != nil) {
        [self.shownPicker reloadAllComponents];
    }
}

- (void)setMaxValue:(CGFloat)maxValue {
    _maxValue = maxValue;
    
    if (maxValue < _selectedValue) {
        _selectedValue = maxValue;
    }
    
    if (self.shownPicker != nil) {
        [self.shownPicker reloadAllComponents];
    }
}

#pragma mark - Picker View Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.precision + 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger result = 0;
    
    switch (component) {
        case 0: {
            result = self.maxValue + 1;
            break;
        }
        default: {
            NSInteger selectedIntegerPart = _selectedValue;
            NSInteger maxValueIntegerPart = self.maxValue;
            if (selectedIntegerPart == maxValueIntegerPart) {
                CGFloat maxRepresentable = 0.0;
                CGFloat maxSigFigPart = self.maxValue;
                CGFloat relativeSigFigPart = _selectedValue;
                
                for (int sigFig = 0; sigFig < component; sigFig++) {
                    double maxIntegerPart, relativeIntegerPart;
                    maxSigFigPart = (CGFloat)modf(maxSigFigPart, &maxIntegerPart) * 10;
                    relativeSigFigPart = (CGFloat)modf(relativeSigFigPart, &relativeIntegerPart) * 10;
                    
                    if (sigFig == 0) {
                        maxRepresentable = relativeIntegerPart;
                    } else {
                        maxRepresentable += relativeIntegerPart / pow(10, sigFig);
                    }
                }
                
                NSInteger sigFigDigitMax = maxSigFigPart;
                maxRepresentable += sigFigDigitMax / pow(10, component);
                maxRepresentable += 9 / pow(10, component + 1);
                
                if (maxRepresentable < self.maxValue) {
                    result = 10;
                } else {
                    result = sigFigDigitMax + 1;
                }
            } else {
                result = 10;
            }

            break;
        }
    }
    
    return result;
}

#pragma mark - Picker View Delegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat result = 0.0f;
    
    switch (component) {
        case 0: {
            NSInteger maxValueIntegerPart = self.maxValue;
            NSInteger numberOfDigits = [[NSString stringWithFormat:@"%d", maxValueIntegerPart] length];
            CGFloat widthForRange = 25.0f * numberOfDigits;
            result = widthForRange;
            break;
        }
        default: {
            result = 25.0f;
            break;
        }
    }
    
    return result;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *result = nil;
    
    result = [NSString stringWithFormat:@"%d", row];
    
    return result;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectedValue = [pickerView selectedRowInComponent:0];
    
    for (int i = 0; i < self.precision; i++) {
        NSInteger decimalPlace = i + 1;
        
        _selectedValue += (CGFloat)[pickerView selectedRowInComponent:decimalPlace] / (CGFloat)(pow(10, decimalPlace));
    }
    
    [pickerView reloadAllComponents];
}

@end
