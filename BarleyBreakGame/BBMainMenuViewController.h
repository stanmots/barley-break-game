//
//  BBMainMenuViewController.h
//  BarleyBreakGame
//
//  Created by Storix on 9/8/15.
//  Copyright (c) 2015 Stolets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGameViewController.h" 

@interface BBMainMenuViewController : UIViewController

@property (strong, nonatomic) BBGameViewController * gameViewController;

- (void)startGameButtonClicked;

@end
