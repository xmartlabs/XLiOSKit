//
//  XLPickerViewController.m
//  XLiOSKit
//
// Copyright (c) 2013 Xmartlabs (http://xmartlabs.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "XLCustomPickerView.h"
#import "XLKit.h"

#import <QuartzCore/QuartzCore.h>

@interface XLCustomPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSInteger _selectedRow;
}

@property (nonatomic, strong) UIView *background;
@property (nonatomic, strong) UIBarButtonItem *doneButton;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIView *container;

@end

@implementation XLCustomPickerView

@synthesize background = _background;
@synthesize doneButton = _doneButton;
@synthesize pickerView = _pickerView;
@synthesize selectedRow = _selectedRow;
@synthesize toolbar = _toolbar;
@synthesize container = _container;


-(void)showInView:(UIView *)view
{
    self.frame = view.bounds;
    self.background.frame = self.bounds;
    self.container.frame = CGRectMake(0, self.frame.size.height - (44 + 216), 320, 44 + 216);
    
    CGRect finalAnimationFrame = self.container.frame;
    
    CGRect initialAnimationFrame = finalAnimationFrame;
    initialAnimationFrame.origin.y =  initialAnimationFrame.origin.y + 44 + 216;
    
    self.container.frame = initialAnimationFrame;
    [self.background setAlpha:0];
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.container.frame = finalAnimationFrame;
        self.background.alpha = 0.2;
    }];
}


- (UIView *)background
{
    if (_background) return _background;
    
    _background = [[UIView alloc] initWithFrame:self.bounds];
    _background.backgroundColor = [UIColor blackColor];
    _background.alpha = 0.2;
    return _background;
}

-(UIView *)container
{
    if (_container) return _container;
    _container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44 + 216)]; // has to be changed by properly position.
    if (!IOS_6){
        _container.backgroundColor = [UIColor whiteColor];
    }
    return _container;
}

- (UIToolbar *)toolbar
{
    if (_toolbar) return _toolbar;
    
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    _toolbar.barStyle = UIBarStyleBlackTranslucent;
    if (!IOS_6) {
        _toolbar.tintColor = [UIColor whiteColor];
    }
    [_toolbar sizeToFit];
    CGSize size = _toolbar.frame.size;   // 44 height
    _toolbar.frame = CGRectMake(0, 0, size.width, size.height);
    
    
    UIBarButtonItem *blankSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelButtonDidTouch:)];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonDidTouch:)];
    self.doneButton = doneButton;
    
    [_toolbar setItems:@[cancelButton, blankSpace, doneButton]];
    
    return _toolbar;
}

- (UIPickerView *)pickerView
{
    if (_pickerView) return _pickerView;
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    _pickerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _pickerView.showsSelectionIndicator = YES;
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    [_pickerView sizeToFit];
    CGSize pickerSize = _pickerView.frame.size; // 216 height
    _pickerView.frame = CGRectMake(0, 44, pickerSize.width, pickerSize.height);
    return _pickerView;
}

- (NSInteger)selectedRow
{
    return _selectedRow;
}

- (void)setSelectedRow:(NSInteger)row
{
    _selectedRow = row >= self.pickerData.count ? self.pickerData.count - 1 : row;
    [self.pickerView selectRow:_selectedRow inComponent:0 animated:YES];
}



- (id)initWithData:(NSArray *)pickerData
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _pickerData = pickerData;
        _selectedRow = 0;
        
        [self addSubview:self.background];
        [self addSubview:self.container];
        [self.container addSubview:self.toolbar];
        [self.container addSubview:self.pickerView];
    }
    return self;
}

- (void)doneButtonDidTouch:(id)sender
{
    [self dismissActionSheet:YES];
    [self.delegate doneWithSelectedRow:_selectedRow];
}

- (void)cancelButtonDidTouch:(id)sender
{
    [self dismissActionSheet:YES];
    [self.delegate cancel];
}

-(void)dismissActionSheet:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            self.container.frame = CGRectMake(0, self.bounds.size.height, self.container.frame.size.width, self.container.frame.size.height);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    });
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectedRow = row;
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view
{
    UILabel *rowView = (UILabel *)view;
    if (!rowView) {
        rowView =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 20, 44)];
        rowView.backgroundColor = [UIColor clearColor];
        rowView.font = [rowView.font fontWithSize:20];
    }
    rowView.text = [_pickerData objectAtIndex:row];
    [rowView sizeToFit];
    
    return rowView;
}


@end