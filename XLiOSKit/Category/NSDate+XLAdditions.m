//
//  NSDate+XLAdditions.m
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

#import "NSDate+XLAdditions.h"

@implementation NSDate (XLAdditions)

+(NSDate *)dateFromString:(NSString *)dateString
{
    // date formatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    //[formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    // hot fix from date
    NSRange range = [dateString rangeOfString:@"."];
    if (range.location != NSNotFound){
        dateString = [dateString substringToIndex:range.location];
    }
    return [formatter dateFromString:dateString];
}

-(NSDate *)xlBeginningOfDay
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:self];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [cal dateFromComponents:components];
}

-(NSDate *)xlEndOfDay
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:self];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    return [cal dateFromComponents:components];
}

@end
