//
//  BSModalFloatPickerView.h
//
//  Created by Daryll Herberger on 10/28/13.
//

#import "BSModalPickerBase.h"

typedef enum {
    ModalFloatPickerNone = 0,
    ModalFloatPickerOneSigFig = 1,      ///< Picker should support one significant figure of precision
	ModalFloatPickerTwoSigFig = 2,		///< Picker should support two significant figures of precision
    ModalFloatPickerThreeSigFig = 3		///< Picker should support three significant figures of precision
} ModalFloatPickerPrecision;            ///< @enum Modal Float Picker Precision Enumeration

@interface BSModalFloatPickerView : BSModalPickerBase<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) CGFloat maxValue;
@property (nonatomic) CGFloat selectedValue;
@property (nonatomic) ModalFloatPickerPrecision precision;

@end
