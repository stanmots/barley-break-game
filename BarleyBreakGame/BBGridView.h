//
//  BBGridView.h
//  BarleyBreakGame
//
//  Created by Storix on 9/8/15.
//  Copyright (c) 2015 Stolets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBMainMenuView.h"

@interface BBGridView : BBMainMenuView

@property (weak, nonatomic) UIButton * restartGameButton;
@property (weak, nonatomic) UILabel * stepsLabel;
@property (weak, nonatomic) UILabel * countDownLabel;
@property (weak, nonatomic) UIView * mainGrid;
@property (strong, nonatomic) NSMutableArray * chipsRects;

- (void)createChipsViews;

@end
