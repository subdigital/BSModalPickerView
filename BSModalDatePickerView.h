//
//  BSModalPickerView.h
//  DatePicker
//
//  Created by Ben Scheirman on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BSModalDatePickerViewCallback)(BOOL madeChoice);

@interface BSModalDatePickerView : UIView

@property (nonatomic, assign) NSDate *selectedDate;
@property (nonatomic, assign) UIDatePickerMode mode;

/* Initializes a new instance of the date picker with the values to present to the user.
 (Note: call presentInView:withBlock: or presentInWindowWithBlock: to display the control)
 */
- (id)initWithDate:(NSDate *)date;

/* Presents the control embedded in the provided view.
 Arguments:
   view        - The view that will contain the control.
   callback    - The block that will receive the result of the user action. 
 */
- (void)presentInView:(UIView *)view withBlock:(BSModalDatePickerViewCallback)callback;

/* Presents the control embedded in the window.
 Arguments:
   callback    - The block that will receive the result of the user action. 
 */
- (void)presentInWindowWithBlock:(BSModalDatePickerViewCallback)callback;

@end
