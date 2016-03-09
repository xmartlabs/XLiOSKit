//
//  XLCustomSheetView.m
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

#import "XLCustomSheetView.h"
#import "NSString+XLAdditions.h"
#import "UIColor+XLAdditions.h"
#import "UIImage+XLAdditions.h"

#import <QuartzCore/QuartzCore.h>

#define kButtonLeftRightMargin 0
#define kButtonTopBottomMargin 0
#define kButtonWidth           (self.frame.size.width - (2 * kButtonLeftRightMargin))
#define kButtonHeight          50
#define kButtonBorderWidth     0.5
#define kButtonBorderRadius    0

#ifdef __IPHONE_7_0

///////////////////////////////////////////////////////////////////////////////////
// Style constants used only for iOS 7

#define kBordersColor                       [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]
#define kDestructiveButtonFontColor         [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]
#define kOthersButtonsFontColor             [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]
#define kCancelButtonFontColor              [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]

#define kDestructiveButtonFontPressedColor  [UIColor colorWithRed:0.8471 green:0.2196 blue:0.2196 alpha:1.0]
#define kOthersButtonsFontPressedColor      [UIColor colorWithRed:0.251 green:0.251 blue:0.251 alpha:1.0]
#define kCancelButtonFontPressedColor       [UIColor colorWithRed:0.251 green:0.251 blue:0.251 alpha:1.0]

#define kDestructiveButtonBackground        [UIColor colorWithRed:0.6529 green:0.0313 blue:0.0313 alpha:0.8]
#define kCancelButtonBackground             [UIColor colorWithRed:0.251 green:0.251 blue:0.251 alpha:0.3]
#define kOtherButtonsBackground             [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3]
#define kHighlightedButtonBackground        [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3]

#define kTitleFontColor                     [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]
#define kTitleBackground                    [UIColor colorWithRed:0.251 green:0.251 blue:0.251 alpha:0.3]

#else

///////////////////////////////////////////////////////////////////////////////////
// Style constants used for other iOS version

#define kBordersColor                       [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]
#define kDestructiveButtonFontColor         [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]
#define kOthersButtonsFontColor             [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]
#define kCancelButtonFontColor              [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]

#define kDestructiveButtonFontPressedColor  [UIColor colorWithRed:0.8471 green:0.2196 blue:0.2196 alpha:1.0]
#define kOthersButtonsFontPressedColor      [UIColor colorWithRed:0.251 green:0.251 blue:0.251 alpha:1.0]
#define kCancelButtonFontPressedColor       [UIColor colorWithRed:0.251 green:0.251 blue:0.251 alpha:1.0]

#define kDestructiveButtonBackground        [UIColor colorWithRed:0.6529 green:0.0313 blue:0.0313 alpha:0.8]
#define kCancelButtonBackground             [UIColor colorWithRed:0.251 green:0.251 blue:0.251 alpha:0.3]
#define kOtherButtonsBackground             [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3]
#define kHighlightedButtonBackground        [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3]

#define kTitleFontColor                     [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]
#define kTitleBackground                    [UIColor colorWithRed:0.251 green:0.251 blue:0.251 alpha:0.3]

#endif

@interface XLCustomSheetView()

@property (nonatomic, strong) UIView *privateBackground;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UIView *buttonsContainer;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation XLCustomSheetView
{
    NSString *_title;
}

@synthesize background = _background;
@synthesize buttons = _buttons;
@synthesize buttonsContainer = _buttonsContainer;
@synthesize delegate = _delegate;
@synthesize privateBackground = _privateBackground;
@synthesize titleLabel = _titleLabel;

- (UIView *)background
{
    if (_background) return _background;
    
    _background = [[UIView alloc] initWithFrame:self.frame];
    _background.backgroundColor = [UIColor clearColor];
    _background.userInteractionEnabled = NO;
    return _background;
}

- (UIView *)buttonsContainer
{
    if (_buttonsContainer) return _buttonsContainer;
    
    _buttonsContainer = [[UIView alloc] initWithFrame:CGRectZero];
    _buttonsContainer.backgroundColor = [UIColor blackColor];
    _buttonsContainer.alpha = 0.85;
    
    return _buttonsContainer;
}

- (UIView *)privateBackground
{
    if (_privateBackground) return _privateBackground;
    
    _privateBackground = [[UIView alloc] initWithFrame:self.frame];
    
    _privateBackground.alpha = 0.5;
    _privateBackground.backgroundColor = [UIColor blackColor];
    _privateBackground.userInteractionEnabled = NO;
    
    return _privateBackground;
}

- (UILabel *)titleLabel
{
    if (_titleLabel) return _titleLabel;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.backgroundColor = kCancelButtonBackground;
    _titleLabel.textColor = kTitleFontColor;
    _titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    return _titleLabel;
}

