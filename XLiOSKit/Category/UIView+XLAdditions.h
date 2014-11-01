//
//  UIView+XLAdditions.h
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

#import <UIKit/UIKit.h>

@interface UIView (XLAdditions)

-(void)sendToBack;

+(id)autolayoutView;

-(NSLayoutConstraint *)layoutConstraintSameHeightOf:(UIView *)view;
-(NSLayoutConstraint *)layoutConstraintSameWidthOf:(UIView *)view;
-(NSLayoutConstraint *)layoutConstraintSameLeftOf:(UIView *)view offset:(CGFloat)offset;
-(NSLayoutConstraint *)layoutConstraintSameRightOf:(UIView *)view offset:(CGFloat)offset;
-(NSLayoutConstraint *)layoutConstraintSameTopOf:(UIView *)view offset:(CGFloat)offset;
-(NSLayoutConstraint *)layoutConstraintSameBaselineOf:(UIView *)view offset:(CGFloat)offset;
-(NSLayoutConstraint *)layoutConstraintSameBottomOf:(UIView *)view offset:(CGFloat)offset;
-(NSLayoutConstraint *)layoutConstraintSameCenterXOf:(UIView *)view offset:(CGFloat)offset;
-(NSLayoutConstraint *)layoutConstraintSameCenterYOf:(UIView *)view offset:(CGFloat)offset;

- (UIView *)findFirstResponder;

-(UIView *)superviewOfType:(Class)superviewClass;
-(UIView *)subviewOfType:(Class)subviewClass;

@end
