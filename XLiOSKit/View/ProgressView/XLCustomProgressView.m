//
//  XLCustomProgressView.m
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

#import "XLCustomProgressView.h"

@interface XLCustomProgressView()

@property (nonatomic, strong) UIView * backgroundView;
@property (nonatomic, strong) UIView * progressView;
@property (nonatomic)  NSUInteger progress;

@end

@implementation XLCustomProgressView


@synthesize backgroundView  = _backgroundView;
@synthesize progressView    = _progressView;
@synthesize progress        = _progress;


-(UIView *)backgroundView
{
    if (_backgroundView) return _backgroundView;
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _backgroundView.backgroundColor = [UIColor blackColor];
    [_backgroundView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:_backgroundView];
    return _backgroundView;
}

-(float)progressWidth
{
    return self.progress * self.bounds.size.width * 0.01;
}

-(UIView *)progressView
{
    if (_progressView) return _progressView;
    _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.progressWidth, self.bounds.size.height)];
    _progressView.backgroundColor = [UIColor greenColor];
    [_progressView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.backgroundView addSubview:_progressView];
    return _progressView;
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor progressColor:(UIColor *)progressColor progress:(NSUInteger)progress
{
    
    self = [self initWithFrame:frame];
    if (!self) return nil;
    _progress = progress;
    [self.backgroundView setBackgroundColor:backgroundColor];
    [self.progressView setBackgroundColor:progressColor];
    return self;
}

- (id)initWithFrame:(CGRect)frame progress:(NSUInteger)progress
{
    return [self initWithFrame:frame backgroundColor:[UIColor blackColor] progressColor:[UIColor greenColor] progress:0];
}


-(void)setProgress:(NSUInteger)progress animated:(BOOL)animated
{
    if (_progress != progress){
        _progress = progress;
        if (animated){
            [UIView animateWithDuration:0.3
                                  delay:0.0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 [self.progressView setFrame:CGRectMake(0, 0, self.progressWidth, self.backgroundView.bounds.size.height)];
                             }
                             completion:nil];
        }
        else
        {
            [self.progressView setFrame:CGRectMake(0, 0, self.progressWidth, self.backgroundView.bounds.size.height)];
        }
    }
}


-(void)done
{
    [self setProgress:100 animated:YES];
}

@end
