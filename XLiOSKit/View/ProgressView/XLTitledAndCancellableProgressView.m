//
//  XLTitledAndCancellableProgressView.m
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

#import "XLTitledAndCancellableProgressView.h"

#import "XLCustomProgressView.h"
#import "UIColor+XLAdditions.h"

#import <QuartzCore/QuartzCore.h>

#define LEFT_RIGHT_MARGIN    7
#define TOP_BOTTOM_MARGIN    7
#define PROGRESS_VIEW_HEIGHT 3
#define BUTTONS_WIDTH        (self.frame.size.height + 5)

#define BORDER_COLOR        0x999999
#define TEXT_COLOR          0x272727

// font size 16 and 18

@interface XLTitledAndCancellableProgressView()
{
    NSInteger _progress;
}

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) XLCustomProgressView *progressView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation XLTitledAndCancellableProgressView

@synthesize backgroundView = _backgroundView;
@synthesize cancelButton = _cancelButton;
@synthesize progressView = _progressView;
@synthesize retryButton = _retryButton;
@synthesize title = _title;
@synthesize titleLabel = _titleLabel;

- (UIView *)backgroundView
{
    if (_backgroundView) return _backgroundView;
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _backgroundView.backgroundColor = [UIColor blackColor];

    [_backgroundView setAlpha:0.5];
    [_backgroundView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_backgroundView setBackgroundColor:[UIColor colorWithHex:0xd6d6d6]];
    return _backgroundView;
}

- (UIButton *)cancelButton
{
    if (_cancelButton) return _cancelButton;
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // Make a square button right aligned
    _cancelButton.frame = CGRectMake(self.frame.size.width - BUTTONS_WIDTH, 0, BUTTONS_WIDTH, self.frame.size.height);
    
    [_cancelButton setTitle:@"x" forState:UIControlStateNormal];
    [_cancelButton setShowsTouchWhenHighlighted:YES];
    [_cancelButton setImageEdgeInsets:UIEdgeInsetsMake(2, 3, 0, 0)];

    UIView *separatorLabel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.frame.size.height)];
    [separatorLabel setBackgroundColor:[UIColor colorWithHex:BORDER_COLOR]];
    [_cancelButton addSubview:separatorLabel];
    
    return _cancelButton;
}

- (UIButton *)retryButton
{
    if (_retryButton) return _retryButton;
    
    _retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _retryButton.frame = CGRectMake(self.cancelButton.frame.origin.x - BUTTONS_WIDTH, 0, BUTTONS_WIDTH, self.frame.size.height);
    [_retryButton setHidden:YES];
    [_retryButton setTitle:@"r" forState:UIControlStateNormal];
    [_retryButton setShowsTouchWhenHighlighted:YES];
    [_retryButton setImageEdgeInsets:UIEdgeInsetsMake(1, 1, 0, 0)];
     
    
    UIView *separatorLabel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.frame.size.height)];
    [separatorLabel setBackgroundColor:[UIColor colorWithHex:BORDER_COLOR]];
    // TODO: set alpha to separator label
    [_retryButton addSubview:separatorLabel];
    
    return _retryButton;
}

- (NSString *)title
{
    return self.titleLabel.text;
}

- (UILabel *)titleLabel
{
    if (_titleLabel) return _titleLabel;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, TOP_BOTTOM_MARGIN + 3, 100, 20)];
    _titleLabel.layer.zPosition = 1;
    _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f];
    
    [_titleLabel setBackgroundColor:[UIColor redColor]];
    
    [_titleLabel setNumberOfLines:1];
    [_titleLabel setTextColor:[UIColor colorWithHex:TEXT_COLOR]];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    return _titleLabel;
}

- (void)setTitle:(NSString *)title
{
    [self.titleLabel setText:title];
    [self.titleLabel sizeToFit];
    
    // Adjust left margin of label to get a right alignment
    CGRect frame = _titleLabel.frame;
    frame.origin.x = self.frame.size.width - frame.size.width - LEFT_RIGHT_MARGIN - self.cancelButton.frame.size.width;
    // Add some padding
    frame.size.width += 4;
    frame.size.height += 2;
    _titleLabel.frame = frame;
}

- (void)setRetryButtonHidden:(BOOL)hidden
{
    [self.retryButton setHidden:hidden];
    [self.progressView setHidden:!hidden];
    [self updateComponentsFrames];
}

- (void)setTitleColor:(UIColor *)color
{
    [self.titleLabel setTextColor:color];
}

- (id)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor progressBackgroundColor:(UIColor *)progressBackgroundColor progressColor:(UIColor *)progressColor progress:(NSUInteger)progress
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[backgroundColor colorWithAlphaComponent:0.75]];
        
        _progressView = [[XLCustomProgressView alloc] initWithFrame:CGRectMake(LEFT_RIGHT_MARGIN, TOP_BOTTOM_MARGIN, self.frame.size.width - 2 * LEFT_RIGHT_MARGIN - self.cancelButton.frame.size.width - 1, 3)
                                                    backgroundColor:progressBackgroundColor
                                                      progressColor:progressColor
                                                           progress:progress];
        _progressView.backgroundColor = [UIColor greenColor];
        [_progressView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [self addSubview:self.progressView];
        [self addSubview:self.retryButton];
        [self addSubview:self.cancelButton];
        [self setTitle:@"Processing..."];
        [self addSubview:self.titleLabel];
    }
    return self;
}

-(void)setProgress:(NSUInteger)progress animated:(BOOL)animated
{
    _progress = progress;
    [self.progressView setProgress:progress animated:animated];
}

-(void)done
{
    [self setProgress:100 animated:YES];
}

-(void)updateComponentsFrames
{
    ///////////////////////////////////////////////////////////////////////////////////
    // Set the title label frame
    CGFloat width = self.titleLabel.frame.size.width;
    CGFloat left;
    if (self.retryButton.hidden) {
        left = self.frame.size.width - width - LEFT_RIGHT_MARGIN - self.cancelButton.frame.size.width;
    } else {
        left = self.frame.size.width - width - LEFT_RIGHT_MARGIN - self.cancelButton.frame.size.width - self.retryButton.frame.size.width;
    }

    CGFloat top;
    if (self.progressView.hidden) {
        top = TOP_BOTTOM_MARGIN - PROGRESS_VIEW_HEIGHT + 1;
    } else {
        top = TOP_BOTTOM_MARGIN + 3;
    }
    self.titleLabel.frame = CGRectMake(left, top, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    ///////////////////////////////////////////////////////////////////////////////////
}

@end
