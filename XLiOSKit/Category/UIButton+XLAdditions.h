//
//  UIButton+XLAdditions.h
//  XLiOSKit
//
//  Created by Martin Barreto on 11/1/14.
//  Copyright (c) 2014 Xmartlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (XLAdditions)

-(UIActivityIndicatorView *)addActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)style;
-(void)removeActivityIndicator;

@end
