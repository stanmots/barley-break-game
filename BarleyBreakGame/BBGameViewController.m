//
//  BBGameViewController.m
//  BarleyBreakGame
//
//  Created by Storix on 9/8/15.
//  Copyright (c) 2015 Stolets. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import "BBGameViewController.h"
#import "BBGridView.h"
#import "BBChipView.h"

@interface BBGameViewController ()

@property (strong, nonatomic) UIAlertController * alertController;

- (void)shuffleArray: (NSUInteger *)array withSize:(size_t)numberOfItems;

@end

@implementation BBGameViewController

@synthesize chipsAroundEmptyCell = _chipsAroundEmptyCell;
@synthesize timerForLabel = _timerForLabel;
@synthesize stepsCount = _stepsCount;
@synthesize timeLeft = _timeLeft;
@synthesize dateFormatter = _dateFormatter;


- (void)loadView
{
    BBGridView * gameView = [[BBGridView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.view = gameView;
}

-(void)viewDidLoad{
    
    for (NSUInteger i = 0; i < 16; ++i) {
        positions[i] = i;
    }
    
    self.alertController = [UIAlertController alertControllerWithTitle:@"Attention!" message:@"Time is over!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [self.alertController addAction:defaultAction];
    UIView * subView = self.alertController.view.subviews.firstObject;
    UIView * contentView = subView.subviews.firstObject;
    contentView.backgroundColor = [UIColor colorWithRed:0.3 green:0.8 blue:0.7 alpha:0.7];
    
    self.stepsCount = 0;
    
    [[(BBGridView *)self.view restartGameButton]addTarget:self action:@selector(restartGameButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.dateFormatter = [[NSDateFormatter alloc]init];
    [self.dateFormatter setDateFormat:@"mm:ss"];
    
    [self startTimer];
    
    self.chipsAroundEmptyCell = [[NSMutableArray alloc]init];
    
    [self shuffleChips];
    [self setMovableChips];
}

- (void)shuffleArray:(NSUInteger *)array withSize:(size_t)numberOfItems
{
    for (NSUInteger i = numberOfItems - 1; i > 0; --i) {
        NSUInteger j = arc4random_uniform(16);
        NSUInteger temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
}

- (void)shuffleChips
{
    [self shuffleArray:positions withSize:16];
    
    for (NSInteger i = 0; i < 15; ++i)
    {
        CGRect newFrame = [[[(BBGridView *)self.view chipsRects] objectAtIndex:positions[i]] CGRectValue];
        BBChipView * chipView = [[[(BBGridView *)self.view mainGrid]subviews]objectAtIndex:i];
        [chipView setFrame:newFrame];
    }
    
    emptyCellPosition = [[[(BBGridView *)self.view chipsRects] objectAtIndex:positions[15]] CGRectValue];
}
    

- (void)updateCountDownLabel
{
    self.timeLeft = [self.timeLeft dateByAddingTimeInterval:-1];
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitSecond fromDate:self.timeLeft];
    
    NSInteger secondsLeft = [components second];
    
    if (secondsLeft <= 0) {
        
        [self presentViewController:self.alertController animated:YES completion:nil];
        
        [self invalidateTimer];
    }
    else
    {
        NSString * countDownLabelText = [NSString stringWithFormat:@"Time left: %@",[self.dateFormatter stringFromDate:self.timeLeft]];
        [[(BBGridView *)self.view countDownLabel]setText:countDownLabelText];
    }
 
}

- (void)invalidateTimer
{
    if ([self.timerForLabel isValid])
    {
        [self.timerForLabel invalidate];
    }
    if(self.timerForLabel != nil)
    {
        self.timerForLabel = nil;
    }
    
}

- (void)startTimer
{
    self.timeLeft = [self.dateFormatter dateFromString:@"10:00"];
    
    self.timerForLabel = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCountDownLabel) userInfo:nil repeats:YES];
}

- (void)updateStepsCountLabel
{
    NSString * stepsLabelText = [NSString stringWithFormat:@"Steps: %li",(long)self.stepsCount];
    
    [[(BBGridView *)self.view stepsLabel]setText:stepsLabelText];
    
}

- (void)updateGame
{
    [self invalidateTimer];
    [self startTimer];
    
    self.stepsCount = 0;
    [self updateStepsCountLabel];
    
}

- (void)restartGameButtonClicked
{

    [self updateGame];
    [self shuffleChips];
    [self setMovableChips];
}
- (void)setMovableChips
{
    [self.chipsAroundEmptyCell removeAllObjects];
    
    CGPoint testLeftPoint = CGPointMake(emptyCellPosition.origin.x - 70 , emptyCellPosition.origin.y);
    CGPoint testRightPoint = CGPointMake(emptyCellPosition.origin.x +70, emptyCellPosition.origin.y);
    CGPoint testUpperPoint = CGPointMake(emptyCellPosition.origin.x, emptyCellPosition.origin.y+70);
    CGPoint testDownPoint = CGPointMake(emptyCellPosition.origin.x, emptyCellPosition.origin.y-70);
    
    for(BBChipView *chipView in [[(BBGridView *)self.view mainGrid]subviews])
    {
        
        if(CGPointEqualToPoint(testLeftPoint, chipView.frame.origin) || CGPointEqualToPoint(testRightPoint, chipView.frame.origin) || CGPointEqualToPoint(testUpperPoint, chipView.frame.origin)|| CGPointEqualToPoint(testDownPoint, chipView.frame.origin))
        {
            [self.chipsAroundEmptyCell addObject:chipView];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    
    CGPoint touchLocation = [touch locationInView:self.view];
    
    if(CGRectContainsPoint(emptyCellPosition, touchLocation))
    {        
        for(BBChipView * chipView in self.chipsAroundEmptyCell)
        {
            if(touch.view == chipView)
            {
                ++self.stepsCount;
                CGRect newEmptyCellFrame = chipView.frame;
             
                [self updateStepsCountLabel];
        
                CABasicAnimation * scaleAnimation =[CABasicAnimation animationWithKeyPath:@"transform.scale"];
                
                CAMediaTimingFunction *timmingFunction =  [CAMediaTimingFunction
                                              functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                
                [scaleAnimation  setToValue:[NSNumber numberWithFloat:1.2]];
                [scaleAnimation setDuration:0.2];
                [scaleAnimation setTimingFunction:timmingFunction];
                [[chipView layer]addAnimation:scaleAnimation forKey:@"scale"];
                
                [BBChipView  animateWithDuration:0.3 animations:^{
                    
                    chipView.frame = emptyCellPosition;
                }];
                
                emptyCellPosition = newEmptyCellFrame;
                [self setMovableChips];
                return;
            }
        }
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
