//
//  QuizEventDispatcher.m
//  Quiz
//
//  Created by Sam Krishna on 3/4/13.
//  Copyright (c) 2013 SectorMobile. All rights reserved.
//

#import "QuizEventDispatcher.h"
#import "MAKVONotificationCenter.h"

static dispatch_queue_t sm_moved_queue;

NSString * const SMQuestionOperationKey = @"currentQuestionIndex";

@interface QuizEventDispatcher ()

@end

@implementation QuizEventDispatcher {}

#pragma mark - Class

+ (void)initialize
{
    sm_moved_queue = dispatch_queue_create("com.sectormobile.moved-queue", NULL);
}

#pragma mark - Life Cycle

- (id)init
{
	return [self initWithNibName:@"QuizView" bundle:nil];
}

// Primitive way, but doing this for now
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (![super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) return nil;
	
	// Model initialization
	_questions = @[@"What is 7 + 7?", @"What is the capital of Vermont?", @"From what is cognac made?"];
	_answers = @[@"14", @"Montpelier", @"Grapes"];
	
	return self;
}

#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self intializeCurrentQuestionIndexObservation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[MAKVONotificationCenter defaultCenter] removeAllObservers];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setCurrentQuestionIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

// Events and Operations
// NOTE: The IBActions are a type of Event.
// The dispatch_queues and the GCD functions are a type of operations.
- (IBAction)showQuestion:(id)sender
{
    self.currentQuestionIndex++;
}

- (IBAction)showAnswer:(id)sender
{
    [self dispatchAnswerOperationForIndex:self.currentQuestionIndex];
}

#pragma mark - Observations

- (void)intializeCurrentQuestionIndexObservation
{
    __weak typeof(self) weak_self = self;
	[[MAKVONotificationCenter defaultCenter] observeTarget:self
                                                   keyPath:SMQuestionOperationKey
                                                   options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                                                     block:^(MAKVONotification *notification)
    {
		NSUInteger changedValue = [[notification newValue] unsignedIntegerValue];
        if (changedValue >= [weak_self.questions count])
        {
            changedValue = 0;
            weak_self.currentQuestionIndex = changedValue;
        }
		
        [weak_self dispatchQuestionOperationForIndex:changedValue];
	}];
}

#pragma mark - Operations

- (void)dispatchOperationWithBlock:(void (^)(QuizEventDispatcher *sender))operation
{
    __weak typeof(self) weak_self = self;
	dispatch_async(sm_moved_queue, ^{
        if (operation) {
            operation(weak_self);
        }
    });
}

- (void)dispatchMainQueueOperationWithBlock:(void (^)(QuizEventDispatcher *dispatcher))operation
{
    __weak typeof(self) weak_self = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (operation) {
            operation(weak_self);
        }
    });
}

- (void)dispatchQuestionOperationForIndex:(NSUInteger)index
{
    [self dispatchOperationWithBlock:^(QuizEventDispatcher *sender) {
        NSString *question = [sender.questions objectAtIndex:index];
        [sender dispatchMainQueueOperationWithBlock:^(QuizEventDispatcher *dispatcher) {
            [dispatcher.questionField setText:question];
            [dispatcher.answerField setText:@"????"];
        }];
    }];
}

- (void)dispatchAnswerOperationForIndex:(NSUInteger)index
{
    [self dispatchOperationWithBlock:^(QuizEventDispatcher *sender) {
        NSString *answer = [sender.answers objectAtIndex:index];
        [sender dispatchMainQueueOperationWithBlock:^(QuizEventDispatcher *dispatcher) {
            [dispatcher.answerField setText:answer];
        }];
    }];
}

@end
