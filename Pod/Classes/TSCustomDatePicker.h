//
//  TSCustomDatePicker.h
//  Pods
//
//  Created by Michael R Traverso on 1/10/16.
//
//

#import <Foundation/Foundation.h>

@protocol TSCustomDatePickerDelegate <NSObject>

@optional
-(void)dateChanged:(id _Nonnull)sender;
@end

@interface TSCustomDatePicker : UIControl

@property (nullable, nonatomic, weak) id<TSCustomDatePickerDelegate> delegate;
@property (nullable, nonatomic, strong) NSDate *date;

/**
 CGRect frame  - The frame in which the control will exist.
 
 NSDate *maxDate - The maximum date for which the date picker will 
    allow date selection of. This date must be after the minDate
**/
- (id _Nonnull)initWithFrame:( CGRect ) frame
                     maxDate:( NSDate * _Nonnull ) maxDate;

/**
 CGRect frame  - The frame in which the control will exist.
 
 NSDate *maxDate - The maximum date for which the date picker will 
    allow date selection of. This date must be after the minDate
 
 NSDate *minDate - The minimum date for which the date picker will 
    allow date selection of. This date must be prior to the maxDate 
    if supplied. If not supplied this will be the earliest date 
    allowed (e.g. [NSDate dateWithTimeIntervalSince1970:0])
 
 UIColor *backgroundColor - The background color. If nil is supplied
    the background color will be clear.
 
 UIFont *font - The font to be used. If nil is supplied the font 
    will be the system font... boring!
 
 UIColor *fontColor - The color of the font used in the date picker. 
    If nil is supplied the font color will be black.
 **/

- (id _Nonnull)initWithFrame:( CGRect ) frame
                     maxDate:( NSDate * _Nonnull ) maxDate
                     minDate:( NSDate * _Nullable ) minDate
             backgroundColor:( UIColor * _Nullable ) backgroundColor
                        font:( UIFont  * _Nullable ) font
                   fontColor:( UIColor * _Nullable ) fontColor;

- (void)setPickerFont:(UIFont* _Nonnull) font;
- (void)setPickerFontColor:(UIColor* _Nonnull) fontColor;
- (void)setPickerBackgroundColor:(UIColor* _Nonnull)color;
- (void)setPickerRadius:(CGFloat)radius;

@end