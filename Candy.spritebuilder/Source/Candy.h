//
//  Candy.h
//  Candy
//
//  Created by Nam Trung on 1/5/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "GamePlay.h"
@interface Candy : CCNode
+ (Candy*)loadCandy: (NSInteger) row : (NSInteger) col;

- (void)initCandy: (NSInteger) row : (NSInteger) col;



-(NSInteger) rowNumber;
-(NSInteger) colNumber;
-(void) setRowNumber:(NSInteger) row;
-(void) setColNumber:(NSInteger) col;
-(BOOL) IsBomCandy;

-(void) setSelectedCandy:(BOOL) select;
-(BOOL) getIsSelectedCandy;

-(void) setIsFalling:(BOOL) fall;
-(BOOL) getIsFalling;

-(void) updateShadow;
- (void)updateNewAddress: (NSInteger) row : (NSInteger) col;
-(void) updatePosition;
-(NSString*) getType;

-(void) doExplore;

-(CGFloat) getWeight;
-(CGFloat) getBeginWeight;
-(void) setWeight:(CGFloat) _weight;
-(CGFloat) getRealScale;
@end
