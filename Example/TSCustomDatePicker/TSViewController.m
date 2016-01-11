//
//  TSViewController.m
//  TSCustomDatePicker
//
//  Created by Michael Traverso on 01/10/2016.
//  Copyright (c) 2016 Michael Traverso. All rights reserved.
//

#import "TSViewController.h"
#import <TSCustomDatePicker/TSCustomDatePicker.h>

@interface TSViewController () <TSCustomDatePickerDelegate>

@end

@implementation TSViewController {
    
    TSCustomDatePicker *datePicker;
    IBOutlet UILabel *lblDatePicked;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:30];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
    
    datePicker = [[TSCustomDatePicker alloc] initWithFrame:CGRectZero       // Set frame or use CGRectZero or autolayout as below
                                                   maxDate:maxDate          // Use any valid date. Must be after minDate
                                                   minDate:[NSDate date]    // Use any valid date.
                                           backgroundColor:[UIColor clearColor] // Set the picker background color
                                                      font:[UIFont fontWithName:@"Avenir-Black" size:24.f]  // Set font
                                                 fontColor:[UIColor blackColor]]; // Set the font color
    
    [datePicker setPickerBackgroundColor:[UIColor lightGrayColor]];
    [datePicker setPickerRadius:15.f];
    [datePicker setDelegate:self];
    
    // Set or overide values set in the init method
    // [datePicker setPickerFont:[UIFont fontWithName:@"Helvetica" size:19.f]];
    // [datePicker setPickerFontColor:[UIColor redColor]];
    
    [self.view addSubview:datePicker];
    
    [self setSizeAndPosition];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setSizeAndPosition {
    
    // Use autolayout to set the width, height, x position and y position
    NSMutableArray *layoutConstraints = [NSMutableArray array];
    [layoutConstraints addObject:[NSLayoutConstraint constraintWithItem:datePicker
                                                              attribute:NSLayoutAttributeCenterX
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeCenterX
                                                             multiplier:1.f
                                                               constant:0.f]];
    
    [layoutConstraints addObject:[NSLayoutConstraint constraintWithItem:datePicker
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeCenterY
                                                             multiplier:1.f
                                                               constant:0.f]];
    
    [layoutConstraints addObject:[NSLayoutConstraint constraintWithItem:datePicker
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0f
                                                               constant:220.0]];
    
    [layoutConstraints addObject:[NSLayoutConstraint constraintWithItem:datePicker
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0f
                                                               constant:320.0]];
    [self.view addConstraints:layoutConstraints];
}

#pragma mark - TSCustomDatePickerDelegate

- (void) dateChanged:(TSCustomDatePicker *)picker {
        
    if ([picker isEqual:datePicker]){
        
        // Do something with the date that's been selected
        [lblDatePicked setText:[NSString stringWithFormat:@"%@", picker.date]];
        NSLog(@"Selected date = %@", picker.date);
    }
}

@end
