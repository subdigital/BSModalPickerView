//
//  BSModalPickerView.m
//  DatePicker
//
//  Created by Ben Scheirman on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define BSMODALDATEPICKER_PANEL_HEIGHT 260
#define BSMODALDATEPICKER_TOOLBAR_HEIGHT 40
#define BSMODALDATEPICKER_BACKDROP_OPACITY 0.8

#import "BSModalDatePickerView.h"

@interface BSModalDatePickerView () {
    UIDatePicker *_picker;
    UIToolbar *_toolbar;
    UIView *_panel;
    UIView *_backdropView;
}

@property (nonatomic, strong) BSModalDatePickerViewCallback callbackBlock;

@end

@implementation BSModalDatePickerView

@synthesize selectedDate = _selectedDate;
@synthesize mode = _mode;
@synthesize callbackBlock = _callbackBlock;

- (id)initWithDate:(NSDate *)date {
    self = [super init];

    if (self) {
        self.selectedDate = date;
        self.mode = UIDatePickerModeDate;
        self.userInteractionEnabled = YES;
    }

    return self;
}

- (void)setSelectedDate:(NSDate *)selectedDate {
    _selectedDate = selectedDate;
    if(_selectedDate) {
        if(_picker) {
            _picker.date = _selectedDate;
        }
    }
}

- (NSDate *)selectedDate {
    if(_picker) {
        _selectedDate = _picker.date;
    }
    return _selectedDate;
}

- (void)setMode:(UIDatePickerMode)mode {
    _mode = mode;
    if(_picker) {
        _picker.datePickerMode = _mode;
    }
}

- (UIDatePickerMode)mode {
    if(_picker) {
        _mode = _picker.datePickerMode;
    }
    return _mode;
}

- (void)onCancel:(id)sender {
    self.callbackBlock(NO);
    [self dismissPicker];
}

- (void)onDone:(id)sender {
    self.callbackBlock(YES);
    [self dismissPicker];
}

- (void)onBackdropTap:(id)sender {
    [self onCancel:sender];
}

- (void)dismissPicker {
    [UIView animateWithDuration:0.25 delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         CGRect newFrame = _panel.frame;
                         newFrame.origin.y += _panel.frame.size.height;
                         _panel.frame = newFrame;
                         _backdropView.alpha = 0;
                     } completion:^(BOOL finished) {
                         [_panel removeFromSuperview];
                         _panel = nil;
                         
                         [_backdropView removeFromSuperview];
                         _backdropView = nil;
                         
                         [self removeFromSuperview];
                     }];
}

- (UIDatePicker *)picker {
    UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, BSMODALDATEPICKER_TOOLBAR_HEIGHT, self.bounds.size.width, BSMODALDATEPICKER_PANEL_HEIGHT - BSMODALDATEPICKER_TOOLBAR_HEIGHT)];
    if(_selectedDate) {
        picker.date = _selectedDate;
    }
    picker.datePickerMode = _mode;
    
    return picker;
}


- (UIToolbar *)toolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, BSMODALDATEPICKER_TOOLBAR_HEIGHT)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    
    toolbar.items = [NSArray arrayWithObjects:
                     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                                                   target:self 
                                                                   action:@selector(onCancel:)],
                     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                                   target:nil 
                                                                   action:nil],
                     [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                                   target:self 
                                                                   action:@selector(onDone:)],
                     nil];
    
    return toolbar;
}

- (UIView *)backdropView {
    UIView *backdropView = [[UIView alloc] initWithFrame:self.bounds];
    backdropView.backgroundColor = [UIColor colorWithWhite:0 alpha:BSMODALDATEPICKER_BACKDROP_OPACITY];
    backdropView.alpha = 0;
    
    UIGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackdropTap:)];
    [backdropView addGestureRecognizer:tapRecognizer];
    return backdropView;
}

- (void)presentInView:(UIView *)view withBlock:(BSModalDatePickerViewCallback)callback {
    self.frame = view.bounds;
    self.callbackBlock = callback;
    
    [_panel removeFromSuperview];
    [_backdropView removeFromSuperview];
    
    _panel = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - BSMODALDATEPICKER_PANEL_HEIGHT, self.bounds.size.width, BSMODALDATEPICKER_PANEL_HEIGHT)];
    _picker = [self picker];
    _toolbar = [self toolbar];
    
    _backdropView = [self backdropView];
    [self addSubview:_backdropView];

    [_panel addSubview:_picker];
    [_panel addSubview:_toolbar];
    
    [self addSubview:_panel];
    [view addSubview:self];
    
    CGRect oldFrame = _panel.frame;
    CGRect newFrame = _panel.frame;
    newFrame.origin.y += newFrame.size.height;
    _panel.frame = newFrame;
    
    [UIView animateWithDuration:0.25 delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         _panel.frame = oldFrame;
                         _backdropView.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)presentInWindowWithBlock:(BSModalDatePickerViewCallback)callback {
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(window)]) {
        UIWindow *window = [appDelegate window];
        [self presentInView:window withBlock:callback];
    } else {
        [NSException exceptionWithName:@"Can't find a window property on App Delegate.  Please use the presentInView:withBlock: method" reason:@"The app delegate does not contain a window method"
                              userInfo:nil];
    }
}

@end
