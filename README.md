BSModalPickerView
=================

A custom view component that presents a UIPickerView with a simple list of options, 
along with a toolbar for Done/Cancel and a faded backdrop view.

BSModalDatePickerView
=====================

A custom view component that presents a UIDatePicker 
along with a toolbar for Done/Cancel and a faded backdrop view.

## Usage

Usage is easy:

Add the dependency to your `Podfile`:

```ruby
platform :ios
pod 'BSModalPickerView'
...
```

Run `pod install` to install the dependencies.

Next, import the header file wherever you want to use the picker:

```objc
#import "BSModalPickerView.h"
```

Finally, present the picker when necessary (say on a button touch handler):

```objc
self.values = @[ @"Apples", @"Bananas", @"Grapes" ];
BSModalPickerView *picker = [[PSModalPickerView alloc] initWithValues:self.values];
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
#import "BSModalDatePickerView.h"
```

Finally, present the date picker when necessary (say on a button touch handler):

```objc
BSModalDatePickerView *picker = [[BSModalDatePickerView alloc] initWithDate:[NSDate now]];
picker.mode = UIDatePickerModeDate;
[picker presentInView:self.view withBlock:^(BOOL madeChoice) {
  if (madeChoice) {
    NSLog(@"You selected date %@", picker.seletedDate);
  } else {
    NSLog(@"You cancelled the picker");
  }
}];
```

## Requirements

`BSModalPickerView` and `BSModalDatePickerView` requires iOS 4.x or greater.


## License

Usage is provided under the [MIT License](http://http://opensource.org/licenses/mit-license.php).  See LICENSE for the full details.
