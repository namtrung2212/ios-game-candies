//
//  GameOver.m
//  Candy
//
//  Created by Nam Trung on 1/23/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//
#define ARC4RANDOM_MAX      0x100000000
#import "GameOver.h"
#import "GamePlay.h"
#import "Candy.h"
@implementation GameOver
{
    CCNode* _lblTitle;
    CCNode* _lblLevel;
    CCNode* _lblCoinNo;
    CCNode* _lblStarNo;
    CCNode* _lblGameOver;
    CCNode* _btnMenu;
    CCNode* _btnReload;
    CCNode* _btnNextLevel;
    CCNode* _coin;
    CCNode* _star;

    CGFloat levelScore;
    CGFloat totalScore;
    BOOL isShown;
}
- (void)didLoadFromCCB {
    isShown=false;
}

-(BOOL) IsGameOver
{
    
    if([[GamePlay instance] isTimeUp] || [[GamePlay instance] getStarNo] >= [[GamePlay instance] getStarNoRequire])
        return true;
    
    if([[GamePlay instance] isFalling])
        return false;
    
    for(Candy* _candy in [[GamePlay instance] Candies])
    {
            Candy* _candy01=[[GamePlay instance] getCandyByAddress:_candy.rowNumber:_candy.colNumber +1];
            Candy* _candy02=[[GamePlay instance] getCandyByAddress:_candy.rowNumber:_candy.colNumber -1];
            Candy* _candy03=[[GamePlay instance] getCandyByAddress:_candy.rowNumber+1:_candy.colNumber];
            Candy* _candy04=[[GamePlay instance] getCandyByAddress:_candy.rowNumber-1:_candy.colNumber];
            if(_candy01!=nil && [[_candy01 getType] isEqualToString:[_candy getType]])
            {
                if(_candy02!=nil && [[_candy02 getType] isEqualToString:[_candy getType]])
                    return false;
            }
            
            if(_candy03!=nil && [[_candy03 getType] isEqualToString:[_candy getType]])
            {
                if(_candy04!=nil && [[_candy04 getType] isEqualToString:[_candy getType]])
                    return false;
            }
            
            Candy* _candy2=[[GamePlay instance] getCandyByAddress:_candy.rowNumber:_candy.colNumber +1];
            if(_candy2!=nil && [[_candy2 getType] isEqualToString:[_candy getType]]==false)
            {
              
                Candy* _candy3=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber:_candy2.colNumber +1];
                Candy* _candy4=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber:_candy2.colNumber +2];
                Candy* _candy5=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber+1:_candy2.colNumber];
                Candy* _candy6=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber+2:_candy2.colNumber];
                Candy* _candy7=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber-1:_candy2.colNumber];
                Candy* _candy8=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber-2:_candy2.colNumber];
                
                if(_candy3!=nil && [[_candy3 getType] isEqualToString:[_candy getType]])
                {
                    if(_candy4!=nil && [[_candy4 getType] isEqualToString:[_candy getType]])
                        return false;
                }
                
                if(_candy5!=nil && [[_candy5 getType] isEqualToString:[_candy getType]])
                {
                    if(_candy6!=nil && [[_candy6 getType] isEqualToString:[_candy getType]])
                        return false;
                    
                    if(_candy7!=nil && [[_candy7 getType] isEqualToString:[_candy getType]])
                        return false;
                }
                
                if(_candy7!=nil && [[_candy7 getType] isEqualToString:[_candy getType]])
                {
                    if(_candy8!=nil && [[_candy8 getType] isEqualToString:[_candy getType]])
                        return false;
                }
            }
        
        _candy2=[[GamePlay instance] getCandyByAddress:_candy.rowNumber:_candy.colNumber -1];
        if(_candy2!=nil && [[_candy2 getType] isEqualToString:[_candy getType]]==false)
        {
            
            Candy* _candy3=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber:_candy2.colNumber -1];
            Candy* _candy4=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber:_candy2.colNumber -2];
            Candy* _candy5=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber+1:_candy2.colNumber];
            Candy* _candy6=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber+2:_candy2.colNumber];
            Candy* _candy7=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber-1:_candy2.colNumber];
            Candy* _candy8=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber-2:_candy2.colNumber];
            
            if(_candy3!=nil && [[_candy3 getType] isEqualToString:[_candy getType]])
            {
                if(_candy4!=nil && [[_candy4 getType] isEqualToString:[_candy getType]])
                    return false;
            }
            
            if(_candy5!=nil && [[_candy5 getType] isEqualToString:[_candy getType]])
            {
                if(_candy6!=nil && [[_candy6 getType] isEqualToString:[_candy getType]])
                    return false;
                
                if(_candy7!=nil && [[_candy7 getType] isEqualToString:[_candy getType]])
                    return false;
            }
            
            if(_candy7!=nil && [[_candy7 getType] isEqualToString:[_candy getType]])
            {
                if(_candy8!=nil && [[_candy8 getType] isEqualToString:[_candy getType]])
                    return false;
            }
        }

        _candy2=[[GamePlay instance] getCandyByAddress:_candy.rowNumber+1:_candy.colNumber];
        if(_candy2!=nil && [[_candy2 getType] isEqualToString:[_candy getType]]==false)
        {
            
            Candy* _candy3=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber+1:_candy2.colNumber];
            Candy* _candy4=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber+2:_candy2.colNumber];
            Candy* _candy5=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber:_candy2.colNumber+1];
            Candy* _candy6=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber:_candy2.colNumber+2];
            Candy* _candy7=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber:_candy2.colNumber-1];
            Candy* _candy8=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber:_candy2.colNumber-2];
            
            if(_candy3!=nil && [[_candy3 getType] isEqualToString:[_candy getType]])
            {
                if(_candy4!=nil && [[_candy4 getType] isEqualToString:[_candy getType]])
                    return false;
            }
            
            if(_candy5!=nil && [[_candy5 getType] isEqualToString:[_candy getType]])
            {
                if(_candy6!=nil && [[_candy6 getType] isEqualToString:[_candy getType]])
                    return false;
                
                if(_candy7!=nil && [[_candy7 getType] isEqualToString:[_candy getType]])
                    return false;
            }
            
            if(_candy7!=nil && [[_candy7 getType] isEqualToString:[_candy getType]])
            {
                if(_candy8!=nil && [[_candy8 getType] isEqualToString:[_candy getType]])
                    return false;
            }
        }

        
        _candy2=[[GamePlay instance] getCandyByAddress:_candy.rowNumber-1:_candy.colNumber];
        if(_candy2!=nil && [[_candy2 getType] isEqualToString:[_candy getType]]==false)
        {
            
            Candy* _candy3=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber-1:_candy2.colNumber];
            Candy* _candy4=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber-2:_candy2.colNumber];
            Candy* _candy5=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber:_candy2.colNumber+1];
            Candy* _candy6=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber:_candy2.colNumber+2];
            Candy* _candy7=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber:_candy2.colNumber-1];
            Candy* _candy8=[[GamePlay instance] getCandyByAddress:_candy2.rowNumber:_candy2.colNumber-2];
            
            if(_candy3!=nil && [[_candy3 getType] isEqualToString:[_candy getType]])
            {
                if(_candy4!=nil && [[_candy4 getType] isEqualToString:[_candy getType]])
                    return false;
            }
            
            if(_candy5!=nil && [[_candy5 getType] isEqualToString:[_candy getType]])
            {
                if(_candy6!=nil && [[_candy6 getType] isEqualToString:[_candy getType]])
                    return false;
                
                if(_candy7!=nil && [[_candy7 getType] isEqualToString:[_candy getType]])
                    return false;
            }
            
            if(_candy7!=nil && [[_candy7 getType] isEqualToString:[_candy getType]])
            {
                if(_candy8!=nil && [[_candy8 getType] isEqualToString:[_candy getType]])
                    return false;
            }
        }
        

      
    }
    
    return  true;
}

