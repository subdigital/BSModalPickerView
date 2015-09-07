//
//  BSModalPickerBase.h
//  CustomPicker
//
//  Created by Ben Scheirman on 5/29/2013.
//  Copyright (c) 2012 Fickle Bits, LLC. All rights reserved.
//

#define BSMODALPICKER_PANEL_HEIGHT 260
#define BSMODALPICKER_TOOLBAR_HEIGHT 44
#define BSMODALPICKER_BACKDROP_OPACITY 0.2

#import <UIKit/UIKit.h>

typedef void (^BSModalPickerViewCallback)(BOOL madeChoice);

@interface BSModalPickerBase : UIView {
    UIView* _picker;
}

@property (nonatomic, strong) UIView *picker;

/* Determines whether to display the opaque backdrop view.  By default, this is YES. */
@property (nonatomic) BOOL presentBackdropView;

/* Presents the control embedded in the provided view.
 Arguments:
   view        - The view that will contain the control.
   callback    - The block that will receive the result of the user action. 
 */
- (void)presentInView:(UIView *)view withBlock:(BSModalPickerViewCallback)callback;

/* Presents the control embedded in the window.
 Arguments:
   callback    - The block that will receive the result of the user action. 
 */
- (void)presentInWindowWithBlock:(BSModalPickerViewCallback)callback;

/* Subclasses must override this method.  Subclasses implementations must NOT call super. */
- (UIView *)pickerWithFrame:(CGRect)pickerFrame;

/* Events that may be overridden in subclasses */
- (void)onDone:(id)sender;
- (void)onCancel:(id)sender;
- (void)onBackdropTap:(id)sender;

/* Override and return any additional buttons that you want on the toolbar.  By default, this is just a flexible space item. */
- (NSArray *)additionalToolbarItems;
    
@end
