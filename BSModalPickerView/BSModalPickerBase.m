//
//  BSModalPickerBase.m
//  CustomPicker
//
//  Created by Ben Scheirman on 5/29/2013.
//  Copyright (c) 2012 Fickle Bits, LLC. All rights reserved.
//

#import "BSModalPickerBase.h"

@interface BSModalPickerBase ()

@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIView *panel;
@property (nonatomic, strong) UIView *backdropView;
@property (nonatomic, strong) BSModalPickerViewCallback callbackBlock;

@end

@implementation BSModalPickerBase

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
                        options:UIViewAnimationOptionCurveEaseOut
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

- (UIView *)pickerWithFrame:(CGRect)pickerFrame {
    [NSException raise:NSGenericException
                format:@"pickerWithFrame: must be implemented by a subclass"];
    return nil;
}

- (UIView *)picker {
    if (!_picker) {
        CGRect pickerFrame = CGRectMake(0,
                                        BSMODALPICKER_TOOLBAR_HEIGHT,
                                        [UIApplication sharedApplication].keyWindow.rootViewController.view.bounds.size.width,
                                        BSMODALPICKER_PANEL_HEIGHT - BSMODALPICKER_TOOLBAR_HEIGHT);
        
        _picker = [self pickerWithFrame:pickerFrame];
    }
    
    return _picker;
}

- (NSArray *)additionalToolbarItems {
    return @[
             [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                           target:nil
                                                           action:nil]
             ];
}

- (UIToolbar *)toolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, BSMODALPICKER_TOOLBAR_HEIGHT)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                  target:self
                                                                                  action:@selector(onCancel:)];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(onDone:)];
    NSMutableArray *toolbarItems = [NSMutableArray array];
    [toolbarItems addObject:cancelButton];
    [toolbarItems addObjectsFromArray:[self additionalToolbarItems]];
    [toolbarItems addObject:doneButton];
    toolbar.items = toolbarItems;
    
    return toolbar;
}

- (UIView *)backdropView {
    UIView *backdropView = [[UIView alloc] initWithFrame:self.bounds];
    backdropView.backgroundColor = [UIColor colorWithWhite:0 alpha:BSMODALPICKER_BACKDROP_OPACITY];
    backdropView.alpha = 0;
    
    UIGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackdropTap:)];
    [backdropView addGestureRecognizer:tapRecognizer];
    return backdropView;
}

- (void)presentInView:(UIView *)view withBlock:(BSModalPickerViewCallback)callback {
    self.frame = view.bounds;
    self.callbackBlock = callback;
    
    [_panel removeFromSuperview];
    [_backdropView removeFromSuperview];
    
    _panel = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - BSMODALPICKER_PANEL_HEIGHT, self.bounds.size.width, BSMODALPICKER_PANEL_HEIGHT)];
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
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _panel.frame = oldFrame;
                         _backdropView.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)presentInWindowWithBlock:(BSModalPickerViewCallback)callback {
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
