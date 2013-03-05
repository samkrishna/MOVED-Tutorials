//
//  BNRItem.h
//  02.RandomPossessions
//
//  Created by Sam Krishna on 3/4/13.
//  Copyright (c) 2013 SectorMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *serialNumber;
@property (nonatomic, assign) NSUInteger valueInDollars;
@property (nonatomic, strong) NSDate *dateCreated;

+ (id)randomItem;
+ (id)randomItemWithOtherInit;

- (id)initWithItemName:(NSString *)name
		valueInDollars:(NSUInteger)value
		  serialNumber:(NSString *)sNumber;

- (id)initWithItemName:(NSString *)name
		  serialNumber:(NSString *)sNumber;

@end
