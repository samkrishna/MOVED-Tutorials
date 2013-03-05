//
//  QuizEventDispatcher.m
//  01.Quiz
//
//  Created by Sam Krishna on 3/5/13.
//  Copyright (c) 2013 SectorMobile. All rights reserved.
//

#import "QuizEventDispatcher.h"
#import "QuizViewController.h"
#import "MAKVONotificationCenter.h"

static dispatch_queue_t sm_moved_queue;

NSString * const kSMQuestionOperationKey = @"currentQuestionIndex";

@interface QuizEventDispatcher ()
- (void)initializeCurrentQuestionIndexObservation;
@end

@implementation QuizEventDispatcher

#pragma mark - Class

+ (void)initialize
{
    sm_moved_queue = dispatch_queue_create("com.sectormobile.moved-queue", NULL);
}

#pragma mark - Operations

- (id)initWithViewController:(QuizViewController *)aViewController
{
    if (![super init]) return nil;
    
    _qvc = aViewController;
    
    return self;
}

- (void)dealloc
{
    _qvc = nil;
}

#pragma mark - Observations

- (void)initializeCurrentQuestionIndexObservation
{
    __weak typeof(self) weak_self = self;
	[[MAKVONotificationCenter defaultCenter] observeTarget:self.qvc
                                                   keyPath:kSMQuestionOperationKey
                                                   options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                                                     block:^(MAKVONotification *notification)
     {
         NSUInteger changedValue = [[notification newValue] unsignedIntegerValue];
         if (changedValue >= [weak_self.qvc.questions count])
         {
             changedValue = 0;
             weak_self.qvc.currentQuestionIndex = changedValue;
         }
         
         [weak_self dispatchQuestionOperationForIndex:changedValue];
     }];
}

- (void)cleanupObservations
{
    [[MAKVONotificationCenter defaultCenter] removeAllObservers];
}

#pragma mark - Operations

- (void)dispatchOperationWithBlock:(void (^)(QuizViewController *sender))operation
{
    __weak typeof(self) weak_self = self;
	dispatch_async(sm_moved_queue, ^{
        if (operation) {
            operation(weak_self.qvc);
        }
    });
}

- (void)dispatchMainQueueOperationWithBlock:(void (^)(QuizViewController *sender))operation
{
    __weak typeof(self) weak_self = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (operation) {
            operation(weak_self.qvc);
        }
    });
}

- (void)dispatchQuestionOperationForIndex:(NSUInteger)index
{
    __weak typeof(self) weak_self = self;
    [self dispatchOperationWithBlock:^(QuizViewController *sender) {
        NSString *question = [sender.questions objectAtIndex:index];
        [weak_self dispatchMainQueueOperationWithBlock:^(QuizViewController *qvc) {
            [qvc.questionField setText:question];
            [qvc.answerField setText:@"????"];
        }];
    }];
}

- (void)dispatchAnswerOperationForIndex:(NSUInteger)index
{
    __weak typeof(self) weak_self = self;
    [self dispatchOperationWithBlock:^(QuizViewController *sender) {
        NSString *answer = [sender.answers objectAtIndex:index];
        [weak_self dispatchMainQueueOperationWithBlock:^(QuizViewController *qvc) {
            [qvc.answerField setText:answer];
        }];
    }];
}


@end
