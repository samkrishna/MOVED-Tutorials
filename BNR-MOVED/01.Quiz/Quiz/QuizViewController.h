//
//  QuizViewController.h
//  Quiz
//
//  Created by Sam Krishna on 3/4/13.
//  Copyright (c) 2013 SectorMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuizEventDispatcher;

@interface QuizViewController : UIViewController

// Models
@property (nonatomic, assign) NSUInteger currentQuestionIndex;
@property (nonatomic, strong) NSArray *questions;
@property (nonatomic, strong) NSArray *answers;

// Views
@property (nonatomic, strong) IBOutlet UILabel *questionField;
@property (nonatomic, strong) IBOutlet UILabel *answerField;

// Event Dispatcher
@property (nonatomic, strong) QuizEventDispatcher *qed;

// Events and Operations
- (IBAction)showQuestion:(id)sender;
- (IBAction)showAnswer:(id)sender;



@end
