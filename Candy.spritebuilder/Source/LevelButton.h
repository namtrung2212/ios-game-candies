//
//  LevelButton.h
//  Candy
//
//  Created by Nam Trung on 1/25/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface LevelButton : CCNode
-(void) setNumber:(NSInteger) _no:(NSInteger) _page;
-(void) setEnable:(BOOL) _enable;

-(NSInteger) getNumber;

-(NSInteger) getPage;

@end
