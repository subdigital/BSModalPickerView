//
//  BSModalDatePickerView.h
//  CustomPicker
//
//  Created by Seth Friedman on 5/22/13.
//  Copyright (c) 2013 Fickle Bits, LLC. All rights reserved.
//

#import "BSModalPickerBase.h"

@interface BSModalDatePickerView : BSModalPickerBase

@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic) UIDatePickerMode mode;
@property (nonatomic) BOOL showTodayButton;

/* Initializes a new instance of the date picker with the values to present to the user.
 (Note: call presentInView:withBlock: or presentInWindowWithBlock: to display the control)
 */
- (id)initWithDate:(NSDate *)date;


@end
