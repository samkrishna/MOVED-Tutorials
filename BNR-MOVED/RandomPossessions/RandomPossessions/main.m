//
//  main.m
//  RandomPossessions
//
//  Created by Sam Krishna on 3/4/13.
//  Copyright (c) 2013 SectorMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

int main(int argc, const char * argv[])
{

	@autoreleasepool {

	    NSMutableArray *items = [[NSMutableArray alloc] init];

		for (int i = 0; i < 10; i++) {
			BNRItem *p = [BNRItem randomItemWithOtherInit];
			[items addObject:p];
		}
		
		for (BNRItem *item in items) {
			NSLog(@"%@", item);
		}
		
		items = nil;
	}
	
    return 0;
}

