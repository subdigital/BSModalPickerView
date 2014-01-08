//
//  BSModalPickerView.m
//  CustomPicker
//
//  Created by Ben Scheirman on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSModalPickerView.h"

@interface BSModalPickerView ()

@property (nonatomic) NSUInteger indexSelectedBeforeDismissal;

@end

@implementation BSModalPickerView

#pragma mark - Designated Initializer

- (id)initWithValues:(NSArray *)values {
    self = [super init];
    if (self) {
        if (values && [values count] > 0) {
            // is it an array of arrays?
            if ([[values objectAtIndex:0] isKindOfClass:[NSArray class]]) {
                _values = values;
            }
            // else make it an array of 1 array
            else {
                _values = [[NSMutableArray alloc] initWithObjects:values, nil];
            }

            NSMutableArray *initialSelectedIndexes = [[NSMutableArray alloc] initWithCapacity:[values count]];
            for (NSObject* value in self.values) {
                [initialSelectedIndexes addObject:[NSNumber numberWithInt:0]];
            }
            _selectedIndexes = initialSelectedIndexes;
        }
        self.userInteractionEnabled = YES;
    }
    return self;
}

#pragma mark - Custom Getters

- (UIView *)pickerWithFrame:(CGRect)pickerFrame {
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    for (int component = 0; component < self.selectedIndexes.count; component++) {
        NSNumber* selectedIndex = [self.selectedIndexes objectAtIndex:component];
        [pickerView selectRow:[selectedIndex intValue] inComponent:component animated:NO];
    }
    return pickerView;
}

- (NSUInteger)selectedIndex {
    return [self selectedIndexInComponent:0];
}

- (NSUInteger)selectedIndexInComponent:(NSUInteger)component {
    return [[self.selectedIndexes objectAtIndex:component] intValue];
}

- (NSString *)selectedValue {
    return [self selectedValueInComponent:0];
}

- (NSArray *)selectedValues {
    NSMutableArray* values = [[NSMutableArray alloc] initWithCapacity:[self.values count]];
    for (int component = 0; component < self.selectedIndexes.count; component++) {
        [values addObject:[self selectedValueInComponent:component]];
    }
    return values;
}

- (NSString *)selectedValueInComponent:(NSUInteger)component {
    NSString* selectedValue = nil;
    if (self.selectedIndexes.count > component) {
        NSNumber* selectedIndex = [self.selectedIndexes objectAtIndex:component];
        selectedValue = [[self.values objectAtIndex:component] objectAtIndex:[selectedIndex intValue]];
    }
    return selectedValue;
}


#pragma mark - Custom Setters

//- (void)setValues:(NSMutableArray *)values {
//    _values = values;
//    
//    if (_values) {
//        if (self.picker) {
//            UIPickerView *pickerView = (UIPickerView *)self.picker;
//            [pickerView reloadAllComponents];
//            self.selectedIndex = 0;
//        }
//    }
//}

- (void)setSelectedIndex:(NSUInteger)index {
    [self setSelectedIndex:index inComponent:0];
}

- (void)setSelectedIndexes:(NSMutableArray *)indexes {
    for (int component = 0; component < indexes.count; component++) {
        [self setSelectedIndex:[[indexes objectAtIndex:component] intValue] inComponent:component];
    }
}

- (void)setSelectedIndex:(NSUInteger)index inComponent:(int)component {
    if (self.selectedIndexes.count > 0 && component < self.selectedIndexes.count) {
        [self.selectedIndexes replaceObjectAtIndex:component withObject:[NSNumber numberWithInt:index]];
        if (self.picker) {
            UIPickerView *pickerView = (UIPickerView *)self.picker;
            [pickerView selectRow:index inComponent:component animated:YES];
        }
    }
}

- (void)setSelectedValue:(NSString *)value {
    [self setSelectedValue:value inComponent:0];
}

- (void)setSelectedValues:(NSMutableArray *)values {
    for (int component = 0; component < values.count; component++) {
        [self setSelectedValue:[values objectAtIndex:component] inComponent:component];
    }
}

- (void)setSelectedValue:(NSString *)value inComponent:(int)component {
    NSInteger index = [[self.values objectAtIndex:component] indexOfObject:value];
    [self setSelectedIndex:index inComponent:component];
}

#pragma mark - Event Handler

- (void)onDone:(id)sender {
//    self.selectedIndex = self.indexSelectedBeforeDismissal;
    [super onDone:sender];
}

#pragma mark - Picker View Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return [self.values count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[self.values objectAtIndex:component] count];
}

#pragma mark - Picker View Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[self.values objectAtIndex:component] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.selectedIndexes replaceObjectAtIndex:component withObject:[NSNumber numberWithInt:row]];
}

@end
