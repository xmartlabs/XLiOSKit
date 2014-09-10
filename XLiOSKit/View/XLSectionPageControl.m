//
//  XLSectionPageControl.m
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

#import "XLSectionPageControl.h"

@implementation XLSectionPageControl
{
    UIPageControl *_sectionControl;
    UIPageControl *_pagesControl;
    
    NSInteger _numberOfSections;
    NSInteger _numberOfPagesForCurrentSection;
    NSInteger _currentSection;
    NSInteger _currentPage;
}

@synthesize delegate = _delegate;

- (UIPageControl *)sectionControl
{
    if (_sectionControl) return _sectionControl;
    
    _sectionControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.5f)];
    _sectionControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    return _sectionControl;
}

- (UIPageControl *)pagesControl
{
    if (_pagesControl) return _pagesControl;
    
    _pagesControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height * 0.5, self.frame.size.width, self.frame.size.height * 0.5f)];
    _pagesControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    return _pagesControl;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self startControl];
        [self refreshControlsWithSection:0 page:0];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame delegate:(id<XLSectionPageControlDataSource>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        [self startControl];
        [self refreshControlsWithSection:0 page:0];
    }
    return self;
}

- (void)setCurrentSection:(NSInteger)section
{
    if (section == _currentSection) return;
    
    
    [self refreshControlsWithSection:section page:0];
    [self sizeToFit];
}

- (void)setCurrentSection:(NSInteger)section page:(NSInteger)page
{
    if (_currentSection == section && _currentPage == page) return;
    
    [self refreshControlsWithSection:section page:page];
    [self sizeToFit];
}

- (void)setCurrentIndexPath:(NSIndexPath *)indexPath
{
    [self setCurrentSection:indexPath.section page:indexPath.row];
}

- (void)sizeToFit
{
    [super sizeToFit];
    
    if (_numberOfSections == 1) {
        self.frame = self.pagesControl.frame;
    }
}

/***********************************************************************************************************************
 * Auxiliary functions
 ***********************************************************************************************************************/

- (void)startControl
{
    [self addSubview:[self sectionControl]];
    [self addSubview:[self pagesControl]];
    
    self.sectionControl.backgroundColor = [UIColor clearColor];
    self.pagesControl.backgroundColor = [UIColor clearColor];
    
    if ([self.delegate respondsToSelector:@selector(currentSectionIndicatorTintColorForPageControl:)]) {
        self.sectionControl.currentPageIndicatorTintColor = [self.delegate currentSectionIndicatorTintColorForPageControl:self];
    }
    
    if ([self.delegate respondsToSelector:@selector(sectionIndicatorTintColorForPageControl:)]) {
        self.sectionControl.pageIndicatorTintColor = [self.delegate sectionIndicatorTintColorForPageControl:self];
    }

    if ([self.delegate respondsToSelector:@selector(currentPageIndicatorTintColorForPageControl:)]) {
        self.pagesControl.currentPageIndicatorTintColor = [self.delegate currentPageIndicatorTintColorForPageControl:self];
    }

    if ([self.delegate respondsToSelector:@selector(pageIndicatorTintColorForPageControl:)]) {
        self.pagesControl.pageIndicatorTintColor = [self.delegate pageIndicatorTintColorForPageControl:self];
    }
}

- (void)refreshControlsWithSection:(NSInteger)section page:(NSInteger)page
{
    _currentSection = section;
    _currentPage = page;

    _numberOfSections = [self.delegate sectionsForPageControl:self];
    _numberOfPagesForCurrentSection = [self.delegate pageControl:self pagesForSection:_currentSection];

    self.sectionControl.numberOfPages = _numberOfSections;
    self.sectionControl.currentPage = _currentSection;
    
    self.pagesControl.numberOfPages = _numberOfPagesForCurrentSection;
    self.pagesControl.currentPage = _currentPage;
    
    if (_numberOfSections == 1) {
        [self.sectionControl removeFromSuperview];
    } else {
        [self addSubview:self.sectionControl];
    }
}

@end
