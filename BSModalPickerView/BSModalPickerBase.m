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

#pragma mark - Designated Initializer

- (id)init {
    self = [super init];
    if (self) {
        self.autoresizesSubviews = YES;
        self.presentBackdropView = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

#pragma mark - Custom Getters

- (UIView *)picker {
    if (!_picker) {
        CGRect pickerFrame = CGRectMake(0,
                                        BSMODALPICKER_TOOLBAR_HEIGHT,
                                        self.bounds.size.width,
                                        BSMODALPICKER_PANEL_HEIGHT - BSMODALPICKER_TOOLBAR_HEIGHT);

        _picker = [self pickerWithFrame:pickerFrame];
        _picker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _picker.backgroundColor = [UIColor whiteColor];
    }

    return _picker;
}

- (UIView *)pickerWithFrame:(CGRect)pickerFrame {
    [NSException raise:NSGenericException
                format:@"pickerWithFrame: must be implemented by a subclass"];
    return nil;
}

- (NSArray *)additionalToolbarItems {
    return @[
             [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                           target:nil
                                                           action:nil]
             ];
}

- (UIToolbar *)toolbar {
    if (!_toolbar) {
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, BSMODALPICKER_TOOLBAR_HEIGHT)];
        _toolbar.barStyle = UIBarStyleBlackTranslucent;
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
        _toolbar.items = toolbarItems;
        _toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
    
    return _toolbar;
}

- (UIView *)backdropView {
    if (!_backdropView) {
        _backdropView = [[UIView alloc] initWithFrame:self.bounds];
        _backdropView.backgroundColor = [UIColor colorWithWhite:0 alpha:BSMODALPICKER_BACKDROP_OPACITY];
        _backdropView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backdropView.alpha = 0;
    
        UIGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackdropTap:)];
        [_backdropView addGestureRecognizer:tapRecognizer];
    }
    
    return _backdropView;
}

#pragma mark - Event Handlers

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

#pragma mark - Instance Methods

- (void)presentInView:(UIView *)view withBlock:(BSModalPickerViewCallback)callback {
    self.frame = view.bounds;
    self.callbackBlock = callback;
    
    [self.panel removeFromSuperview];
    [self.backdropView removeFromSuperview];
    
    self.panel = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - BSMODALPICKER_PANEL_HEIGHT, self.bounds.size.width, BSMODALPICKER_PANEL_HEIGHT)];
    self.panel.autoresizesSubviews = YES;
    self.panel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (self.presentBackdropView) {
        [self addSubview:self.backdropView];
    }

    CGRect rect = self.picker.frame;
    rect.size.width = self.panel.frame.size.width;
    self.picker.frame = rect;
    [self.panel addSubview:self.picker];
    [self.panel addSubview:self.toolbar];
    
    [self addSubview:self.panel];
    [view addSubview:self];
    
    CGRect oldFrame = self.panel.frame;
    CGRect newFrame = self.panel.frame;
    newFrame.origin.y += newFrame.size.height;
    self.panel.frame = newFrame;
    
    [UIView animateWithDuration:0.25 delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.panel.frame = oldFrame;
                         self.backdropView.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)presentInWindowWithBlock:(BSModalPickerViewCallback)callback {
    id appDelegate = [[UIApplication sharedApplication] delegate];
    UIWindow *window = [appDelegate window];
    [self presentInView:window withBlock:callback];
}

- (void)dismissPicker {
    [UIView animateWithDuration:0.25 delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect newFrame = self.panel.frame;
                         newFrame.origin.y += self.panel.frame.size.height;
                         self.panel.frame = newFrame;
                         self.backdropView.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self.panel removeFromSuperview];
                         
                         [self.backdropView removeFromSuperview];
                         
                         [self removeFromSuperview];
                     }];
}

@end
