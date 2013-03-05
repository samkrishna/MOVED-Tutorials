//
//  QuizEventDispatcher.h
//  01.Quiz
//
//  Created by Sam Krishna on 3/5/13.
//  Copyright (c) 2013 SectorMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QuizViewController;

@interface QuizEventDispatcher : NSObject

@property (nonatomic, readonly, weak) QuizViewController *qvc;

- (id)initWithViewController:(QuizViewController *)aViewController;
- (void)initializeCurrentQuestionIndexObservation;
- (void)cleanupObservations;

- (void)dispatchQuestionOperationForIndex:(NSUInteger)index;
- (void)dispatchAnswerOperationForIndex:(NSUInteger)index;

@end
