//
//  ViewController.h
//  ModalPickerDemo
//
//  Created by ben on 5/29/13.
//  Copyright (c) 2013 Fickle Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

- (IBAction)onSelectColor:(id)sender;
- (IBAction)onSelectDate:(id)sender;
- (IBAction)onSelectFloatRange:(id)sender;
- (IBAction)onSelectTimeRange:(id)sender;

@end
