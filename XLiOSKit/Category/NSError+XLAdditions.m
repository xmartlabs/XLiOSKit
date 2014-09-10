//
//  NSError+Additions.m
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

#import "NSError+XlAdditions.h"

NSString* const XLErrorDomain = @"com.xmartlabs.kit.XLErrorDomain";

@implementation NSError (XLAdditions)

-(void)showAlertView
{
    if (self.domain == XLErrorDomain){
        switch (self.code) {
            case XLInvalidAuthenticationTokenErrorCode:
                [self showAlertViewWithTitle:@"Error" andMessage:self.localizedFailureReason ?: self.localizedDescription];
                return;
            case XLInvalidUsernameAndPasswordErrorCode:
                [self showAlertViewWithTitle:@"Error" andMessage:self.localizedFailureReason ?: self.localizedDescription];
                return;
            default:
                [self showAlertViewWithTitle:@"Error" andMessage:self.localizedFailureReason ?: self.localizedDescription];
                return;
        }
    }
    [self showAlertViewWithTitle:@"Error" andMessage:self.localizedFailureReason ?: self.localizedDescription];
    
}

-(void)showAlertViewWithTitle:(NSString *)title
{
    if (self.domain == XLErrorDomain){
        switch (self.code) {
            case XLInvalidAuthenticationTokenErrorCode:
                [self showAlertViewWithTitle:title andMessage:self.localizedFailureReason ?: self.localizedDescription];
                return;
            case XLInvalidUsernameAndPasswordErrorCode:
                [self showAlertViewWithTitle:title andMessage:self.localizedFailureReason ?: self.localizedDescription];
                return;
            default:
                [self showAlertViewWithTitle:title andMessage:self.localizedFailureReason ?: self.localizedDescription];
                return;
        }
    }
    [self showAlertViewWithTitle:title andMessage:self.localizedFailureReason ?: self.localizedDescription];
}

-(void)showAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
        [alertView show];
    });
}

@end
