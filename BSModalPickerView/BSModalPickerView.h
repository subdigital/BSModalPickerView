//
//  BSModalPickerView.h
//  CustomPicker
//
//  Created by Ben Scheirman on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSModalPickerBase.h"

@interface BSModalPickerView : BSModalPickerBase <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) NSMutableArray *selectedIndexes;
@property (nonatomic) NSUInteger selectedIndex;
@property (nonatomic, strong) NSString *selectedValue;
@property (nonatomic, strong) NSArray *selectedValues;
@property (nonatomic, strong) NSArray *values;

/* Initializes a new instance of the picker with the values to present to the user.
 (Note: call presentInView:withBlock: or presentInWindowWithBlock: to display the control)
 */
- (id)initWithValues:(NSArray *)values;
- (NSUInteger)selectedIndexInComponent:(NSUInteger)component;
- (NSString*)selectedValueInComponent:(NSUInteger)component;

- (void)setSelectedIndex:(NSUInteger)selectedIndex inComponent:(int)component;
- (void)setSelectedValue:(NSString *)selectedValue inComponent:(int)component;


@end
