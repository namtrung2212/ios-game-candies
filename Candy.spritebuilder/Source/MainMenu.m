//
//  MainMenu.m
//  Candy
//
//  Created by Nam Trung on 1/25/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//
#define ARC4RANDOM_MAX      0x100000000

#import "GamePlay.h"
#import "MainMenu.h"
#import "LevelButton.h"

@implementation MainMenu
{
    CCNode* _lblTitle;
    CCNode* _btnRight;
    CCNode* _btnLeft;
    CCNode* _btnClose;
    
    BOOL isShown;
    
    NSMutableArray* _levels;
}
- (void)didLoadFromCCB {
    isShown=false;
    currentPage=1;
    
    [(CCLabelTTF*)_lblTitle setString:[NSString stringWithFormat:NSLocalizedString(@"Levels", nil),nil]];
    
    [self InitLevels];
}

int currentPage;
-(void) InitLevels
{
    if(_levels!=nil)
    {
        for(CCNode* node in _levels)
            [node removeFromParent];
    }
    _levels = [NSMutableArray array];
    
    CGSize s = [CCDirector sharedDirector].viewSize;
    
    
    NSString* bestLevel=[[NSUserDefaults standardUserDefaults ] objectForKey:@"bestLevel"];
    if(bestLevel==nil)
        bestLevel=@"0";
    
    int count=0;
     for(int page=1; page<=8;page++)
     {
         for(int i=1; i<=12;i++)
         {
             count++;
             LevelButton* _levelNode= (LevelButton*)[CCBReader load:@"LevelNode"];
             
             CGFloat indentX=110.f;
             int col=((i-1) % 4);
             int row=((i-1) / 4);
             
             
             _levelNode.positionType = CCPositionTypeMake(CCPositionUnitPoints, CCPositionUnitPoints, CCPositionReferenceCornerTopLeft) ;
             _levelNode.position=ccp(col*100.f+ indentX,row*120.f + 170.f);
             [_levelNode setNumber:count : page];
             
             [_levelNode setEnable:count<=[bestLevel integerValue]+1];
             [_lblTitle.parent addChild:_levelNode];
             [_levels addObject:_levelNode];
             
         }
     }
    
     currentPage=1;
    [self RefreshPage];
}

-(void) RefreshPage
{
    NSString* bestLevel=[[NSUserDefaults standardUserDefaults ] objectForKey:@"bestLevel"];
    if(bestLevel==nil)
        bestLevel=@"0";
    

    for(LevelButton* _levelNode in _levels)
    {
        [_levelNode setEnable:[_levelNode getNumber] <=[bestLevel integerValue] +1];
        _levelNode.visible=([_levelNode getPage]==currentPage);
    }
    
    if(currentPage==8)
    {
        ((CCButton*)_btnRight).enabled =false;
        ((CCButton*)_btnLeft).enabled =true;
    }
    
    else if(currentPage==1)
    {
        ((CCButton*)_btnLeft).enabled =false;
        ((CCButton*)_btnRight).enabled =true;
    }
    else
    {
        ((CCButton*)_btnLeft).enabled =true;
        ((CCButton*)_btnRight).enabled =true;
    }
}

-(void) ShowMainMenu
{
    NSString* bestLevel=[[NSUserDefaults standardUserDefaults ] objectForKey:@"bestLevel"];
    if(bestLevel==nil)
        bestLevel=@"0";
    
    currentPage=([bestLevel integerValue] -1)/12 +1;
    [self RefreshPage];
    
    [[GamePlay instance] setColor: [CCColor colorWithRed:0.25 green:0.25 blue:0.25] ];
    [self ShowMainMenuPanel];
    

    
}
-(void) ShowMainMenuPanel
{
        
        self.zOrder=100000;
        self.scaleX=0.5f;
        self.scaleY=0.5f;
        
        CGSize s = [CCDirector sharedDirector].viewSize;
       
        self.position=ccp(s.width/2,s.height + 300.f);
        id action1=[CCActionFadeIn actionWithDuration:0.3f];
        id action2=[CCActionScaleTo actionWithDuration:0.3f scale:1.f];
        id action3=[CCActionMoveTo actionWithDuration:0.3f position:ccp(s.width/2 ,s.height/2 -10.f) ];
        id action4=[CCActionSpawn actions:[CCActionShow action],action1,action2,action3, nil];
        
        id action5 =[CCActionMoveTo actionWithDuration:0.1f position:ccp(s.width/2,s.height/2+10.f) ];
        id action6 =[CCActionMoveTo actionWithDuration:0.1f position:ccp(s.width/2,s.height/2) ];
        [self runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.6f],action4,action5,action6,[CCActionDelay actionWithDuration:0.6f],[CCActionCallFunc actionWithTarget:self selector:@selector(ShowAnimation)], nil]];
    
}
-(void) ShowAnimation
{
    
    
   
}

-(void) NextPageAction
{
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"Sounds/Click.mp3" volume:1.f pitch:1.f pan:0 loop:false];
    
    if(currentPage<8)
    {
        currentPage++;
        [self RefreshPage];
    }
}
-(void) PreviousPageAction
{
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"Sounds/Click.mp3" volume:1.f pitch:1.f pan:0 loop:false];
    
    if(currentPage>1)
    {
        currentPage--;
        [self RefreshPage];
    }
}
-(void) CloseAction
{
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"Sounds/Click.mp3" volume:1.f pitch:1.f pan:0 loop:false];
    
  
    CGSize s = [CCDirector sharedDirector].viewSize;
    
    id action1=[CCActionFadeOut actionWithDuration:0.3f];
    id action2=[CCActionScaleTo actionWithDuration:0.3f scale:0.5f];
    id action3=[CCActionMoveTo actionWithDuration:0.3f position:ccp(s.width/2 , -300.f) ];
    id action4=[CCActionSpawn actions:[CCActionShow action],action1,action2,action3, nil];
    
    [self runAction:[CCActionSequence actions:action4,nil]];
    
    [[GamePlay instance] getGameOver].scaleX=0.5f;
    [[GamePlay instance] getGameOver].scaleY=0.5f;
    [[GamePlay instance] getGameOver].position=ccp(s.width/2,s.height + [[GamePlay instance] getGameOver].contentSize.height/2-50.f);
    id action5=[CCActionFadeOut actionWithDuration:0.3f];
    id action6=[CCActionScaleTo actionWithDuration:0.3f scale:1.f];
    id action7=[CCActionMoveTo actionWithDuration:0.3f position:ccp(s.width/2 ,s.height/2 -10.f) ];
    id action8=[CCActionSpawn actions:[CCActionShow action],action5,action6,action7, nil];
    [[[GamePlay instance] getGameOver] runAction:[CCActionSequence actions:action8,nil]];
}
@end
