//
//  XLImageSubtitledView.m
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

#import "XLImageSubtitledView.h"

@interface XLImageSubtitledView()

@property UIImageView * imageView;
@property UILabel * subtitleLabel;

@end

@implementation XLImageSubtitledView

@synthesize imageView = _imageView;
@synthesize subtitleLabel = _subtitleLabel;

-(id)initWithImage:(UIImage *)image subtitle:(NSString *)subtitle
{
    CGRect frame = CGRectMake(0, 0, 180, 44);
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.backgroundColor = [UIColor clearColor];
    self.imageView.image = image;
    [self addSubview:self.imageView];
    self.subtitleLabel.text = subtitle;
    [self addSubview:self.subtitleLabel];
    return self;
}


-(UIImageView *)imageView
{
    if (_imageView) return _imageView;
    CGRect frame = CGRectMake(0, 0, 180, 44);
    _imageView = [[UIImageView alloc] initWithFrame:frame];
    _imageView.contentMode = UIViewContentModeCenter;
    return _imageView;
}

-(void)setImageView:(UIImageView *)imageView
{
    _imageView = imageView;
}

-(UILabel *)subtitleLabel
{
    if (_subtitleLabel) return _subtitleLabel;
    
    CGRect frame = CGRectMake(0, 30, 180, 12);
    _subtitleLabel = [[UILabel alloc] initWithFrame:frame];
    [_subtitleLabel setBackgroundColor:[UIColor clearColor]];
    [_subtitleLabel setFont:[UIFont systemFontOfSize:10.0f]];
    [_subtitleLabel setTextAlignment:NSTextAlignmentCenter];
    return _subtitleLabel;
}

-(void)setSubtitleLabel:(UILabel *)subtitleLabel
{
    _subtitleLabel = subtitleLabel;
}


@end
