//
//  UIButton+XLAdditions.m
//  XLiOSKit
//
//  Created by Martin Barreto on 11/1/14.
//  Copyright (c) 2014 Xmartlabs. All rights reserved.
//
#import "UIView+XLAdditions.h"
#import "UIButton+XLAdditions.h"

@implementation UIButton (XLAdditions)

-(UIActivityIndicatorView *)addActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)style
{
    [self setTitle:@"" forState:UIControlStateDisabled];
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:@"" attributes:@{}];
    [self setAttributedTitle:attributedText forState:UIControlStateDisabled];
    self.enabled = NO;
    UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    [activityIndicator startAnimating];
    activityIndicator.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    [self addSubview:activityIndicator];
    return activityIndicator;
}


-(void)removeActivityIndicator
{
    UIActivityIndicatorView * activityIndicator = (UIActivityIndicatorView *)[self subviewOfType:[UIActivityIndicatorView class]];
    [activityIndicator removeFromSuperview];
    self.enabled = YES;
}


@end
