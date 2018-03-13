//
//  Cell.h
//  Candy
//
//  Created by Nam Trung on 1/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "GamePlay.h"
#import "Candy.h"

@interface Cell : CCNode
+ (Cell*)loadCell: (NSInteger) row : (NSInteger) col;
+ (CGFloat)getCellWidht;

- (void)setCellPosition: (NSInteger) row : (NSInteger) col;
- (void)initCell;

-(NSInteger) RowNumber;
-(NSInteger) ColumnNumber;

-(BOOL) isHasGrass;

-(BOOL) getIsEmpty;
@end
