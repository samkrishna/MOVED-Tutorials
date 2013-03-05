//
//  QuizViewController.m
//  Quiz
//
//  Created by Sam Krishna on 3/4/13.
//  Copyright (c) 2013 SectorMobile. All rights reserved.
//

#import "QuizViewController.h"
#import "QuizEventDispatcher.h"

@interface QuizViewController ()

@end

@implementation QuizViewController {}

#pragma mark - Life Cycle

- (id)init
{
    if (![super initWithNibName:@"QuizView" bundle:nil]) return nil;
    
	// Model initialization
	_questions = @[@"What is 7 + 7?", @"What is the capital of Vermont?", @"From what is cognac made?"];
	_answers = @[@"14", @"Montpelier", @"Grapes"];
    _qed = [[QuizEventDispatcher alloc] initWithViewController:self];
    
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

@end