-(void) ShowGameOver
{
    [[GamePlay instance] setColor: [CCColor colorWithRed:0.25 green:0.25 blue:0.25] ];
    [self ShowGameOverPanel];

}
-(void) ShowGameOverPanel
{
    if(self.visible==false&& isShown==false)
    {
        isShown=true;
        
        self.zOrder=100000;
        self.scaleX=0.5f;
        self.scaleY=0.5f;
        
        CGSize s = [CCDirector sharedDirector].viewSize;
        /*
        CCParticleExplosion* particle;
        particle = [[CCParticleExplosion alloc] initWithTotalParticles:100];
        particle.texture = [[CCTextureCache sharedTextureCache] addImage:@"coin2.png"];
        particle.emissionRate=2160.00;
        particle.angle=90.0;
        particle.angleVar=40.0;
        ccBlendFunc blendFunc={GL_SRC_ALPHA,GL_ONE};
        particle.blendFunc=blendFunc;
        particle.duration=0.82;
        //  particle.emitterMode=kCCParticleModeGravity;
        ccColor4F startColor={0.67,0.89,0.93,0.00};
        particle.startColor=[CCColor colorWithCcColor4f:startColor];
        ccColor4F startColorVar={0.00,0.00,0.00,0.28};
        particle.startColorVar=[CCColor colorWithCcColor4f:startColorVar];
        ccColor4F endColor={0.62,0.92,0.67,0.00};
        particle.endColor=[CCColor colorWithCcColor4f:endColor];
        ccColor4F endColorVar={0.00,0.00,0.00,0.33};
        particle.endColorVar=[CCColor colorWithCcColor4f:endColorVar];
        particle.startSize=70.00;
        particle.startSizeVar=70.00;
        particle.endSize=7.73;
        particle.endSizeVar=2.95;
        particle.gravity=ccp(0.00,-500.00);
        particle.radialAccel=-320.00;
        particle.radialAccelVar=-200.00;
        particle.speed=100;
        particle.speedVar=50;
        particle.tangentialAccel=15;
        particle.tangentialAccelVar=270;
        particle.totalParticles=648;
        particle.life=0.0;
        particle.lifeVar=0.20;
        particle.startSpin=0.00;
        particle.startSpinVar=0.00;
        particle.endSpin=0.00;
        particle.endSpinVar=0.00;
        particle.position=ccp(self.position.x,self.position.y);
        particle.posVar=ccp(82.99,83.77);
        particle.zOrder=self.zOrder;
        particle.scaleX=2.f;
        particle.scaleY=2.f;

         
        [[GamePlay instance] addChild:particle];
        [particle resetSystem];
        */
        
      
        _lblTitle.rotation=-1.4f;
        [(CCLabelTTF*)_lblLevel setString:[NSString stringWithFormat:@"%@ %d",NSLocalizedString(@"Level", nil),[GamePlay getLevelNo]]];

        [(CCLabelTTF*)_lblCoinNo setString:[NSString stringWithFormat:@"0 x",nil]];
        [(CCLabelTTF*)_lblStarNo setString:[NSString stringWithFormat:@"0 x",nil]];
        
        NSString* systemScore=[[NSUserDefaults standardUserDefaults ] objectForKey:@"systemScore"];
        if(systemScore==nil)
            systemScore=@"0";
        
        [(CCLabelTTF*)_lblCoinNo setString:[NSString stringWithFormat:@"%d x",systemScore.integerValue]];
        
        levelScore=[[GamePlay instance] getScore];
        systemScore = [NSString stringWithFormat:@"%d",[systemScore integerValue] + [[GamePlay instance] getScore]];
        [[NSUserDefaults standardUserDefaults ]  setObject:systemScore forKey:@"systemScore"];
        systemScore=[[NSUserDefaults standardUserDefaults ]  objectForKey:@"systemScore"];
        totalScore=systemScore.intValue;
        

        
        if([[GamePlay instance] getStarNo]>=[[GamePlay instance] getStarNoRequire])
        {
            [(CCLabelTTF*)_lblGameOver setString:[NSString stringWithFormat:NSLocalizedString(@"YouWin", nil),nil]];
            
            if([[GamePlay instance] getCurrentTime]>=[[GamePlay instance] getMaxTime])
                [(CCLabelTTF*)_lblTitle setString:[NSString stringWithFormat:NSLocalizedString(@"TimeUp", nil),nil]];
            else
                [(CCLabelTTF*)_lblTitle setString:[NSString stringWithFormat:NSLocalizedString(@"Finished", nil),nil]];
            ((CCButton*)_btnNextLevel).enabled =true;
            
            
            NSString* currentLevel=[NSString stringWithFormat:@"%d", [GamePlay getLevelNo]];
            NSString* bestLevel=[[NSUserDefaults standardUserDefaults ] objectForKey:@"bestLevel"];
            if(bestLevel==nil)
                bestLevel=@"1";
            
            if([GamePlay getLevelNo]>=[bestLevel integerValue])
            {
                [[NSUserDefaults standardUserDefaults ]  setObject:currentLevel forKey:@"bestLevel"];
                bestLevel=[[NSUserDefaults standardUserDefaults ]  objectForKey:@"bestLevel"];
            }

         
        }
        else
        {
            [(CCLabelTTF*)_lblGameOver setString:[NSString stringWithFormat:NSLocalizedString(@"YouLoose", nil),nil]];
            
            if([[GamePlay instance] getCurrentTime]>=[[GamePlay instance] getMaxTime])
                [(CCLabelTTF*)_lblTitle setString:[NSString stringWithFormat:NSLocalizedString(@"TimeUp", nil),nil]];
            else
                [(CCLabelTTF*)_lblTitle setString:[NSString stringWithFormat:NSLocalizedString(@"GameOver", nil),nil]];
            ((CCButton*)_btnNextLevel).enabled =false;

        }
        _lblGameOver.visible=false;
        
        self.position=ccp(s.width/2,s.height + self.contentSize.height/2-50.f);
        id action1=[CCActionFadeIn actionWithDuration:0.3f];
        id action2=[CCActionScaleTo actionWithDuration:0.3f scale:1.f];
        id action3=[CCActionMoveTo actionWithDuration:0.3f position:ccp(s.width/2 ,s.height/2 -10.f) ];
        id action4=[CCActionSpawn actions:[CCActionShow action],action1,action2,action3, nil];
        
        id action5 =[CCActionMoveTo actionWithDuration:0.1f position:ccp(s.width/2,s.height/2+10.f) ];
        id action6 =[CCActionMoveTo actionWithDuration:0.1f position:ccp(s.width/2,s.height/2) ];
        [self runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.6f],action4,action5,action6,[CCActionDelay actionWithDuration:0.3f],[CCActionCallFunc actionWithTarget:self selector:@selector(ShowAnimation)], nil]];
        
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"Sounds/TimeUp.mp3" volume:1.f pitch:1.f pan:0 loop:false];
    }
}
-(void) ShowAnimation
{
 
    
    id action4 =[CCActionScaleTo actionWithDuration:0.6f scale:1.3f];
    id action5 =[CCActionScaleTo actionWithDuration:0.6f scale:1.2f];
    id action6 = [CCActionRepeatForever actionWithAction:[CCActionSequence actions:action4,action5,nil]];
    [_coin runAction:action6];
    
    id action7 =[CCActionScaleTo actionWithDuration:0.6f scale:1.3f];
    id action8 =[CCActionScaleTo actionWithDuration:0.6f scale:1.2f];
    id action9 = [CCActionRepeatForever actionWithAction:[CCActionSequence actions:action7,action8,nil]];
    [_star runAction:action9];
    
    
    __block CGFloat blockScore=totalScore-levelScore;
    __block CGFloat blockIncrease=levelScore/20;
    id action10 = [CCActionCallBlock actionWithBlock:^{
        blockScore+=blockIncrease;
        if(blockScore>totalScore)
            blockScore=totalScore;
        
        [(CCLabelTTF*)_lblCoinNo setString:[NSString stringWithFormat:@"%d x",(int)blockScore]];
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"Sounds/Coin2.mp3" volume:0.2f pitch:1.f pan:0 loop:false];
          }];
    
        id action12 = [CCActionCallBlock actionWithBlock:^{
            
            [(CCLabelTTF*)_lblCoinNo setString:[NSString stringWithFormat:@"%d x",(int)totalScore]];
        
            
            _lblGameOver.scaleX=10.f;
            _lblGameOver.scaleY=10.f;
            id action1=[CCActionFadeIn actionWithDuration:0.2f];
            id action2=[CCActionScaleTo actionWithDuration:0.2f scale:0.8f];
            id action4=[CCActionSpawn actions:[CCActionShow action],action1,action2, nil];
            id action5=[CCActionScaleTo actionWithDuration:0.1f scale:1.f];
            [_lblGameOver runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.1f],action4,action5, nil]];
            
            OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
            [audio playEffect:@"Sounds/LevelResult.mp3" volume:0.7f pitch:1.f pan:0 loop:false];
            

        }];
    
    id action13=[CCActionRepeat actionWithAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.1f],action10,nil] times:(levelScore/blockIncrease) +1];
    
    [self runAction:[CCActionSequence actions :action13,action12,nil]];
    
    __block NSInteger blockStar=0;
    id action11 = [CCActionCallBlock actionWithBlock:^{
        blockStar++;
        if(blockStar>[[GamePlay instance] getStarNo])
            blockStar=[[GamePlay instance] getStarNo];
        
        [(CCLabelTTF*)_lblStarNo setString:[NSString stringWithFormat:@"%d x",blockStar]];
        
    }];
    
    [self runAction:[CCActionRepeat actionWithAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.1f],action11,nil] times:[[GamePlay instance] getStarNo]]];

}
-(void) MenuAction
{
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"Sounds/Click.mp3" volume:1.f pitch:1.f pan:0 loop:false];
    
    [[[GamePlay instance] getMainMenu] ShowMainMenu];
    
    
    CGSize s = [CCDirector sharedDirector].viewSize;

    id action1=[CCActionFadeOut actionWithDuration:0.3f];
    id action2=[CCActionScaleTo actionWithDuration:0.3f scale:0.5f];
    id action3=[CCActionMoveTo actionWithDuration:0.3f position:ccp(s.width/2 , -300.f) ];
    id action4=[CCActionSpawn actions:[CCActionShow action],action1,action2,action3, nil];
    
    [self runAction:[CCActionSequence actions:action4,nil]];

}
-(void) ReloadAction
{
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"Sounds/Click.mp3" volume:1.f pitch:1.f pan:0 loop:false];
    
    GamePlay* gameplayScene= (GamePlay*) [CCBReader loadAsScene:@"GamePlay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
    
}
-(void) NextLevelAction
{
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"Sounds/Click.mp3" volume:1.f pitch:1.f pan:0 loop:false];
    
    NSInteger currentLevelNo=[GamePlay getLevelNo];
    [GamePlay setLevelNo:currentLevelNo+1 ];
    GamePlay* gameplayScene= (GamePlay*) [CCBReader loadAsScene:@"GamePlay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
