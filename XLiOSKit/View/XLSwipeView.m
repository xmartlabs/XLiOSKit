//
//  XLSwipeView.m
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

#import "XLSwipeView.h"
#import "UIView+XLAdditions.h"

@interface XLSwipeView() <UIScrollViewDelegate>
{
    NSArray *_pages;
    XLSwipeViewPageControlPosition _pageControlPosition;
}

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation XLSwipeView

@synthesize pageControl = _pageControl;
@synthesize scrollView = _scrollView;
@synthesize contentView = _contentView;

- (UIPageControl *)pageControl
{
    if (_pageControl) return _pageControl;
    _pageControl = [UIPageControl autolayoutView];
    _pageControl.hidesForSinglePage = YES;

    [_pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    return _pageControl;
}

- (UIScrollView *)scrollView
{
    if (_scrollView) return _scrollView;
    
    _scrollView = [UIScrollView autolayoutView];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.maximumZoomScale = 1;
    _scrollView.minimumZoomScale = 1;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    return _scrollView;
}

-(UIView*)contentView
{
    if (_contentView) return _contentView;
    _contentView = [UIView new];
    return _contentView;
}

- (id) init
{
    return [self initWithPages:nil];
}

- (id)initWithPages:(NSArray *)pagesArray
{
    return [self initWithPages:pagesArray pageControlPosition:XLSwipeViewPageControlPositionBottom];
}

- (id)initWithPages:(NSArray *)pagesArray pageControlPosition:(XLSwipeViewPageControlPosition)pageControlPosition
{
    self = [super init];
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        _pages = [pagesArray copy];
        _pageControlPosition = pageControlPosition;
        
        UIView * pageView = [_pages firstObject];
        //CGSize contentSize = CGSizeMake(pageView.frame.size.width * _pages.count, pageView.frame.size.height);
        //self.scrollView.contentSize = contentSize;
        
        for (int ind = 0; ind < _pages.count; ++ind) {
            UIView *page = [_pages objectAtIndex:ind];
            // Traslate the center of the next subview
            page.center = CGPointMake(pageView.frame.size.width * (0.5 + ind), pageView.frame.size.height * 0.5f);
            [self.contentView addSubview:page];
        }
        [self.scrollView addSubview:self.contentView];
        [self addSubview:self.scrollView];
        
        // add page control
        self.pageControl.numberOfPages = _pages.count;
        self.pageControl.currentPage = 0;
        [self addSubview:self.pageControl];
        
        [self.scrollView setContentSize:CGSizeMake(pageView.frame.size.width * _pages.count, pageView.frame.size.height)];
        
        [self addConstraints:[self layoutConstraints]];
    }
    return self;
}

- (void)setPages:(NSArray *)pagesArray
{
    // remove subviews form self.contentView
    for (UIView *subview in self.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    _pages = [pagesArray copy];

    
    UIView * pageView = [_pages firstObject];
    //CGSize contentSize = CGSizeMake(pageView.frame.size.width * _pages.count, pageView.frame.size.height);
    //self.scrollView.contentSize = contentSize;
    
    for (int ind = 0; ind < _pages.count; ++ind) {
        UIView *page = [_pages objectAtIndex:ind];
        // Traslate the center of the next subview
        page.center = CGPointMake(pageView.frame.size.width * (0.5 + ind), pageView.frame.size.height * 0.5f);
        [self.contentView addSubview:page];
    }
    
    // add page control
    self.pageControl.numberOfPages = _pages.count;
    self.pageControl.currentPage = 0;
    
    [self.scrollView setContentSize:CGSizeMake(pageView.frame.size.width * _pages.count, pageView.frame.size.height)];
}

- (void)pageIndicatorTintColor:(UIColor*)color
{
    self.pageControl.pageIndicatorTintColor = color;
    
}

- (void)currentPageIndicatorTintColor:(UIColor*)color
{
    self.pageControl.currentPageIndicatorTintColor = color;
}

- (UIView *)getCurrentPage
{
    UIView * page;
    if (self.pageControl.numberOfPages > 0)
        page = [self.contentView.subviews objectAtIndex:self.pageControl.currentPage];
    return page;
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.pageControl.currentPage = page;
    
    // Disable vertical scroll
    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width; // you need to have a **iVar** with getter for scrollView
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.pageControl.currentPage = page;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * self.pageControl.currentPage, 0) animated:YES];
}

#pragma mark - Event Handlers

- (void)pageControlValueChanged:(UIPageControl *)pageControl
{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * self.pageControl.currentPage, 0) animated:YES];
}

#pragma mark - LayoutConstraints

-(NSArray *)layoutConstraints
{
    NSMutableArray * result = [NSMutableArray array];
    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:0 views:@{@"scrollView": self.scrollView}]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:0 views:@{@"scrollView": self.scrollView}]];
    
    // page control
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[pageControl]|" options:0 metrics:0 views:@{@"pageControl": self.pageControl}]];
    switch (_pageControlPosition) {
        case XLSwipeViewPageControlPositionBottom:
            [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageControl]|" options:0 metrics:0 views:@{@"pageControl": self.pageControl}]];
            break;
        case XLSwipeViewPageControlPositionTop:
            [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[pageControl]" options:0 metrics:0 views:@{@"pageControl": self.pageControl}]];
            break;
        default:
            NSAssert(false, @"Invalid page control position: %@", @(_pageControlPosition));
            break;
    }
    
    return result;
}

@end