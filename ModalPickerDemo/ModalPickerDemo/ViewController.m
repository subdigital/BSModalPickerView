//
//  ViewController.m
//  ModalPickerDemo
//
//  Created by ben on 5/29/13.
//  Copyright (c) 2013 Fickle Bits. All rights reserved.
//

#import "ViewController.h"
#import "BSModalPickerView.h"
#import "BSModalDatePickerView.h"

@interface ViewController () {
    NSInteger _lastSelectedIndex;
    NSMutableArray* _lastSelectedIndexes;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _lastSelectedIndexes = [[NSMutableArray alloc] init];
}

- (IBAction)onSelectColor:(id)sender {
    NSArray *colors = @[
                        @"Green",
                        @"Red",
                        @"Blue",
                        @"Black"
                        ];
    
    NSDictionary *namesToColors = @{
                                    @"Red": [UIColor colorWithRed:0.574 green:0.077 blue:0.005 alpha:1.000],
                                    @"Blue": [UIColor colorWithRed:0.136 green:0.402 blue:1.000 alpha:1.000],
                                    @"Green": [UIColor colorWithRed:0.5 green:0.75 blue:0.62 alpha:1.0],
                                    @"Black": [UIColor blackColor]
                                    };
    BSModalPickerView *pickerView = [[BSModalPickerView alloc] initWithValues:colors];
    pickerView.selectedIndex = _lastSelectedIndex;
    [pickerView presentInView:self.view
                    withBlock:^(BOOL madeChoice) {
                        if (madeChoice) {
                            _lastSelectedIndex = pickerView.selectedIndex;
                            NSString *colorName = pickerView.selectedValue;
                            UIColor *color = namesToColors[colorName];
                            self.view.backgroundColor = color;
                        }
                    }];
}

- (IBAction)onSelectDate:(id)sender {
    BSModalDatePickerView *datePicker = [[BSModalDatePickerView alloc] initWithDate:[NSDate date]];
    datePicker.showTodayButton = YES;
    [datePicker presentInView:self.view
                    withBlock:^(BOOL madeChoice) {
                        if (madeChoice) {
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                            [dateFormatter setDateStyle:NSDateFormatterLongStyle];
                            self.dateLabel.text = [dateFormatter stringFromDate:datePicker.selectedDate];
                        }
                    }];
}

- (IBAction)onSelectMulti:(id)sender {
    NSArray *names = @[
                       @[
                        @"John",
                        @"Jane",
                        @"Bob",
                        @"Barbera"
                        ],
                       @[
                        @"Smith",
                        @"Doe",
                        @"Jones"
                        ]
                       ];

    BSModalPickerView *pickerView = [[BSModalPickerView alloc] initWithValues:names];
    pickerView.selectedIndexes = _lastSelectedIndexes;
    [pickerView presentInView:self.view
                    withBlock:^(BOOL madeChoice) {
                        if (madeChoice) {
                            _lastSelectedIndexes = pickerView.selectedIndexes;
                            self.multiLabel.text = [pickerView.selectedValues componentsJoinedByString:@" "];
                        }
                    }];

}

@end
