//
//  BBChipView.m
//  BarleyBreakGame
//
//  Created by Storix on 9/8/15.
//  Copyright (c) 2015 Stolets. All rights reserved.
//

#import "BBChipView.h"
#import <CoreText/CoreText.h>

@implementation BBChipView

@synthesize chipNumberTitle = _chipNumberTitle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.chipNumberTitle = [[NSAttributedString alloc] initWithString:@" " attributes:nil];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor * chipInsideFrameColor = [UIColor colorWithRed:0.1 green:0.8 blue:0.9 alpha:1];
    UIColor * chipOutsideFrameColor = [UIColor colorWithRed:0 green:0.5 blue:0.7 alpha:0.7];
    
    CGContextClearRect(context, rect);
    
    CGContextSetRGBFillColor(context, 0.8, 0.8, 0.7, 1);
    CGRect chipRect = CGRectMake(0, 0, 70, 70);
    CGContextFillRect(context, chipRect);
    
    // Inside border
    CGRect strokeInsideRect = CGRectInset(chipRect, 5, 5);
    CGContextSetStrokeColorWithColor(context, chipInsideFrameColor.CGColor);
    CGContextSetLineWidth(context, 3.0);
    CGContextStrokeRect(context, strokeInsideRect);
    
    //Outside border
    CGRect strokeOutsideRect = CGRectInset(chipRect, 0, 0);
    CGContextSetStrokeColorWithColor(context, chipOutsideFrameColor.CGColor);
    CGContextSetLineWidth(context, 8.0);
    CGContextStrokeRect(context, strokeOutsideRect);

    //Manage coordinate system
    CGContextSetTextMatrix(context, CGAffineTransformIdentity); 
    CGContextTranslateCTM(context, 0, self.bounds.size.height); 
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //Draw chip number
    CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)self.chipNumberTitle); 
    CGContextSetTextPosition(context, 10.0, 10.0);
    CTLineDraw(line, context);
    CFRelease(line);
}

@end
