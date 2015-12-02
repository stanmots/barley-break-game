//
//  BBAppDelegate.h
//  BarleyBreakGame
//
//  Created by Storix on 9/8/15.
//  Copyright (c) 2015 Stolets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBMainMenuViewController.h"

@interface BBAppDelegate : UIResponder <UIApplicationDelegate>
{
    BBMainMenuViewController *mainMenuViewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;

@end
