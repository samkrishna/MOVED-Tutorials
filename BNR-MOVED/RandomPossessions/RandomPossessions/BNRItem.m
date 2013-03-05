//
//  BNRItem.m
//  02.RandomPossessions
//
//  Created by Sam Krishna on 3/4/13.
//  Copyright (c) 2013 SectorMobile. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

+ (id)randomItem
{
	NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
	NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
	
	NSUInteger adjectiveIndex = rand() % [randomAdjectiveList count];
	NSUInteger nounIndex = rand() % [randomNounList count];
	
	NSString *randomName = [NSString stringWithFormat:@"%@ %@", randomAdjectiveList[adjectiveIndex], randomNounList[nounIndex]];
	NSUInteger randomValue = rand() % 100;
	
	NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
																'0' + rand() % 10,
														'A' + rand() % 26,
														'0' + rand() % 10,
														'A' + rand() % 26,
														'0' + rand() % 10];
	
	BNRItem *newItem = [[self alloc] initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
	return newItem;
}

+ (id)randomItemWithOtherInit
{
	NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
	NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
	
	NSUInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
	NSUInteger nounIndex = arc4random() % [randomNounList count];
	
	NSString *randomName = [NSString stringWithFormat:@"%@ %@", randomAdjectiveList[adjectiveIndex], randomNounList[nounIndex]];
	
	NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
									'0' + arc4random() % 10,
									'A' + arc4random() % 26,
									'0' + arc4random() % 10,
									'A' + arc4random() % 26,
									'0' + arc4random() % 10];
	
	BNRItem *newItem = [[self alloc] initWithItemName:randomName serialNumber:randomSerialNumber];
	return newItem;
}

- (id)initWithItemName:(NSString *)name
		valueInDollars:(NSUInteger)value
		  serialNumber:(NSString *)sNumber
{
	if (![super init]) return nil;
	
	_itemName = name;
	_valueInDollars = value;
	_serialNumber = sNumber;
	_dateCreated = [NSDate date];
	
	return self;
}

- (id)initWithItemName:(NSString *)name
		  serialNumber:(NSString *)sNumber
{
	NSUInteger randomValue = arc4random() % 100;
	if (![self initWithItemName:name valueInDollars:randomValue serialNumber:sNumber]) return nil;
	
	return self;
}

- (NSString *)description
{
	NSString *desc = [NSString stringWithFormat:@"%@ (%@): Worth $%lu, recorded on %@", self.itemName, self.serialNumber, self.valueInDollars, self.dateCreated];
	return desc;
}


@end
