//
//  ProgressTimer.m
//  Candy
//
//  Created by Nam Trung on 1/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ProgressTimer.h"

@implementation ProgressTimer
{
    CCNode* _BG;
    
    CCNode* _progressBar;
    
    CCNode* _flag;
    CCNode* _worm;
    
    CGFloat maxValue;
    CGFloat currentValue;
}
- (void)didLoadFromCCB {
    _worm.scaleX=0.7f;
    _worm.scaleY=0.7f;
    
    _flag.scaleX=0.8f;
    _flag.scaleY=0.8f;
    _BG.scaleY=0.8f;
    _progressBar.scaleY=0.8f;
}


-(BOOL) isTimeUp
{
    return _progressBar.scaleX==_BG.scaleX;
}

-(void) resetProgress :(NSInteger) _maxValue
{
    maxValue=_maxValue;
    currentValue=0;
    
    CGSize s = [CCDirector sharedDirector].viewSize;
    
    CGFloat realWidht = s.width- 2* self.position.x;
    _BG.scaleX=realWidht/(_BG.contentSize.width*self.scaleX);
    _flag.position=ccp(realWidht/self.scaleX, _flag.position.y);
    
    [self updateProgress];
}

-(void) updateProgressWithValue :(NSInteger) _Value
{
    currentValue=_Value;
    
    [self updateProgress];
}
-(void) updateProgress
{
    if(currentValue>maxValue)
        currentValue=maxValue;
    
    CGFloat _newScale=(currentValue/maxValue)*_BG.scaleX;
    id actionScale =[CCActionScaleTo actionWithDuration:0.3f scaleX:_newScale scaleY:_progressBar.scaleY];
    [_progressBar runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.15f],actionScale, nil ]];
    
       CGFloat newWormPos=_progressBar.position.x + _progressBar.contentSize.width*_newScale + _worm.contentSize.width*_worm.scaleX*self.scaleX/2;
   
    CGSize s = [CCDirector sharedDirector].viewSize;
    if (newWormPos>_flag.position.x-32.f)
        newWormPos=_flag.position.x-32.f;

    
    id actionMove =[CCActionMoveTo actionWithDuration:0.3f position:ccp(newWormPos,_worm.position.y)];
    [_worm runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.5f],actionMove,nil]];
    
    CCBAnimationManager* animationManager = _worm.userObject;
    [animationManager runAnimationsForSequenceNamed: [animationManager runningSequenceName]];

    
}
@end
