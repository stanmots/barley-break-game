//
//  BBGridView.m
//  BarleyBreakGame
//
//  Created by Storix on 9/8/15.
//  Copyright (c) 2015 Stolets. All rights reserved.
//

#import "BBGridView.h"
#import "BBChipView.h"

#import <CoreText/CoreText.h>

@implementation BBGridView

@synthesize restartGameButton = _restartGameButton;
@synthesize stepsLabel = _stepsLabel;
@synthesize countDownLabel = _countDownLabel;
@synthesize mainGrid = _mainGrid;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.startGameButton setHidden:YES];
        
        CGRect mainRect = CGRectMake(20, 20, 280, 280);
        UIView * mainGrid = [[UIView alloc]initWithFrame: mainRect];
        self.mainGrid = mainGrid;
        [self addSubview: self.mainGrid];
        
        self.chipsRects = [[NSMutableArray alloc]init];
        
        //Customizing restart-button
        UIImage * restartButtonImage = [UIImage imageNamed:@"RestartButtonImage.png"];
        
        UIButton * restartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.restartGameButton = restartButton;
        
        CGRect buttonFrame = [[UIScreen mainScreen]bounds];
        
        buttonFrame.size = CGSizeMake(buttonFrame.size.width/2,buttonFrame.size.height/8);
        buttonFrame.origin = CGPointMake (buttonFrame.origin.x+20, buttonFrame.size.height*5);
        
        self.restartGameButton.frame = buttonFrame;
        [self.restartGameButton setTitle:@"Restart" forState:UIControlStateNormal];
        [[self.restartGameButton titleLabel]setFont:[UIFont systemFontOfSize:28]];
        [self.restartGameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.restartGameButton setBackgroundImage:restartButtonImage forState:UIControlStateNormal];
        
        [self addSubview:self.restartGameButton];
        
        //Customizing steps-label
        CGRect labelFrame = buttonFrame;
        labelFrame.origin.y = labelFrame.origin.y+100;
        labelFrame.size = CGSizeMake(100, 30);
        UILabel * stepsLabel = [[UILabel alloc] initWithFrame: labelFrame];
        self.stepsLabel = stepsLabel;
        [self.stepsLabel setText: @"Steps: 0"];
        
        [self.stepsLabel setBackgroundColor:[UIColor grayColor]];
        [self.stepsLabel setTextColor: [UIColor cyanColor]];
        [self addSubview: self.stepsLabel];
        
        //Customizing count-down-label
        CGRect countDownLabelFrame = labelFrame;
        countDownLabelFrame.origin.x = labelFrame.origin.x+150;
        countDownLabelFrame.size = CGSizeMake(140, 30);
        UILabel * countDownLabel = [[UILabel alloc] initWithFrame: countDownLabelFrame];
        self.countDownLabel = countDownLabel;
        [self.countDownLabel setText: @"Time left: "];
        
        [self.countDownLabel setBackgroundColor:[UIColor grayColor]];
        [self.countDownLabel setTextColor: [UIColor yellowColor]];
        [self addSubview: self.countDownLabel];
        
        [self createChipsViews];
    }
    return self;
}

- (void)createChipsViews
{
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", 36.0f, NULL);
    NSDictionary *attrDictionary = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)fontRef, (NSString *)kCTFontAttributeName, (id)[[UIColor blackColor] CGColor], (NSString *)(kCTForegroundColorAttributeName), nil];
    
    CFRelease(fontRef);
    
    CGRect chipRect = [self.mainGrid bounds];
    chipRect.size = CGSizeMake(chipRect.size.width/4, chipRect.size.height/4);
    
    int count = 0;
    
    for(NSInteger row = 0; row < 4; ++row)
    {
        for(NSInteger column = 0; column < 4; ++column)
        {
            ++count;
            
            if(column!=0)
            {
                chipRect.origin.x = chipRect.origin.x+70;
                
            }
            
            if(row!=3 || column!=3)
            {
                BBChipView * chipView = [[BBChipView alloc]initWithFrame:chipRect];
                NSString * chipNumberString = [NSString stringWithFormat:@"%li",(long)count] ;
                NSAttributedString * attrString = [[NSAttributedString alloc]initWithString:chipNumberString attributes:attrDictionary];
                [chipView setChipNumberTitle:attrString];
                
                [self.mainGrid addSubview:chipView];
            }
            
            [self.chipsRects addObject:[NSValue valueWithCGRect:chipRect]];
        }
        
        chipRect.origin.y = chipRect.origin.y+70;
        chipRect.origin.x = chipRect.origin.x - 210;
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextSetRGBFillColor(context, 127,255, 127, 0.4);
    CGContextFillRect(context, self.mainGrid.frame);
}

@end
