//
//  TSCustomDatePicker.m
//  Pods
//
//  Created by Michael R Traverso on 1/10/16.
//
//

#import "TSCustomDatePicker.h"


@interface TSCustomDatePicker () <UIPickerViewDataSource, UIPickerViewDelegate> {
    
    NSInteger _days, _months, _selectedMonth, _selectedDay, _selectedYear;
    UIView *bgView;
}

@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;
@property (nonatomic, strong) UIColor* bgColor;
@property (nonatomic, strong) UIFont* font;
@property (nonatomic, strong) UIColor* fontColor;
@property (nonatomic) BOOL showOnlyValidDates;

@end

@implementation TSCustomDatePicker

- (id)initWithFrame:(CGRect)frame
            maxDate:(NSDate *)maxDate {

    self = [self initWithFrame:frame maxDate:maxDate minDate:nil backgroundColor:nil font:nil fontColor:nil];
    if (!self) {
    
        return nil;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
            maxDate:(NSDate *)maxDate
            minDate:(NSDate *)minDate
    backgroundColor:(UIColor*)backgroundColor
               font:(UIFont*)font
          fontColor:(UIColor*)fontColor {
    
    self = [super initWithFrame:frame];
    
    if (!self) {
        
        return nil;
    }
    
    assert(maxDate && ([minDate compare:maxDate] != NSOrderedDescending));
    
    self.minDate = minDate ? minDate : [NSDate dateWithTimeIntervalSince1970:0];
    self.maxDate = maxDate;
    self.font = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    self.fontColor = fontColor ? fontColor : [UIColor blackColor];
    self.bgColor = backgroundColor ? backgroundColor : [UIColor clearColor];
    
    [self initDefaultDatePicker];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (!self) {
        
        return nil;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (!self) {
    
        return nil;
    }
    
    return self;
}

- (void)initDefaultDatePicker {
    
    self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    self.picker = [[UIPickerView alloc] initWithFrame:self.bounds];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.translatesAutoresizingMaskIntoConstraints = NO;

    bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    bgView.translatesAutoresizingMaskIntoConstraints = NO;
    bgView.backgroundColor = self.bgColor;
    [self addSubview:bgView];
    
    [self initDate];
    
    [self showDateOnPicker:self.date];
    
    [self addSubview:self.picker];
}

-(void)showDateOnPicker:(NSDate *)date {
    
    self.date = date;
    
    NSDateComponents *components = [self.calendar
                                    components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                    fromDate:self.date];
    
    _selectedYear = [components year];
    _selectedMonth = [components month];
    _selectedDay = [components day];
    [self.picker selectRow:_selectedMonth-1 inComponent:0 animated:YES];
    [self.picker selectRow:_selectedDay-1 inComponent:1 animated:YES];
    [self.picker selectRow:_selectedYear inComponent:2 animated:YES];
    _days = [self numberOfDaysInMonth:_selectedMonth andYear:_selectedYear];
    [self.picker reloadComponent:1];
    [self.picker reloadComponent:1];
    [self.picker reloadComponent:2];
}

-(void)initDate {
    
    NSDateComponents *components = [self.calendar components:NSCalendarUnitMonth
                                                    fromDate:self.minDate
                                                      toDate:self.maxDate
                                                     options:0];
    _months = components.month + 1;
    
    NSDate *dateToPresent;
    if ([self.minDate compare:[NSDate date]] == NSOrderedDescending) {
        
        dateToPresent = self.minDate;
    }
    else if ([self.maxDate compare:[NSDate date]] == NSOrderedAscending) {
        
        dateToPresent = self.maxDate;
    }
    else {
        
        dateToPresent = [NSDate date];
    }
    
    self.date = dateToPresent;
}

- (void)setPickerFont:(UIFont*) font {

    self.font = font;
    if (self.picker) {
        
        [self.picker reloadAllComponents];
    }
}

- (void)setPickerFontColor:(UIColor*) fontColor {
    
    self.fontColor = fontColor;
    if (self.picker) {
        
        [self.picker reloadAllComponents];
    }
}

- (void)setPickerBackgroundColor:(UIColor*)color {
    
    self.bgColor = color;
    [bgView setBackgroundColor:self.bgColor];
}

- (void)setPickerRadius:(CGFloat)radius {

    bgView.layer.cornerRadius = radius;
}

#pragma mark - UIPickerViewDelegate & Datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 3;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        return formatter.monthSymbols.count;
    }
    else if (component == 1) {
        
        return [self numberOfDaysInMonth:_selectedMonth andYear:_selectedYear];
    }
    else {
        
        NSDateComponents *components = [self.calendar components:NSCalendarUnitYear
                                                        fromDate:self.minDate
                                                          toDate:self.maxDate
                                                         options:0];
        return components.year;
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    switch (component) {
            
        case 0:
            return 150;
            break;
        case 1:
            return 30;
            break;
        case 2:
            return 90;
            break;
        default:
            return 0;
            break;
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 35;
}

-(UIView *)pickerView:(UIPickerView *)pickerView
           viewForRow:(NSInteger)row
         forComponent:(NSInteger)component
          reusingView:(UIView *)view {
    
    UILabel *lblDate = [[UILabel alloc] init];
    [lblDate setFont:self.font];
    [lblDate setTextColor:self.fontColor];
    
    if (component == 0) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [NSLocale currentLocale];
        formatter.dateFormat = @"MMMMM";
        [lblDate setText:[[formatter monthSymbols] objectAtIndex:row]];
        lblDate.textAlignment = NSTextAlignmentLeft;
    }
    else if (component == 1) {
        
        [lblDate setText:[NSString stringWithFormat:@"%02ld", row+1]];
        lblDate.textAlignment = NSTextAlignmentRight;
    }
    else if (component == 2) {
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setYear:row];
        NSDate *newDate = [calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
        components = [calendar components:NSCalendarUnitYear fromDate:newDate];
        [lblDate setText:[NSString stringWithFormat:@"%ld",components.year]];
        lblDate.textAlignment = NSTextAlignmentRight;
    }
    
    return lblDate;
}

-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component {
    
    if (component == 0) {
        
        _selectedMonth = row+1;

        _days = [self numberOfDaysInMonth:_selectedMonth andYear:_selectedYear];
        if ([pickerView numberOfRowsInComponent:1] != _days) {
            
            if (_selectedDay == [pickerView numberOfRowsInComponent:1]) {
                
                if (_days <= _selectedDay) {

                    _selectedDay = _days;
                }
            }
            
            [pickerView reloadComponent:1];
        }
    }
    else if (component == 1) {
        
        _selectedDay = row + 1;
    }
    else if (component == 2) {
        
        NSDateComponents *components = [self.calendar components:NSCalendarUnitYear
                                                        fromDate:self.minDate];
        _selectedYear = components.year + row;
        _days = [self numberOfDaysInMonth:_selectedMonth andYear:_selectedYear];
        if ([pickerView numberOfRowsInComponent:1] != _days) {
            
            if (_selectedDay == [pickerView numberOfRowsInComponent:1]) {
                
                if (_days <= _selectedDay) {
                    
                    _selectedDay = _days;
                }
            }
            
            [pickerView reloadComponent:1];
        }
    }
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = _selectedYear;
    components.month = _selectedMonth;
    components.day = _selectedDay;
    self.date = [self.calendar dateFromComponents:components];
    
    if ([self.date compare:self.minDate] == NSOrderedAscending) {
        
        [self showDateOnPicker:self.minDate];
    }
    else if ([self.date compare:self.maxDate] == NSOrderedDescending) {
        
        [self showDateOnPicker:self.maxDate];
    }
    
    if ((self.delegate) && ([self.delegate respondsToSelector:@selector(dateChanged:)])) {
        
        [self.delegate dateChanged:self];
    }
}

#pragma mark - Utility methods

- (int)numberOfDaysInMonth:(NSInteger)month andYear:(NSInteger)year {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    
    NSDate *date = [calendar dateFromComponents:components];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return (int)range.length;
}

@end

