//
//  BBGameViewController.h
//  BarleyBreakGame
//
//  Created by Storix on 9/8/15.
//  Copyright (c) 2015 Stolets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBGameViewController : UIViewController
{
    CGRect emptyCellPosition;
    NSUInteger positions[16];
}

@property (strong,nonatomic) NSMutableArray * chipsAroundEmptyCell;
@property (strong,nonatomic) NSDate * timeLeft;
@property (strong, nonatomic) NSDateFormatter * dateFormatter;
@property (nonatomic) NSInteger stepsCount;
@property (weak,nonatomic) NSTimer * timerForLabel;

- (void)setMovableChips;
- (void)shuffleChips;
- (void)restartGameButtonClicked;
- (void)updateCountDownLabel;
- (void)invalidateTimer;
- (void)startTimer;
- (void)updateStepsCountLabel;
- (void)updateGame;

@end
