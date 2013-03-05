//
//  AppDelegate.h
//  Quiz
//
//  Created by Sam Krishna on 3/4/13.
//  Copyright (c) 2013 SectorMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuizEventDispatcher;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) QuizEventDispatcher *viewController;

@end
