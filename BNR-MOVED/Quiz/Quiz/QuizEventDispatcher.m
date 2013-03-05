//
//  QuizEventDispatcher.m
//  Quiz
//
//  Created by Sam Krishna on 3/4/13.
//  Copyright (c) 2013 SectorMobile. All rights reserved.
//

#import "QuizEventDispatcher.h"

@interface QuizEventDispatcher ()

@end

@implementation QuizEventDispatcher

- (id)init
{
	return [self initWithNibName:@"QuizView" bundle:nil];
}

// Primitive way, but doing this for now
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (![super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) return nil;
	
	// Model initialization
	_currentQuestionIndex = 0;
	_questions = @[@"What is 7 + 7?", @"What is the capital of Vermont?", @"From what is cognac made?"];
	_answers = @[@"14", @"Montpelier", @"Grapes"];
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Events and Operations
// NOTE: The IBActions are a type of Event.
// The dispatch_queues and the GCD functions are a type of operations.
- (IBAction)showQuestion:(id)sender
{
	dispatch_queue_t myQueue = dispatch_queue_create("com.sectormobile.moved-queue", NULL);
	dispatch_async(myQueue, ^
	{
		self.currentQuestionIndex++;
		if (self.currentQuestionIndex == [self.questions count]) {
			self.currentQuestionIndex = 0;
		}
		
		NSString *question = [self.questions objectAtIndex:self.currentQuestionIndex];
		DLog(@"Question: %@", question);
		
		dispatch_async(dispatch_get_main_queue(), ^
		{
			self.questionField.text = question;
			self.answerField.text = @"????";
		});
	});
}

- (IBAction)showAnswer:(id)sender
{
	dispatch_queue_t myQueue = dispatch_queue_create("com.sectormobile.moved-queue", NULL);
	dispatch_async(myQueue, ^
	{
		NSString *answer = [self.answers objectAtIndex:self.currentQuestionIndex];
		
		dispatch_async(dispatch_get_main_queue(), ^
		{
			self.answerField.text = answer;
		});
	});
}

@end
