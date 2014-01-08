//
//  ViewController.h
//  ModalPickerDemo
//
//  Created by ben on 5/29/13.
//  Copyright (c) 2013 Fickle Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *multiLabel;

- (IBAction)onSelectColor:(id)sender;
- (IBAction)onSelectDate:(id)sender;
- (IBAction)onSelectMulti:(id)sender;

@end
