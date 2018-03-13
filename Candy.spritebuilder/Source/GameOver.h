//
//  GameOver.h
//  Candy
//
//  Created by Nam Trung on 1/23/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface GameOver : CCNode
-(BOOL) IsGameOver;
-(void) ShowGameOverPanel;
-(void) ShowGameOver;
-(void) MenuAction;
-(void) ReloadAction;
-(void) NextLevelAction;
@end
