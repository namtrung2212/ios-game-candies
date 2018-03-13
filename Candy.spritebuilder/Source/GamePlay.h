//
//  GamePlay.h
//  Candy
//
//  Created by Nam Trung on 1/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Level1.h"
#import "Cell.h"
#import "Candy.h"
#import "ProgressTimer.h"
#import "GameOver.h"
#import "MainMenu.h"

@interface GamePlay : CCNode
+ (GamePlay*) instance;

-(GameOver*) getGameOver;
-(MainMenu*) getMainMenu;

- (void)InitLevel : (NSInteger) _levelNbr;
-(NSInteger) getRowNo;
-(NSInteger) getColNo;
- (id) getCellByAddress: (NSInteger) X : (NSInteger) Y;
- (id) getCandyByAddress: (NSInteger) row : (NSInteger) col;
-(NSMutableArray *) Candies;
-(NSMutableArray *) Cells;
-(BOOL) getIsLockTouch;
-(void) setIsLockTouch: (BOOL) lock;

-(BOOL) isTimeUp;
-(CGFloat) getCandyScale;
-(CGFloat) getExploreScale;
-(CGFloat) getExploreWeight;

-(CGFloat) getNodeIndent;

-(NSInteger) getMaxTime;
-(NSInteger) getCurrentTime;

-(NSInteger) getScore;
-(NSInteger) getStarNo;
-(NSInteger) getStarNoRequire;

-(NSInteger) getCandyTypeNo;
-(NSInteger) getBoardType;
+ (NSInteger) getLevelNo;
+ (void) setLevelNo: (NSInteger) _level;
-(void) ExploreBigCandy: (id) BigCandy  noCondition: (BOOL) _exploreImediately;
-(void) falldownAvaiableCandies;

-(BOOL) isFalling;

@end
