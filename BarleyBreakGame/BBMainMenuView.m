//
//  BBMainMenuView.m
//  BarleyBreakGame
//
//  Created by Storix on 9/8/15.
//  Copyright (c) 2015 Stolets. All rights reserved.
//

#import "BBMainMenuView.h"

static inline double radians (double degrees) 
{ 
    return degrees * M_PI/180; 
}

void DrawPattern (void *info, CGContextRef context); 

@implementation BBMainMenuView

@synthesize startGameButton = _startGameButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //Customizing  start-game-button
        UIImage * buttonNormalImage = [UIImage imageNamed:@"ButtonNormalImage.png"];
        
        UIButton * startGameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.startGameButton = startGameButton;
        
        CGRect buttonFrame = [[UIScreen mainScreen]bounds];
        
        buttonFrame.size = CGSizeMake(buttonFrame.size.width,buttonFrame.size.height/4);
        buttonFrame.origin = CGPointMake (buttonFrame.origin.x, buttonFrame.size.height);
        
        self.startGameButton.frame = buttonFrame;
        [self.startGameButton setTitle:@"Start Game" forState:UIControlStateNormal];
        [[self.startGameButton titleLabel]setFont:[UIFont systemFontOfSize:28]];
        [self.startGameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.startGameButton setBackgroundImage:buttonNormalImage forState:UIControlStateNormal];
            
        [self addSubview:self.startGameButton];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    context = UIGraphicsGetCurrentContext();
    
    UIColor * bgColor = [UIColor colorWithHue:0.45 saturation:0.55 brightness:0.8 alpha:1];
    CGContextSetFillColorWithColor(context, bgColor.CGColor);
    CGContextFillRect(context, rect);
    
    static const CGPatternCallbacks callbacks = { 0, &DrawPattern, NULL };
    
    CGContextSaveGState(context);
    CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace(context, patternSpace);
    CGColorSpaceRelease(patternSpace);
    
    CGPatternRef pattern = CGPatternCreate(NULL,
                                           rect,
                                           CGAffineTransformIdentity,
                                           36,
                                           36,
                                           kCGPatternTilingConstantSpacingMinimalDistortion,
                                           true,
                                           &callbacks);
    CGFloat alpha = 1.0;
    CGContextSetFillPattern(context, pattern, &alpha);
    CGPatternRelease(pattern);
    CGContextFillRect(context, self.bounds);
    CGContextRestoreGState(context);
}


@end

void DrawPattern (void *info, CGContextRef context) 
{ 
    UIColor * dotColor = [UIColor colorWithHue:0.3 saturation:0 brightness:0.07 alpha:1.0];
    CGContextSetFillColorWithColor(context, dotColor.CGColor);
    
    CGContextAddArc(context, 3, 3, 4, 0, radians(180), 90);
    CGContextFillPath(context);
    
}
