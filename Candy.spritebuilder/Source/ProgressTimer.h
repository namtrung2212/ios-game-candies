//
//  ProgressTimer.h
//  Candy
//
//  Created by Nam Trung on 1/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface ProgressTimer : CCNode

-(void) resetProgress :(NSInteger) _maxValue;
-(void) updateProgressWithValue :(NSInteger) _Value;
-(void) updateProgress;

-(BOOL) isTimeUp;
@end