- (id)initWithTitle:(NSString *)title delegate:(id<XLCustomSheetViewProtocol>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _title = title;
        self.delegate = delegate;
        self.buttons = [[NSMutableArray alloc] initWithCapacity:(2 + otherButtonTitles.count)];

        if (destructiveButtonTitle) {
            UIButton *btn = [self makeDestructiveButton:destructiveButtonTitle];
            btn.tag = 0;
            [self.buttons insertObject:btn atIndex:self.buttons.count];
        }
        
        if (otherButtonTitles) {
            for (id btnTitle in otherButtonTitles) {
                UIButton *btn = [self makeOtherButton:btnTitle];
                btn.tag = self.buttons.count;
                [self.buttons insertObject:btn atIndex:self.buttons.count];
            }
        }
    
        if (cancelButtonTitle) {
            UIButton *btn = [self makeCancelButton:cancelButtonTitle];
            btn.tag = self.buttons.count;
            [self.buttons insertObject:btn atIndex:self.buttons.count];
        }
        
        CGRect currentFrame = CGRectMake(kButtonLeftRightMargin, 2 * kButtonTopBottomMargin, kButtonWidth, kButtonHeight);

        if (title) {
            self.titleLabel.frame = currentFrame;
            self.titleLabel.text = title;
            [self.buttonsContainer addSubview:self.titleLabel];
            currentFrame = CGRectMake(kButtonLeftRightMargin, currentFrame.origin.y + kButtonHeight + 2 * kButtonTopBottomMargin, kButtonWidth, kButtonHeight);
        }

        for (UIButton *btn in self.buttons) {
            btn.frame = currentFrame;
            [self.buttonsContainer addSubview:btn];
            currentFrame = CGRectMake(kButtonLeftRightMargin, currentFrame.origin.y + kButtonHeight + 2 * kButtonTopBottomMargin, kButtonWidth, kButtonHeight);
        }
        
        self.buttonsContainer.frame = CGRectMake(0, self.frame.size.height - currentFrame.origin.y, self.frame.size.width, currentFrame.origin.y);
        
        [self addSubview:self.privateBackground];
        [self addSubview:self.background];
        [self addSubview:self.buttonsContainer];
    }
    
    return self;
}

-(void)show
{
    UIView *view = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    [view addSubview:self];

    __typeof__(self) __weak weakSelf = self;

//        UIGraphicsBeginImageContext(CGSizeMake(320,480));
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        [weakSelf.superview.layer renderInContext:context];
//        UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//    
//        CIContext *ciContext = [CIContext contextWithOptions:nil];
//        CIImage *inputImage = [CIImage imageWithCGImage:screenShot.CGImage];
//    
//        // setting up Gaussian Blur (we could use one of many filters offered by Core Image)
//        CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
//        [filter setValue:inputImage forKey:kCIInputImageKey];
//        [filter setValue:[NSNumber numberWithFloat:5.0f] forKey:@"inputRadius"];
//        CIImage *result = [filter valueForKey:kCIOutputImageKey];
//    
//        // CIGaussianBlur has a tendency to shrink the image a little,
//        // this ensures it matches up exactly to the bounds of our original image
//        CGImageRef cgImage = [ciContext createCGImage:result fromRect:[inputImage extent]];
    
    CGRect finalAnimationFrame = self.buttonsContainer.frame;
    CGRect initialAnimationFrame = finalAnimationFrame;
    initialAnimationFrame.origin.y = self.frame.size.height + 1;
    
    self.buttonsContainer.frame = initialAnimationFrame;
    [self.background setAlpha:0];

    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.buttonsContainer.frame = finalAnimationFrame;
        weakSelf.privateBackground.alpha = 0.5;
        weakSelf.background.alpha = 1.0;
    } completion:^(BOOL finished) {
//        [self.privateBackground addSubview:[[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:cgImage]]];
    }];
}

- (void)hide
{
    __typeof__(self) __weak weakSelf = self;
    [UIView animateWithDuration:0.3
                     animations:^{
                         weakSelf.buttonsContainer.frame = CGRectMake(0, weakSelf.frame.size.height, weakSelf.buttonsContainer.frame.size.width, weakSelf.buttonsContainer.frame.size.height);
                         weakSelf.privateBackground.alpha = 0.0;
                         weakSelf.background.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [weakSelf removeFromSuperview];
                     }
     ];
}

#pragma mark - Auxiliary functions

- (UIButton *)makeCancelButton:(NSString *)title
{
    UIButton *btn = [self makeBaseButton:title];
    [btn setTitleColor:kCancelButtonFontColor forState:UIControlStateNormal];
    [btn setBackgroundColor:kCancelButtonBackground];
    [btn setTitleColor:kCancelButtonFontPressedColor forState:UIControlStateHighlighted];
    
    return btn;
}


- (UIButton *)makeDestructiveButton:(NSString *)title
{
    UIButton *btn = [self makeBaseButton:title];
    [btn setBackgroundColor:kDestructiveButtonBackground];
    [btn setTitleColor:kDestructiveButtonFontColor forState:UIControlStateNormal];
    [btn setTitleColor:kDestructiveButtonFontPressedColor forState:UIControlStateHighlighted];
    
    UIView *topShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 3)];
    topShadow.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    topShadow.backgroundColor = [UIColor colorWithWhite:1 alpha:0.16];
    [btn addSubview:topShadow];
    
    return btn;
}

- (UIButton *)makeOtherButton:(NSString *)title
{
    UIButton *btn = [self makeBaseButton:title];
    [btn setBackgroundColor:kOtherButtonsBackground];
    [btn setTitleColor:kOthersButtonsFontColor forState:UIControlStateNormal];
    [btn setTitleColor:kOthersButtonsFontPressedColor forState:UIControlStateHighlighted];
    
    return btn;
}

- (UIButton *)makeBaseButton:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.alpha = 1.0;
    btn.layer.borderColor = kBordersColor.CGColor;
    btn.layer.borderWidth = kButtonBorderWidth;
    btn.layer.cornerRadius = kButtonBorderRadius;
    
    [btn setBackgroundImage:[UIImage imageWithColor:kHighlightedButtonBackground] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];

    [btn addTarget:self action:@selector(buttonDidTouch:) forControlEvents:UIControlEventTouchUpInside];

    return btn;
}

- (void)buttonDidTouch:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(xlActionSheet:clickedButtonWithTitle:)]) {
        [self.delegate xlActionSheet:self clickedButtonWithTitle:sender.titleLabel.text];
    }
    [self hide];
}

@end
