//
//  UIView+XLAdditions.m
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

#import "UIView+XLAdditions.h"

@implementation UIView (XLAdditions)


-(void)sendToBack
{
    [self.superview sendSubviewToBack:self];
}

+(id)autolayoutView
{
    UIView *view = [self new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}


-(NSLayoutConstraint *)layoutConstraintSameHeightOf:(UIView *)view
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f];
}


-(NSLayoutConstraint *)layoutConstraintSameWidthOf:(UIView *)view
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f];
}

-(NSLayoutConstraint *)layoutConstraintSameLeftOf:(UIView *)view offset:(CGFloat)offset
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:offset];
}

-(NSLayoutConstraint *)layoutConstraintSameRightOf:(UIView *)view offset:(CGFloat)offset
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1.0f constant:offset];
}

-(NSLayoutConstraint *)layoutConstraintSameTopOf:(UIView *)view offset:(CGFloat)offset
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.0f constant:offset];
}

-(NSLayoutConstraint *)layoutConstraintSameBaselineOf:(UIView *)view offset:(CGFloat)offset
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBaseline relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBaseline multiplier:1.0f constant:offset];
}

-(NSLayoutConstraint *)layoutConstraintSameBottomOf:(UIView *)view offset:(CGFloat)offset
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:offset];
}

-(NSLayoutConstraint *)layoutConstraintSameCenterXOf:(UIView *)view offset:(CGFloat)offset
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:offset];
}

-(NSLayoutConstraint *)layoutConstraintSameCenterYOf:(UIView *)view offset:(CGFloat)offset
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:offset];
}

-(UIView *)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    return nil;
}

-(UIView *)superviewOfType:(Class)superviewClass
{
    if (!self.superview) return nil;
    if ([self.superview isKindOfClass:superviewClass]){
        return self.superview;
    }
    return [self.superview superviewOfType:superviewClass];
}

-(UIView *)subviewOfType:(Class)subviewClass
{
    if ([self isKindOfClass:subviewClass]) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *view = [subView subviewOfType:subviewClass];
        if (view) {
            return view;
        }
    }
    return nil;
}

@end
