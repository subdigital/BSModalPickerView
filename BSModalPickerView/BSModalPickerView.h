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

@property (nonatomic) NSUInteger selectedIndex;
@property (nonatomic, strong) NSString *selectedValue;
@property (nonatomic, strong) NSArray *values;

/* Initializes a new instance of the picker with the values to present to the user.
 (Note: call presentInView:withBlock: or presentInWindowWithBlock: to display the control)
 */
- (id)initWithValues:(NSArray *)values;

@end
