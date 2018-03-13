//
//  LevelButton.m
//  Candy
//
//  Created by Nam Trung on 1/25/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "LevelButton.h"
#import "GamePlay.h"
@implementation LevelButton
{
    CCNode* _buttonNode;
    NSInteger Number;
    NSInteger Page;

}

-(void) setEnable:(BOOL) _enable
{
    ((CCButton*)_buttonNode).enabled =_enable;
}


-(void) setNumber:(NSInteger) _no:(NSInteger) _page
{
    Number=_no;
    Page=_page;
    [ ((CCLabelTTF* ) ((CCButton*) _buttonNode).label) setString:[NSString stringWithFormat:@"%d",_no]];
    ((CCLabelTTF* ) ((CCButton*) _buttonNode).label).position = ccp(-10,0);

}

-(NSInteger) getNumber
{
    return Number;
}

-(NSInteger) getPage
{
    return Page;
}

-(void) ClickAction
{
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"Sounds/LevelClick.mp3" volume:1.f pitch:1.f pan:0 loop:false];
    
    [GamePlay setLevelNo:Number];
    GamePlay* gameplayScene= (GamePlay*) [CCBReader loadAsScene:@"GamePlay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];

}
@end
