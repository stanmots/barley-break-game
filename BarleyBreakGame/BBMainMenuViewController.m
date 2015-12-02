//
//  BBMainMenuViewController.m
//  BarleyBreakGame
//
//  Created by Storix on 9/8/15.
//  Copyright (c) 2015 Stolets. All rights reserved.
//

#import "BBMainMenuViewController.h"
#import "BBMainMenuView.h"

@implementation BBMainMenuViewController

@synthesize gameViewController = _gameViewController;

- (void)loadView
{
    BBMainMenuView * mainView = [[BBMainMenuView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.view = mainView;

}

- (void)startGameButtonClicked
{
    if (!self.gameViewController) {
        self.gameViewController = [[BBGameViewController alloc] init];
    }
    [self.navigationController pushViewController:self.gameViewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController]setNavigationBarHidden:YES];
    [[(BBMainMenuView *)self.view startGameButton]addTarget:self action:@selector(startGameButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
