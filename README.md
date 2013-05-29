BSModalPickerView
=================

## BSModalPickerView

A custom view component that presents a `UIPickerView` with a simple list of options, 
along with a toolbar for Done/Cancel and an optional faded backdrop view.

## BSModalDatePickerView

A custom view component that presents a `UIDatePicker` with a toolbar for Done/Cancel,
and an optional Today button.

## Usage

Usage is easy:

Add the dependency to your `Podfile`. You can add the whole library:

```ruby
platform :ios
pod 'BSModalPickerView'
...
```

Or, alternatively, you can add just the component you want to use:

```ruby
platform :ios
pod 'BSModalPickerView/BSModalPickerView' # or 'BSModalPickerView/BSModalDatePickerView'
...
```

Run `pod install` to install the dependencies.

Next, import the header file wherever you want to use the picker:

```objc
#import <BSModalPickerView/BSModalPickerView.h> // or <BSModalPickerView/BSModalDatePickerView.h>
```

Finally, present the picker when necessary (say on a button touch handler):

```objc
self.values = @[ @"Apples", @"Bananas", @"Grapes" ];
BSModalPickerView *picker = [[BSModalPickerView alloc] initWithValues:self.values];
[picker presentInView:self.view withBlock:^(BOOL madeChoice) {
  if (madeChoice) {
    NSLog(@"You chose index %d, which was the value %@", 
      picker.selectedIndex,
      picker.selectedValue);
  } else {
    NSLog(@"You cancelled the picker");
  }
}];
```

```objc
BSModalDatePickerView *datePicker = [[BSModalDatePickerView alloc] initWithDate:[NSDate date]];
[datePicker presentInView:self.view withBlock:^(BOOL madeChoice) {
  if (madeChoice) {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    NSLog(@"You chose the date %@", 
      [dateFormatter stringFromDate:datePicker.selectedDate]);
  }
}];
```

## Requirements

`BSModalPickerView` requires iOS 5.x or greater.


## License

Usage is provided under the [MIT License](http://http://opensource.org/licenses/mit-license.php).  See LICENSE for the full details.
