//
//  GamePlay.m
//  Candy
//
//  Created by Nam Trung on 1/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GamePlay.h"
#import "GameOver.h"
#define ARC4RANDOM_MAX      0x100000000
#define CANDYNODESCALE      1.f
#define CELLBGSCALE      0.9f
#define CELLBGWIDHT      330.f

@implementation GamePlay
{
    CCNode* _Grids;
    Level1* _level;
    CCNode* _scoreLabel;
    CCNode* _starLabel;
    CCNode* _levelLabel;
    
    GameOver* _gameOver;
    MainMenu* _mainMenu;
    
    ProgressTimer* _progressTimer;
    
    
    NSMutableArray *_cells;
    NSMutableArray *_candies;
    
    NSInteger CellVisibleNo;
    
    NSInteger rowNo;
    NSInteger colNo;
    
    CGFloat candyScale;
    CGFloat exploreScale;
    CGFloat nodeIndent;
    NSInteger candyTypeNo;
    NSInteger destStar;
    NSInteger currentScore;
    NSInteger currentStar;
    NSInteger boardType;
    NSInteger maxTime;
    NSInteger currenTime;
    
    
}

-(CGFloat) getCandyScale
{
    return candyScale;
}

-(CGFloat) getExploreScale
{
    return exploreScale;
}

-(CGFloat) getExploreWeight
{
    return 1.37f;
}

-(CGFloat) getNodeIndent
{
    return  nodeIndent;
}

static GamePlay* _gamePlay;
static  NSInteger levelNo=0;
+ (GamePlay*) instance
{
    return _gamePlay;
}

-(GameOver*) getGameOver
{
    return  _gameOver;
}

-(MainMenu*) getMainMenu
{
    return  _mainMenu;
}
-(NSInteger) getRowNo
{
    return rowNo;
}
-(NSInteger) getColNo
{
    return colNo;
}
-(NSInteger) getCandyTypeNo
{
    return candyTypeNo;
}
-(NSInteger) getBoardType
{
    return boardType;
}
+ (NSInteger) getLevelNo
{
    return levelNo;
}
+ (void) setLevelNo: (NSInteger) _level
{
    levelNo=_level;
}

-(NSInteger) getMaxTime
{
    return maxTime;
}
-(NSInteger) getCurrentTime
{
    return currenTime;
}

-(NSInteger) getScore
{
    return currentScore;
}
-(NSInteger) getStarNo
{
    return currentStar;
}
-(NSInteger) getStarNoRequire
{
    return  destStar;
}

-(NSMutableArray *) Candies
{
    return _candies;
}
-(NSMutableArray *) Cells{
    return _cells;
}

-(BOOL) isTimeUp
{
    return [_progressTimer isTimeUp];
}


-(BOOL) isFalling
{
   return fallingCandies.count >0  || genningCandies.count>0  || combineCandies.count>0 || swtchingCandies.count>0 || (_candies.count<CellVisibleNo);
   
}

- (void)InitLevel : (NSInteger) _levelNbr{
    
    CGSize s = [CCDirector sharedDirector].viewSize;
    
    levelNo=_levelNbr;
    
    boardType =(levelNo % 5);
    //  destStar =(levelNo % 4) ==1 || (levelNo % 4) ==2 ? 15 :20;
    destStar=levelNo*1.3f +25;
    maxTime=levelNo*5.5 + 80;
    if(boardType==0 ||boardType==1)
        maxTime+=10;
    if(boardType==2)
        maxTime+=30;
   
    currentScore=0;
    currentStar =0;
    
    if(levelNo % 24 <=6)
        candyTypeNo=3;
    else if (levelNo % 24 <=10)
        candyTypeNo=4;
    else if (levelNo % 24 <=16)
        candyTypeNo=5;
    else if (levelNo % 24 <=1000)
        candyTypeNo=6;
    
    if(levelNo % 24==1.f)
    {
        rowNo=6;
        colNo=5;
        
    }else if(levelNo % 24==2.f)
    {
        rowNo=6;
        colNo=5;
    }else if(levelNo % 24==3.f)
    {
        rowNo=6;
        colNo=5;
    }
    else if(levelNo % 24==4.f)
    {
        rowNo=6;
        colNo=5;
    }
    
    else if(levelNo % 24==5.f)
    {
        rowNo=8;
        colNo=5;
    }else if(levelNo % 24==6.f)
    {
        rowNo=8;
        colNo=5;
    }else if(levelNo % 24==7.f)
    {
        rowNo=7;
        colNo=5;
    }
    else if(levelNo % 24==8.f)
    {
        candyTypeNo=4;
        rowNo=6;
        colNo=5;
    }
    
    else if(levelNo % 24==9.f)
    {
        rowNo=8;
        colNo=6;
        
    }else if(levelNo % 24==10.f)
    {
        rowNo=8;
        colNo=6;
    }else if(levelNo % 24==11.f)
    {
        rowNo=7;
        colNo=6;
    }
    else if(levelNo % 24==12.f)
    {
        rowNo=7;
        colNo=6;
    }
    
    else if(levelNo % 24==13.f)
    {
        candyTypeNo=5;
        rowNo=8;
        colNo=6;
    }else if(levelNo % 24==14.f)
    {
        rowNo=8;
        colNo=6;
    }else if(levelNo % 24==15.f)
    {
        rowNo=7;
        colNo=6;
    }
    else if(levelNo % 24==16.f)
    {
        rowNo=7;
        colNo=6;
    }
    
    else if(levelNo % 24==17.f)
    {
        rowNo=8;
        colNo=6;
    }else if(levelNo % 24==18.f)
    {
        rowNo=8;
        colNo=6;
    }else if(levelNo % 24==19.f)
    {
        rowNo=8;
        colNo=6;
    }
    else if(levelNo % 24==20.f)
    {
        rowNo=7;
        colNo=6;
    }
    
    else if(levelNo==21.f)
    {
        rowNo=8;
        colNo=6;
    }else if(levelNo % 24==22.f)
    {
        rowNo=8;
        colNo=6;
    }else if(levelNo % 24==23.f)
    {
        rowNo=8;
        colNo=6;
    }
    else if(levelNo % 24==0.f)
    {
        rowNo=8;
        colNo=6;
    } else
    {
        rowNo=8;
        colNo=6;
    }
    
    
    [(CCLabelTTF*)_scoreLabel setString:[NSString stringWithFormat:@"%d",currentScore]];
    [(CCLabelTTF*)_starLabel setString:[NSString stringWithFormat:@"%d/%d",currentStar,destStar]];
    [(CCLabelTTF*)_levelLabel setString:[NSString stringWithFormat:@"%@ %d",NSLocalizedString(@"Level", nil),levelNo]];
    _levelLabel.positionType = CCPositionTypeMake(CCPositionUnitPoints, CCPositionUnitPoints, CCPositionReferenceCornerTopLeft) ;
    _levelLabel.position=ccp(s.width/2,40.f);
    
    
    [_progressTimer resetProgress:maxTime];
    
    nodeIndent=90.f;
    CGFloat candyScale1  =(((s.height-[[GamePlay instance] getNodeIndent])/rowNo))/(CELLBGWIDHT * CELLBGSCALE);
    CGFloat candyScale2  =(((s.width*0.96f)/colNo))/(CELLBGWIDHT * CELLBGSCALE);
    candyScale=candyScale1;
    if(candyScale>candyScale2)
        candyScale=candyScale2;
    if(candyScale>0.2f)
        candyScale=0.2f;
    nodeIndent =(s.height-90.f-(candyScale * CELLBGWIDHT * CELLBGSCALE)*rowNo)/2 +90.f;
    //if(nodeIndent<90.f)
    //  nodeIndent=90.f;
    
    exploreScale=1.675 *candyScale;
    
    CellVisibleNo=0;
    
    
    [self initCells];
}

- (void)didLoadFromCCB {
    
    
    _gamePlay=self;
    
    [[CCTextureCache sharedTextureCache] addImage:@"Resources/BG/bg1.png"];
    [[CCTextureCache sharedTextureCache] addImage:@"Resources/BG/bg2.png"];
    [[CCTextureCache sharedTextureCache] addImage:@"Resources/BG/bg3.png"];
    [[CCTextureCache sharedTextureCache] addImage:@"Resources/BG/bg4.png"];
    [[CCTextureCache sharedTextureCache] addImage:@"Resources/BG/bg5.png"];
    [[CCTextureCache sharedTextureCache] addImage:@"Resources/BG/bg6.png"];
    [[CCTextureCache sharedTextureCache] addImage:@"Resources/BG/controlPanel.png"];
    [[CCTextureCache sharedTextureCache] addImage:@"Resources/BG/GameOver.png"];
    [[CCTextureCache sharedTextureCache] addImage:@"focus2.png"];
    [[CCTextureCache sharedTextureCache] addImage:@"coin2.png"];
    
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Resources/Sprite1s.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Resources/Sprite2s.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Resources/Others.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Resources/Grounds.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Resources/Banner.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Resources/GameOver.plist"];
   
    
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio stopEverything];
    CGFloat randSong=((double)arc4random() / ARC4RANDOM_MAX)*4;
    if( randSong <=1)
    {
        [audio playBg:@"Sounds/BG1.mp3" volume:0.17f pan:0 loop:true];
    }
    else if( randSong <=2)
    {
        [audio playBg:@"Sounds/BG2.mp3" volume:0.17f pan:0 loop:true];
    }
    else if( randSong <=3)
    {
        [audio playBg:@"Sounds/BG3.mp3" volume:0.17f pan:0 loop:true];
    }
    else if( randSong <=64)
    {
        [audio playBg:@"Sounds/BG4.mp3" volume:0.17f pan:0 loop:true];
    }
    
    

    
    self.userInteractionEnabled = TRUE;
    _Grids.userInteractionEnabled=FALSE;
    _level.userInteractionEnabled=FALSE;
    
    _Grids.zOrder=-1;
    _level.zOrder=-1;
    _Grids.zOrder=_level.zOrder+1;
    
    
    [self randomSnow];
    //[self schedule:@selector(randomSnow) interval:100.5f ];
    
    CGSize s = [CCDirector sharedDirector].viewSize;
    _gameOver = (GameOver*)[CCBReader load:@"GameOver"];
    _gameOver.position=ccp(s.width/2,s.height/2);
    _gameOver.zOrder= _Grids.zOrder+2;
    [self addChild:_gameOver];
    _gameOver.visible=false;
   
    _mainMenu = (GameOver*)[CCBReader load:@"MenuLevel"];
    _mainMenu.position=ccp(s.width/2,s.height/2);
    _mainMenu.zOrder= _Grids.zOrder+2;
    [self addChild:_mainMenu];
    _mainMenu.visible=false;

    [self InitLevel:levelNo];
    
}


-(void) randomSnow
{
    
    CGFloat random = ((double)arc4random() / ARC4RANDOM_MAX)*10.f;
    if(random<=2.5f)
    {
        CCParticleSnow* particle;
        particle = [[CCParticleSnow alloc] initWithTotalParticles:400];
        particle.texture = [[CCTextureCache sharedTextureCache] addImage:@"focus2.png"];
        particle.emissionRate=500.00;
        particle.angle=0.0;
        particle.angleVar=5.0;
        ccBlendFunc blendFunc={GL_ONE,GL_ONE_MINUS_SRC_ALPHA};
        particle.blendFunc=blendFunc;
        particle.duration=10.00;
        // particle.emitterMode=kCCParticleModeGravity;
        ccColor4F startColor={1.00,1.00,1.00,1.00};
        particle.startColor=[CCColor colorWithCcColor4f:startColor];
        ccColor4F startColorVar={0.00,0.00,0.00,0.00};
        particle.startColorVar=[CCColor colorWithCcColor4f:startColorVar];
        ccColor4F endColor={1.00,1.00,1.00,0.00};
        particle.endColor=[CCColor colorWithCcColor4f:endColor];
        ccColor4F endColorVar={0.00,0.00,0.00,0.00};
        particle.endColorVar=[CCColor colorWithCcColor4f:endColorVar];
        particle.startSize=8.00;
        particle.startSizeVar=5.00;
        particle.endSize=8.00;
        particle.endSizeVar=5.00;
        particle.gravity=ccp(50.00,-100.00);
        particle.radialAccel=0.00;
        particle.radialAccelVar=1.00;
        particle.speed=250;
        particle.speedVar=220;
        particle.tangentialAccel= 0;
        particle.tangentialAccelVar= 1;
        particle.totalParticles=1000;
        particle.life=2.00;
        particle.lifeVar=10.00;
        particle.startSpin=0.00;
        particle.startSpinVar=0.00;
        particle.endSpin=0.00;
        particle.endSpinVar=0.00;
        particle.position=ccp(9.00,189.00);
        particle.posVar=ccp(20.00,200.00);
        
        [self addChild:particle];
        
        CGSize s = [CCDirector sharedDirector].viewSize;
        
        particle.position = ccp(-50,s.height-100);
        [particle resetSystem];
        
    }else if(random<5.f)
    {
        CCParticleSnow* particle;
        particle = [[CCParticleSnow alloc] initWithTotalParticles:500];
        particle.texture = [[CCTextureCache sharedTextureCache] addImage:@"focus2.png"];
        particle.emissionRate=1250.00;
        particle.angle=313.0;
        particle.angleVar=10.0;
        ccBlendFunc blendFunc={GL_SRC_ALPHA,GL_ONE};
        particle.blendFunc=blendFunc;
        particle.duration=10.00;
        // particle.emitterMode=kCCParticleModeGravity;
        ccColor4F startColor={0.41,0.51,0.76,1.00};
        particle.startColor=[CCColor colorWithCcColor4f:startColor];
        ccColor4F startColorVar={0.00,0.00,0.00,0.00};
        particle.startColorVar=[CCColor colorWithCcColor4f:startColorVar];
        ccColor4F endColor={0.39,0.40,0.47,1.00};
        particle.endColor=[CCColor colorWithCcColor4f:endColor];
        ccColor4F endColorVar={0.00,0.00,0.00,0.00};
        particle.endColorVar=[CCColor colorWithCcColor4f:endColorVar];
        particle.startSize=8.00;
        particle.startSizeVar=22.00;
        particle.endSize=0.00;
        particle.endSizeVar=0.00;
        particle.gravity=ccp(0.00,2076.88);
        particle.radialAccel=1000.00;
        particle.radialAccelVar=0.00;
        particle.speed=375;
        particle.speedVar=50;
        particle.tangentialAccel=-100;
        particle.tangentialAccelVar= 0;
        particle.totalParticles=1000;
        particle.life=0.80;
        particle.lifeVar=0.25;
        particle.startSpin=0.00;
        particle.startSpinVar=0.00;
        particle.endSpin=0.00;
        particle.endSpinVar=0.00;
        particle.position=ccp(218.00,288.00);
        particle.posVar=ccp(244.05,644.91);
        [self addChild:particle];
        
        CGSize s = [CCDirector sharedDirector].viewSize;
        
        particle.position = ccp(-50,s.height-100);
        [particle resetSystem];
    }else
    {
        CCParticleSnow* particle;
        particle = [[CCParticleSnow alloc] initWithTotalParticles:500];
        particle.texture = [[CCTextureCache sharedTextureCache] addImage:@"focus2.png"];
        particle.emissionRate=38.56;
        particle.angle=-90.0;
        particle.angleVar=5.0;
        ccBlendFunc blendFunc={GL_ONE,GL_ONE_MINUS_SRC_ALPHA};
        particle.blendFunc=blendFunc;
        particle.duration=-1.00;
        // particle.emitterMode=kCCParticleModeGravity;
        ccColor4F startColor={1.00,1.00,1.00,1.00};
        particle.startColor=[CCColor colorWithCcColor4f:startColor];
        ccColor4F startColorVar={0.00,0.00,0.00,0.00};
        particle.startColorVar=[CCColor colorWithCcColor4f:startColorVar];
        ccColor4F endColor={1.00,1.00,1.00,0.00};
        particle.endColor=[CCColor colorWithCcColor4f:endColor];
        ccColor4F endColorVar={0.00,0.00,0.00,0.00};
        particle.endColorVar=[CCColor colorWithCcColor4f:endColorVar];
        particle.startSize=10.00;
        particle.startSizeVar=5.00;
        particle.endSize=-1.00;
        particle.endSizeVar=0.00;
        particle.gravity=ccp(0.00,-634.06);
        particle.radialAccel=817.92;
        particle.radialAccelVar=-242.60;
        particle.speed=466;
        particle.speedVar=81;
        particle.tangentialAccel=1000;
        particle.tangentialAccelVar=329;
        particle.totalParticles=1735;
        particle.life=45.00;
        particle.lifeVar=15.00;
        particle.startSpin=0.00;
        particle.startSpinVar=0.00;
        particle.endSpin=0.00;
        particle.endSpinVar=0.00;
        particle.position=ccp(200.61,242.90);
        particle.posVar=ccp(240.00,126.04);
        [self addChild:particle];
        
        CGSize s = [CCDirector sharedDirector].viewSize;
        
        particle.position = ccp(-50,s.height-100);
        [particle resetSystem];
    }
}
- (void)initCells {
    CGSize s = [CCDirector sharedDirector].viewSize;
    
    // rowNo=(s.height*0.53f)/([Cell getCellWidht]) ;
    // colNo=(s.width*0.46f)/([Cell getCellWidht]) ;
    
    
    
    _cells = [NSMutableArray array];
    _candies = [NSMutableArray array];
    
    for(NSInteger i=0;i<rowNo;i++)
    {
        for(NSInteger j=0;j<colNo;j++)
        {
            Cell* _cell =(Cell*)[Cell loadCell:i :j];
            [_cells addObject:_cell];
            
        }
    }
    
    CellVisibleNo=0;
    for(Cell* _cell in _cells)
    {
        [_cell initCell];
        if([_cell getIsEmpty]==false)
            CellVisibleNo++;
    }
    
    while ([[GamePlay instance] Candies].count<=0 || [_gameOver IsGameOver]) {
        [_candies removeAllObjects];
        for(NSInteger i=0;i<rowNo;i++)
        {
            for(NSInteger j=0;j<colNo;j++)
            {
                Cell* _cell =[self getCellByAddress:i :j];
                if(_cell==nil||[_cell getIsEmpty])
                    continue;
                
                Candy*_candy= (Candy*)[Candy loadCandy:i :j];
                _candy.zOrder= _cell.zOrder+1;
                [_candies addObject:_candy];
            }
        }
    }
    
    for(Cell* _cell in _cells)
    {

        _cell.zOrder= _Grids.zOrder+1;
        [self addChild:_cell];
        
        CGPoint orgPosCell=ccp(_cell.position.x,_cell.position.y);
        
        _cell.position=ccp(_cell.position.x,s.height+ [Cell getCellWidht]);
        
        CGFloat random = ((double)arc4random() / ARC4RANDOM_MAX)*1.1f;// * (rowNo+i)*1.3f/rowNo;
        
        id actionCell0=[CCActionDelay actionWithDuration:random];
        
        id actionCell1=[CCActionMoveTo actionWithDuration:0.05f*(rowNo-[_cell RowNumber]) position:ccp(orgPosCell.x,orgPosCell.y-2)];
        id actionCell2=[CCActionFadeIn actionWithDuration:0.05f*(rowNo-[_cell RowNumber])];
        id actionCell3=[CCActionSpawn actions:actionCell1,actionCell2, nil];
        
        id actionCell11=[CCActionMoveTo actionWithDuration:0.15f position:ccp(orgPosCell.x,orgPosCell.y+2)];
        id actionCell12=[CCActionMoveTo actionWithDuration:0.15f position:orgPosCell];
        id actionCell4=[CCActionSequence actions:actionCell0,actionCell3,actionCell11,actionCell12, nil];
        
        [_cell runAction:actionCell4];
    }
    
    for(NSInteger i=0;i<rowNo;i++)
    {
        for(NSInteger j=0;j<colNo;j++)
        {
          
            Candy*_candy= (Candy*)[self getCandyByAddress:i :j ];
            if(_candy==nil)
                continue;
            
            [self addChild:_candy];
            
            CGPoint orgPos=ccp(_candy.position.x,_candy.position.y);
            
            _candy.position=ccp(_candy.position.x,-[Cell getCellWidht]);
            
            CGFloat random = ((double)arc4random() / ARC4RANDOM_MAX)*1.1f;// * (rowNo+i)*1.3f/rowNo;
            
            id action0=[CCActionDelay actionWithDuration:random];
            
            id action1=[CCActionMoveTo actionWithDuration:0.05f*(rowNo-i) position:ccp(orgPos.x,orgPos.y+2)];
            id action2=[CCActionFadeIn actionWithDuration:0.05f*(rowNo-i)];
            id action3=[CCActionSpawn actions:action1,action2, nil];
            
            id action11=[CCActionMoveTo actionWithDuration:0.15f position:ccp(orgPos.x,orgPos.y-2)];
            id action12=[CCActionMoveTo actionWithDuration:0.15f position:orgPos];
            id action4=[CCActionSequence actions:action0,action3,action11,action12, nil];
            
            [_candy runAction:action4];
            
        }
    }
    
    
    [self runAction: [CCActionSequence actions:[CCActionDelay actionWithDuration:3.f],[CCActionCallFunc actionWithTarget:self selector:@selector(startGame)],nil]];
    
    
    fallingCandies = [NSMutableArray array];
    genningCandies = [NSMutableArray array];
    swtchingCandies = [NSMutableArray array];
    
    
}
-(void) startGame
{
    [self doCheckExplore];
    
    [self schedule:@selector(updateGame) interval:0.1f ];
    // [self schedule:@selector(generateNewCandies) interval:0.35f ];
    
    [self schedule:@selector(DoExploreBigCandies) interval:2.5f ];
}

CCTime lastTimeCheckCount=0;
-(void) updateGame
{
    
    if([_candies count]< CellVisibleNo)
    {
        lastTimeCheckCount++;
        if(lastTimeCheckCount>20)
        {
            [self doCheckExplore];
            [self falldownAvaiableCandies];
            lastTimeCheckCount=0;
        }
    }
}


CGFloat lastUpdatedScore;
CGFloat lastUpdatedStar;
CCTime deltaTime=0;
- (void)update:(CCTime)delta {
    
      deltaTime+=delta;
    if([_progressTimer isTimeUp]==false)
    {
      
        if(deltaTime>2.f)
        {
            deltaTime=0;
            currenTime++;
           [_progressTimer updateProgressWithValue:currenTime];
            if([_gameOver IsGameOver])
                [_gameOver ShowGameOver];
         
        }
        
    }else
          [_gameOver ShowGameOver];
    
     if(deltaTime>1.5f)
     {
         if(lastUpdatedStar!=currentStar)
         {
             lastUpdatedStar=currentStar;
             [(CCLabelTTF*)_starLabel setString:[NSString stringWithFormat:@"%d/%d",currentStar,destStar]];
         }
         if(lastUpdatedScore!=currentScore)
         {
             lastUpdatedScore=currentScore;
             [(CCLabelTTF*)_scoreLabel setString:[NSString stringWithFormat:@"%d",currentScore]];
         }
     }
    
}

-(Cell*) getCellByAddress:(NSInteger) X:(NSInteger) Y
{
    Cell* result=nil;
    for (Cell* _cell in _cells) {
        if([_cell RowNumber]==X && [_cell ColumnNumber]==Y)
        {
            result=_cell;
            return result;
        }
    }
    
    return  result;
}
-(Candy*) getCandyByAddress:(NSInteger) row:(NSInteger) col
{
    Candy* result=nil;
    for (Candy* _candy in _candies) {
        if([_candy rowNumber]==row && [_candy colNumber]==col)
        {
            result=_candy;
            return result;
        }
    }
    
    return  result;
}
- (BOOL)hitTestWithWorldPos:(CGPoint)pos
{
    
    
    return(YES);
}

Candy* selectedCandy1=nil;
Candy* selectedCandy2=nil;

Candy* lastMovedCandy1=nil;
Candy* lastMovedCandy2=nil;
bool isLockTouch=false;
-(BOOL) getIsLockTouch
{
    return isLockTouch;
}
-(void) setIsLockTouch: (BOOL) lock
{
    isLockTouch =lock;
}
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    /*
     CGPoint touchLocation = [touch locationInWorld];
     touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
     touchLocation = [self convertToNodeSpace:touchLocation];
     beginPoint=touchLocation;
     */
    if (isLockTouch || [_gameOver IsGameOver] || swtchingCandies.count>0 ||fallingCandies.count>0||genningCandies.count>0||combineCandies.count>0)
        return;
    isLockTouch=TRUE;
    
    selectedCandy1=nil;
    for (Candy* _candy in _candies)
    {
        
        if([_candy getIsSelectedCandy])
        {
            if(selectedCandy1==nil)
                selectedCandy1=_candy;
        }
    }
    isLockTouch=false;
    
}


- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (isLockTouch || [_gameOver IsGameOver] || swtchingCandies.count>0 ||fallingCandies.count>0||genningCandies.count>0||combineCandies.count>0)
        return;
    
    if(selectedCandy1!=nil)
    {
        
        CGPoint touchLocation = [touch locationInWorld];
        touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
        touchLocation = [self convertToNodeSpace:touchLocation];
        
        CGFloat diffX =fabs(selectedCandy1.position.x - touchLocation.x);
        CGFloat diffY =fabs(selectedCandy1.position.y - touchLocation.y);
        if(diffX > 0.5f *[Cell getCellWidht] && diffX < 1.5f * [Cell getCellWidht] && diffY < [Cell getCellWidht])
        {
            if(selectedCandy1.position.x <touchLocation.x)//right
            {
                selectedCandy2 =[self getCandyByAddress:selectedCandy1.rowNumber :selectedCandy1.colNumber+1];
                
            }else //left
            {
                selectedCandy2 =[self getCandyByAddress:selectedCandy1.rowNumber :selectedCandy1.colNumber-1];
            }
        }else if(diffY > 0.5f *[Cell getCellWidht] && diffY < 1.5f * [Cell getCellWidht] && diffX < [Cell getCellWidht])
        {
            if(selectedCandy1.position.y <touchLocation.y)//down
            {
                selectedCandy2 =[self getCandyByAddress:selectedCandy1.rowNumber+1 :selectedCandy1.colNumber];
                
            }else //up
            {
                selectedCandy2 =[self getCandyByAddress:selectedCandy1.rowNumber-1 :selectedCandy1.colNumber];
            }
        }
        
        if([selectedCandy2 getIsSelectedCandy]==false)
        {
            [selectedCandy2 setSelectedCandy:true];
        }
    }
    isLockTouch=false;
}

-(BOOL) enableSwitchCandies :(Candy*) _source : (Candy*) _destiny
{
    if([[_source getType] isEqualToString:[_destiny getType]])
        return false;
    
    if(_destiny ==[self getCandyByAddress:_source.rowNumber:_source.colNumber +1])
    {
        
        Candy* _source1=[self getCandyByAddress:_destiny.rowNumber:_destiny.colNumber +1];
        Candy* _source2=[self getCandyByAddress:_destiny.rowNumber:_destiny.colNumber +2];
        Candy* _source3=[self getCandyByAddress:_destiny.rowNumber+1:_destiny.colNumber];
        Candy* _source4=[self getCandyByAddress:_destiny.rowNumber+2:_destiny.colNumber];
        Candy* _source5=[self getCandyByAddress:_destiny.rowNumber-1:_destiny.colNumber];
        Candy* _source6=[self getCandyByAddress:_destiny.rowNumber-2:_destiny.colNumber];
        
        if(_source1!=nil && [[_source1 getType] isEqualToString:[_source getType]])
        {
            if(_source2!=nil && [[_source2 getType] isEqualToString:[_source getType]])
                return true;
        }
        
        if(_source3!=nil && [[_source3 getType] isEqualToString:[_source getType]])
        {
            if(_source4!=nil && [[_source4 getType] isEqualToString:[_source getType]])
                return true;
            
            if(_source5!=nil && [[_source5 getType] isEqualToString:[_source getType]])
                return true;
        }
        
        if(_source5!=nil && [[_source5 getType] isEqualToString:[_source getType]])
        {
            if(_source6!=nil && [[_source6 getType] isEqualToString:[_source getType]])
                return true;
        }
    }
    if(_destiny ==[self getCandyByAddress:_source.rowNumber:_source.colNumber -1])
    {
        
        Candy* _source1=[self getCandyByAddress:_destiny.rowNumber:_destiny.colNumber -1];
        Candy* _source2=[self getCandyByAddress:_destiny.rowNumber:_destiny.colNumber -2];
        Candy* _source3=[self getCandyByAddress:_destiny.rowNumber+1:_destiny.colNumber];
        Candy* _source4=[self getCandyByAddress:_destiny.rowNumber+2:_destiny.colNumber];
        Candy* _source5=[self getCandyByAddress:_destiny.rowNumber-1:_destiny.colNumber];
        Candy* _source6=[self getCandyByAddress:_destiny.rowNumber-2:_destiny.colNumber];
        
        if(_source1!=nil && [[_source1 getType] isEqualToString:[_source getType]])
        {
            if(_source2!=nil && [[_source2 getType] isEqualToString:[_source getType]])
                return true;
        }
        
        if(_source3!=nil && [[_source3 getType] isEqualToString:[_source getType]])
        {
            if(_source4!=nil && [[_source4 getType] isEqualToString:[_source getType]])
                return true;
            
            if(_source5!=nil && [[_source5 getType] isEqualToString:[_source getType]])
                return true;
        }
        
        if(_source5!=nil && [[_source5 getType] isEqualToString:[_source getType]])
        {
            if(_source6!=nil && [[_source6 getType] isEqualToString:[_source getType]])
                return true;
        }
    }

    if(_destiny ==[self getCandyByAddress:_source.rowNumber+1:_source.colNumber])
    {
        
        Candy* _source1=[self getCandyByAddress:_destiny.rowNumber+1:_destiny.colNumber];
        Candy* _source2=[self getCandyByAddress:_destiny.rowNumber+2:_destiny.colNumber];
        Candy* _source3=[self getCandyByAddress:_destiny.rowNumber:_destiny.colNumber+1];
        Candy* _source4=[self getCandyByAddress:_destiny.rowNumber:_destiny.colNumber+2];
        Candy* _source5=[self getCandyByAddress:_destiny.rowNumber:_destiny.colNumber-1];
        Candy* _source6=[self getCandyByAddress:_destiny.rowNumber:_destiny.colNumber-2];
        
        if(_source1!=nil && [[_source1 getType] isEqualToString:[_source getType]])
        {
            if(_source2!=nil && [[_source2 getType] isEqualToString:[_source getType]])
                return true;
        }
        
        if(_source3!=nil && [[_source3 getType] isEqualToString:[_source getType]])
        {
            if(_source4!=nil && [[_source4 getType] isEqualToString:[_source getType]])
                return true;
            
            if(_source5!=nil && [[_source5 getType] isEqualToString:[_source getType]])
                return true;
        }
        
        if(_source5!=nil && [[_source5 getType] isEqualToString:[_source getType]])
        {
            if(_source6!=nil && [[_source6 getType] isEqualToString:[_source getType]])
                return true;
        }
    }
    
    if(_destiny ==[self getCandyByAddress:_source.rowNumber-1:_source.colNumber])
    {
        
        Candy* _source1=[self getCandyByAddress:_destiny.rowNumber-1:_destiny.colNumber];
        Candy* _source2=[self getCandyByAddress:_destiny.rowNumber-2:_destiny.colNumber];
        Candy* _source3=[self getCandyByAddress:_destiny.rowNumber:_destiny.colNumber+1];
        Candy* _source4=[self getCandyByAddress:_destiny.rowNumber:_destiny.colNumber+2];
        Candy* _source5=[self getCandyByAddress:_destiny.rowNumber:_destiny.colNumber-1];
        Candy* _source6=[self getCandyByAddress:_destiny.rowNumber:_destiny.colNumber-2];
        
        if(_source1!=nil && [[_source1 getType] isEqualToString:[_source getType]])
        {
            if(_source2!=nil && [[_source2 getType] isEqualToString:[_source getType]])
                return true;
        }
        
        if(_source3!=nil && [[_source3 getType] isEqualToString:[_source getType]])
        {
            if(_source4!=nil && [[_source4 getType] isEqualToString:[_source getType]])
                return true;
            
            if(_source5!=nil && [[_source5 getType] isEqualToString:[_source getType]])
                return true;
        }
        
        if(_source5!=nil && [[_source5 getType] isEqualToString:[_source getType]])
        {
            if(_source6!=nil && [[_source6 getType] isEqualToString:[_source getType]])
                return true;
        }
    }

    return  false;
}

NSMutableArray* swtchingCandies;
- (void)SwitchCandies :(Candy*) source : (Candy*) destiny : (BOOL) isRevert{
    
    if(abs(source.rowNumber-destiny.rowNumber)>1 || abs(source.colNumber-destiny.colNumber)>1 )
        return;
    
    if(abs(source.rowNumber-destiny.rowNumber)==1 && abs(source.colNumber-destiny.colNumber)==1 )
        return;
    
    isLockTouch=true;
    if(isRevert==false)
    {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        CGFloat random = ((double)arc4random() / ARC4RANDOM_MAX)*2;
        if(random<=1)
            [audio playEffect:@"Sounds/Combine1.mp3" volume:0.5f pitch:1.f pan:0 loop:false];
        else
            [audio playEffect:@"Sounds/Combine2.mp3" volume:0.5f pitch:1.f pan:0 loop:false];
    }
  
    
     NSMutableArray* removeCandies = [NSMutableArray array];
    for (Candy* candy1 in swtchingCandies) {
        if([_candies containsObject:candy1]==FALSE)
            [removeCandies addObject:candy1];
    }
    if([removeCandies count] >0)
    {
        for (Candy* candy12 in removeCandies)
            [swtchingCandies removeObject:candy12];
    }
    
    if([swtchingCandies containsObject:source]==false)
        [swtchingCandies addObject:source];
    
    if([swtchingCandies containsObject:destiny]==false)
        [swtchingCandies addObject:destiny];
    
    
    // isLockFallDown=true;
    
    CGSize s = [CCDirector sharedDirector].viewSize;
    
    CGFloat indentX= (s.width - [[GamePlay instance] getColNo] *[Cell getCellWidht])/2  + [Cell getCellWidht]/2 +2;
    CGPoint newPosCandy1=ccp(destiny.colNumber*[Cell getCellWidht]+ indentX,destiny.rowNumber*[Cell getCellWidht] + [[GamePlay instance] getNodeIndent]);
    
    id action1=[CCActionMoveTo actionWithDuration:0.3f position:newPosCandy1];
    id action12=[CCActionScaleTo actionWithDuration:0.2f scaleX:source.scaleX*1.5f scaleY:source.scaleY*1.5f];
    id action13=[CCActionScaleTo actionWithDuration:0.2f scaleX:source.scaleX scaleY:source.scaleY];
    id action10=[CCActionSequence actions:action12,action13, nil];
    
    CGPoint newPosCandy2=ccp(source.colNumber*[Cell getCellWidht]+ indentX,source.rowNumber*[Cell getCellWidht] + [[GamePlay instance] getNodeIndent]);
    
    id action2=[CCActionMoveTo actionWithDuration:0.3f position:newPosCandy2];
    id action22=[CCActionScaleTo actionWithDuration:0.2f scaleX:destiny.scaleX*1.5f scaleY:destiny.scaleY*1.5f];
    id action23=[CCActionScaleTo actionWithDuration:0.2f scaleX:destiny.scaleX scaleY:destiny.scaleY];
    id action20=[CCActionSequence actions:action22,action23, nil];
    
   
    
    
    __block Candy* blockSourceC=source;
    __block Candy* blockDestC=destiny;
    __block NSInteger blockcandy1Row=[blockSourceC rowNumber];
    __block NSInteger blockcandy2Row=[blockDestC rowNumber];
    __block NSInteger blockcandy1Col=[blockSourceC colNumber];
    __block NSInteger blockcandy2Col=[blockDestC colNumber];
    
    id action14a = [CCActionCallBlock actionWithBlock:^{
        
        if(isRevert==false)
        {
            [blockSourceC updateNewAddress:blockcandy2Row :blockcandy2Col];
            [blockDestC updateNewAddress:blockcandy1Row :blockcandy1Col];
            
            lastMovedCandy1 =blockSourceC;
            lastMovedCandy2 =blockDestC;
            
        }
        
        blockSourceC.position=ccp(blockSourceC.colNumber*[Cell getCellWidht]+ indentX,blockSourceC.rowNumber*[Cell getCellWidht] + [[GamePlay instance] getNodeIndent]);
        blockDestC.position=ccp(blockDestC.colNumber*[Cell getCellWidht]+ indentX,blockDestC.rowNumber*[Cell getCellWidht] + [[GamePlay instance] getNodeIndent]);
        
        if ([fallingCandies count]<=0 && isLockFallDown) {
            isLockFallDown=false;
        }
        if([swtchingCandies containsObject:blockSourceC])
            [swtchingCandies removeObject:blockSourceC];
        if([swtchingCandies containsObject:blockDestC])
            [swtchingCandies removeObject:blockDestC];
        
        isLockTouch=false;
        
         if(isRevert==false && swtchingCandies.count<=0)
         {
             [self runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.2f],[CCActionCallFunc actionWithTarget:self selector:@selector(doCheckExplore)], nil]];
         }
    }];
    
    id actionSource;
    if(isRevert==false)
        actionSource=[CCActionSpawn actions:action1,action10,nil];
    else
        actionSource = [CCActionSequence actions:[CCActionSpawn actions:action1,action10,nil],[CCActionDelay actionWithDuration:0.1f],[CCActionSpawn actions:action2,action10,nil],nil];
    
    id actionDestiny;
    if(isRevert==false)
        actionDestiny=[CCActionSpawn actions:action2,action20,nil];
    else
        actionDestiny = [CCActionSequence actions:[CCActionSpawn actions:action2,action20,nil],[CCActionDelay actionWithDuration:0.1f],[CCActionSpawn actions:action1,action20,nil],nil];
    
    [source runAction:[CCActionSequence actions:actionSource,[CCActionDelay actionWithDuration:0.1f],nil]];
    [destiny runAction:[CCActionSequence actions:actionDestiny,[CCActionDelay actionWithDuration:0.2f],action14a,nil]];
    
    
    
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    /*
     CGPoint touchLocation = [touch locationInView: [touch view]];
     touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
     touchLocation = [self convertToNodeSpace:touchLocation];
     */
    if (isLockTouch || [_gameOver IsGameOver] || swtchingCandies.count>0 ||fallingCandies.count>0||genningCandies.count>0||combineCandies.count>0)
        return;
    for (Candy* _candy in _candies)
    {
        
        if([_candy getIsSelectedCandy])
        {
            if(selectedCandy1==nil ||selectedCandy1==_candy)
            {
                selectedCandy1=_candy;
                
            }
            else if(selectedCandy2==nil ||selectedCandy2==_candy )
            {
                selectedCandy2=_candy;
            }
        }
    }
    
    BOOL isSwitched=false;
    
    if(selectedCandy1!=nil && selectedCandy2!=nil  && [swtchingCandies count]<=0 && [fallingCandies count]<=0 && [genningCandies count]<=0 && [combineCandies count]<=0)
    {
        if(([selectedCandy1 rowNumber]==[selectedCandy2 rowNumber] && abs([selectedCandy1 colNumber]-[selectedCandy2 colNumber])==1)
           || ([selectedCandy1 colNumber]==[selectedCandy2 colNumber] && abs([selectedCandy1 rowNumber]-[selectedCandy2 rowNumber])==1))
        {
            
            
            
            if(    ![fallingCandies containsObject:selectedCandy1] && ![fallingCandies containsObject:selectedCandy1]
               &&  ![genningCandies containsObject:selectedCandy1] && ![genningCandies containsObject:selectedCandy1]
               &&  ![combineCandies containsObject:selectedCandy1] && ![combineCandies containsObject:selectedCandy1]
               &&  ![swtchingCandies containsObject:selectedCandy1] && ![swtchingCandies containsObject:selectedCandy1]
               &&  ![fallingCandies containsObject:selectedCandy2] && ![fallingCandies containsObject:selectedCandy2]
               &&  ![genningCandies containsObject:selectedCandy2] && ![genningCandies containsObject:selectedCandy2]
               &&  ![combineCandies containsObject:selectedCandy2] && ![combineCandies containsObject:selectedCandy2]
               &&  ![swtchingCandies containsObject:selectedCandy2] && ![swtchingCandies containsObject:selectedCandy2]
               )
                
            {
                
                isSwitched=[self enableSwitchCandies:selectedCandy1 :selectedCandy2]||[self enableSwitchCandies:selectedCandy2 :selectedCandy1];
                [self SwitchCandies:selectedCandy1 :selectedCandy2 :!isSwitched];

            }
            
        }else
        {
        }
        
        
        
        
    }
    
    if(isSwitched)
    {
        selectedCandy1=nil;
        selectedCandy2=nil;
        for (Candy* _candy in _candies)
        {
            [_candy setSelectedCandy:false];
        }
    }else
    {
        if( selectedCandy2!=nil)
        {
            selectedCandy1=nil;
            selectedCandy2=nil;
            for (Candy* _candy in _candies)
            {
                [_candy setSelectedCandy:false];
            }
            
        }else{
            
            OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
            [audio playEffect:@"Sounds/Click.mp3" volume:0.7f pitch:1.f pan:0 loop:false];
        }
    }
    
    isLockTouch=false;
}

-(void) removeParticle
{
    
}

-(void) doCheckExplore
{
    
    //  [self unschedule:@selector(doCheckExplore) ];
    
    [self checkExplore:false];
}


- (void)ExploreBigCandy: (Candy*) BigCandy noCondition: (BOOL) _exploreImediately
{
    if((_exploreImediately==false && [BigCandy IsBomCandy]==false &&[BigCandy getWeight] < [[GamePlay instance] getExploreWeight]) || [_gameOver IsGameOver])
        return;
    
    // isLockFallDown=true;
    
    CGSize s = [CCDirector sharedDirector].viewSize;
    
    if([_candies containsObject:BigCandy]==false)
        return;
    
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    if( [BigCandy IsBomCandy])
        [audio playEffect:@"Sounds/BomExplore.mp3" volume:1.f pitch:1.f pan:0 loop:false];
    else
    {
        CGFloat randSong=((double)arc4random() / ARC4RANDOM_MAX)*3;
        if( randSong <=1)
            [audio playEffect:@"Sounds/Explore1.mp3" volume:1.f pitch:1.f pan:0 loop:false];
        else  if( randSong <=2)
            [audio playEffect:@"Sounds/Explore2.mp3" volume:1.f pitch:1.f pan:0 loop:false];
        else  if( randSong <=3)
            [audio playEffect:@"Sounds/Explore3.mp3" volume:1.f pitch:1.f pan:0 loop:false];
    }
    [_candies removeObject:BigCandy];
    
    if([BigCandy IsBomCandy]==false)
    {
        CCSprite *starNode = [CCSprite spriteWithImageNamed:@"Resources/Banner/star.png"];
        starNode.position = ccp(BigCandy.position.x,s.height-BigCandy.position.y);
        starNode.anchorPoint=ccp(0.5,0.5);
        starNode.scaleX=0.6;
        starNode.scaleY=0.6;
        starNode.zOrder=BigCandy.zOrder+1;
        
        [self addChild:starNode];
        
        //id actionDelayStar = [CCActionInterval actionWithDuration:0.1f];
        id actionRotate= [CCActionRepeatForever actionWithAction:[CCActionRotateBy actionWithDuration:0.2f angle:360]];
        [starNode runAction:actionRotate];
        
        CGPoint point1= [_starLabel convertToWorldSpace:_starLabel.position];
        id actionMove=[CCActionMoveTo actionWithDuration:0.8f position:ccp(point1.x-7.f,point1.y-20.f)];
        id actionStar= [CCActionSequence actions:actionMove
                        ,[CCActionCallFunc actionWithTarget:self selector:@selector(HightStar)]
                        ,[CCActionRemove action],nil];
        [starNode runAction:actionStar];
    }
    
    
    [BigCandy runAction:[CCActionRemove action]];
    
    CGFloat indentX= (s.width - [[GamePlay instance] getColNo] *[Cell getCellWidht])/2  + [Cell getCellWidht]/2 +2;
    CGPoint BigCandyPosition=BigCandy.position;// ccp(BigCandy.colNumber*[Cell getCellWidht]+ indentX,BigCandy.rowNumber*[Cell getCellWidht] + [[GamePlay instance] getNodeIndent]);
    
    
    CCParticleExplosion* particle;
    particle = [[CCParticleExplosion alloc] initWithTotalParticles:100];
    particle.texture = [[CCTextureCache sharedTextureCache] addImage:@"explore2.png"];
    particle.emissionRate=500.00;
    particle.angle=90.0;
    particle.angleVar=42.0;
    ccBlendFunc blendFunc={GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA};
    particle.blendFunc=blendFunc;
    particle.duration=0.08;
    // particle.emitterMode=kCCParticleModeGravity;
    
    ccColor4F startColor={1.00,1.00,0.99,1.00};
    particle.startColor=[CCColor colorWithCcColor4f:startColor];
    ccColor4F startColorVar={0.00,0.00,0.00,0.00};
    particle.startColorVar=[CCColor colorWithCcColor4f:startColorVar];
    ccColor4F endColor;
    if([[BigCandy getType] rangeOfString:@"Purple"].length!=0)
    {
        ccColor4F endColor={0.73,0.08,0.64,0.75};
        particle.endColor=[CCColor colorWithCcColor4f:endColor];
    }else if([[BigCandy getType] rangeOfString:@"Blue"].length!=0)
    {
        ccColor4F endColor={0.04,0.25,0.91,0.75};
        particle.endColor=[CCColor colorWithCcColor4f:endColor];
    }else if([[BigCandy getType] rangeOfString:@"Red"].length!=0)
    {
        ccColor4F endColor={0.97,0.02,0.02,0.75};
        particle.endColor=[CCColor colorWithCcColor4f:endColor];
    }else if([[BigCandy getType] rangeOfString:@"Yellow"].length!=0)
    {
        ccColor4F endColor={0.99,0.59,0.01,0.75};
        particle.endColor=[CCColor colorWithCcColor4f:endColor];
    }else if([[BigCandy getType] rangeOfString:@"Green"].length!=0)
    {
        ccColor4F endColor={0.11,0.51,0.09,0.75};
        particle.endColor=[CCColor colorWithCcColor4f:endColor];
    }else if([[BigCandy getType] rangeOfString:@"Dark"].length!=0)
    {
        ccColor4F endColor={0.07,0.09,0.03,0.75};
        particle.endColor=[CCColor colorWithCcColor4f:endColor];
    }
    
    
    ccColor4F endColorVar={0.00,0.00,0.00,0.00};
    particle.endColorVar=[CCColor colorWithCcColor4f:endColorVar];
    particle.startSize=40.00;
    particle.startSizeVar=30.00;
    particle.endSize=2.00;
    particle.endSizeVar=0.00;
    particle.gravity=ccp(0.00,-2900.00);
    particle.radialAccel=0.00;
    particle.radialAccelVar=0.00;
    particle.speed=600;
    particle.speedVar=300;
    particle.tangentialAccel= 0;
    particle.tangentialAccelVar= 0;
    particle.totalParticles=100;
    particle.life=0.23;
    particle.lifeVar=0.20;
    particle.startSpin=0.00;
    particle.startSpinVar=0.00;
    particle.endSpin=0.00;
    particle.endSpinVar=0.00;
    // particle.position=ccp(200.11,168.90);
    particle.posVar=ccp(0.00,0.00);
    particle.scaleX=2.f * BigCandy.scaleX;
    particle.scaleY=2.f * BigCandy.scaleY;
    if([BigCandy IsBomCandy])
    {
        particle.scaleX=8.f * BigCandy.scaleX;
        particle.scaleY=8.f * BigCandy.scaleY;
    }
    [self addChild:particle];
    BigCandyPosition=BigCandy.position;
    particle.position = ccp(BigCandyPosition.x,s.height-BigCandyPosition.y-22);
    particle.zOrder=BigCandy.zOrder+1;
    [particle resetSystem];
    
    CCParticleExplosion* particleExplosion;
    particleExplosion = [[CCParticleExplosion alloc] initWithTotalParticles:500];
    particleExplosion.texture = [[CCTextureCache sharedTextureCache] addImage:@"focus2.png"];
    particleExplosion.angle=90.0;
    particleExplosion.angleVar=360.0;
    ccBlendFunc blendFunc1={GL_SRC_ALPHA,GL_ONE};
    particleExplosion.blendFunc=blendFunc1;
    particleExplosion.duration=0.05;
     if([BigCandy IsBomCandy])
          particleExplosion.duration=0.1;
    //  particle.emitterMode=kCCParticleModeGravity;
    ccColor4F startColor1={0.86,0.57,0.42,1.00};
    particleExplosion.startColor=[CCColor colorWithCcColor4f:startColor1];
    ccColor4F startColorVar1={0.00,0.00,0.00,0.00};
    particleExplosion.startColorVar=[CCColor colorWithCcColor4f:startColorVar1];
    ccColor4F endColor1={0.00,0.00,0.00,1.00};
    particleExplosion.endColor=[CCColor colorWithCcColor4f:endColor1];
    ccColor4F endColorVar1={0.00,0.00,0.00,0.00};
    particleExplosion.endColorVar=[CCColor colorWithCcColor4f:endColorVar1];
    particleExplosion.startSize=0.00;
    particleExplosion.startSizeVar=0.00;
    particleExplosion.endSize=30.00;
    if([BigCandy IsBomCandy])
          particleExplosion.endSize=40.00;
    particleExplosion.endSizeVar=5.00;
    
    if([BigCandy IsBomCandy])
        particleExplosion.endSizeVar=15.00;
    
    particleExplosion.gravity=ccp(2.00,10.00);
    particleExplosion.radialAccel=5.00;
    particleExplosion.radialAccelVar=10.00;
    particleExplosion.speed=100;
    particleExplosion.speedVar= 2;
    particleExplosion.tangentialAccel= 1000;
    particleExplosion.tangentialAccelVar=30;
    particleExplosion.totalParticles=1500;
    particleExplosion.life=0.00;
    particleExplosion.lifeVar=0.45;
    
    if([BigCandy IsBomCandy])
        particleExplosion.lifeVar=0.9;
    
    particleExplosion.startSpin=0.00;
    particleExplosion.startSpinVar=0.00;
    particleExplosion.endSpin=0.00;
    particleExplosion.endSpinVar=0.00;
    particleExplosion.opacity=0.6f;
    particleExplosion.posVar=ccp(0.00,0.00);
    
    particleExplosion.scaleX=2.f * BigCandy.scaleX;
    particleExplosion.scaleY=2.f * BigCandy.scaleY;
    if([BigCandy IsBomCandy])
    {
        particleExplosion.scaleX=8.f * BigCandy.scaleX;
        particleExplosion.scaleY=8.f * BigCandy.scaleY;
    }

    [self addChild:particleExplosion];
    
    BigCandyPosition=BigCandy.position;
    particleExplosion.position = ccp(BigCandyPosition.x,s.height-BigCandyPosition.y);
    particleExplosion.zOrder=BigCandy.zOrder;
    [particleExplosion resetSystem];
    
    if(_exploreImediately || [BigCandy IsBomCandy]|| [BigCandy getWeight] >= [[GamePlay instance] getExploreWeight])
    {
        int iCount=0;
        for(NSInteger i=0;i<rowNo;i++)
        {
            
            for(NSInteger j=0;j<colNo;j++)
            {
                if((abs(BigCandy.rowNumber-i)==1 || abs(BigCandy.rowNumber-i)==0)
                   && (abs(BigCandy.colNumber-j)==1 || abs(BigCandy.colNumber-j)==0))
                {
                    Candy* _candy=  [self getCandyByAddress:i :j];
                    
                
                        CGFloat newScale=0;
                         if([BigCandy IsBomCandy])
                            newScale= [[GamePlay instance] getExploreWeight]*[[GamePlay instance] getCandyScale]/[_candy getBeginWeight];
                        else
                             newScale= ([_candy getWeight]+0.045f*[BigCandy getWeight])*[[GamePlay instance] getCandyScale]/[_candy getBeginWeight];
                        
                        id actionBig =[CCActionScaleTo actionWithDuration:0.45f scaleX:newScale scaleY:newScale];
                        // [_candy runAction:actionBig];
                        
                        CCParticleSystem* emitter = [CCParticleSystem particleWithFile:@"CandyStars.plist"];
                        emitter.position=ccp(10,-50);
                        emitter.scaleX=1.3f*_candy.scaleX;
                        emitter.scaleY=1.3f*_candy.scaleX;
                        // emitter.opacity=0.6f;
                        [_candy addChild:emitter z:5];
                        
                        
                        __block Candy* blockCandy1=_candy;
                        __block CGFloat newWeight=0;
                        if([BigCandy IsBomCandy])
                            newWeight=[[GamePlay instance] getExploreWeight] +0.1;
                        else
                            newWeight=[_candy getWeight]+0.045f*[BigCandy getWeight];
                        
                        id action4 = [CCActionCallBlock actionWithBlock:^{
                            if ([fallingCandies count]<=0 && isLockFallDown) {
                                isLockFallDown=false;
                            }
                            
                            [blockCandy1 setWeight:newWeight];
                            if( [blockCandy1 getWeight] >= [[GamePlay instance] getExploreWeight])
                                [self ExploreBigCandy:blockCandy1 noCondition:false];
                        }];
                    iCount++;
                    
                        id action6=[CCActionSequence actions:[CCActionDelay actionWithDuration: 0.2f],actionBig,[CCActionDelay actionWithDuration: 0.2f*(iCount-1)],action4,nil ];
                        [_candy runAction:action6];
                    
                    
                }
            }
        }
    }
    
    if([BigCandy getIsFalling])
    {
        if([fallingCandies containsObject:BigCandy])
            [fallingCandies removeObject:BigCandy];
        
        if ([fallingCandies count]<=0 && isLockFallDown) {
            isLockFallDown=false;
        }
    }
    
    id delayAction0 = [CCActionInterval actionWithDuration:0.05f];
    id action14 = [CCActionCallBlock actionWithBlock:^{
        if ([fallingCandies count]<=0 && isLockFallDown) {
            isLockFallDown=false;
        }
        [self falldownAvaiableCandies];
    }];
    //  CCAction * exAcc = [CCActionCallFunc actionWithTarget:self selector:@selector(DoExploreBigCandies)];
    [self runAction:[CCActionSequence actions:delayAction0,action14,nil]];
    
    
}

-(void) HightStar
{
    CGSize s = [CCDirector sharedDirector].viewSize;
    
    CCParticleExplosion* particleExplosion;
    particleExplosion = [[CCParticleExplosion alloc] initWithTotalParticles:50];
    particleExplosion.texture = [[CCTextureCache sharedTextureCache] addImage:@"focus2.png"];
    particleExplosion.angle=90.0;
    particleExplosion.angleVar=360.0;
    ccBlendFunc blendFunc1={GL_SRC_ALPHA,GL_ONE};
    particleExplosion.blendFunc=blendFunc1;
    particleExplosion.duration=0.05;
    //  particle.emitterMode=kCCParticleModeGravity;
    ccColor4F startColor1={0.86,0.57,0.42,1.00};
    particleExplosion.startColor=[CCColor colorWithCcColor4f:startColor1];
    ccColor4F startColorVar1={0.00,0.00,0.00,0.00};
    particleExplosion.startColorVar=[CCColor colorWithCcColor4f:startColorVar1];
    ccColor4F endColor1={0.00,0.00,0.00,1.00};
    particleExplosion.endColor=[CCColor colorWithCcColor4f:endColor1];
    ccColor4F endColorVar1={0.00,0.00,0.00,0.00};
    particleExplosion.endColorVar=[CCColor colorWithCcColor4f:endColorVar1];
    particleExplosion.startSize=0.00;
    particleExplosion.startSizeVar=0.00;
    particleExplosion.endSize=30.00;
    particleExplosion.endSizeVar=5.00;
    particleExplosion.gravity=ccp(2.00,10.00);
    particleExplosion.radialAccel=5.00;
    particleExplosion.radialAccelVar=10.00;
    particleExplosion.speed=100;
    particleExplosion.speedVar= 2;
    particleExplosion.tangentialAccel= 1000;
    particleExplosion.tangentialAccelVar=30;
    particleExplosion.totalParticles=1500;
    particleExplosion.life=0.00;
    particleExplosion.lifeVar=0.45;
    particleExplosion.startSpin=0.00;
    particleExplosion.startSpinVar=0.00;
    particleExplosion.endSpin=0.00;
    particleExplosion.endSpinVar=0.00;
    particleExplosion.opacity=0.6f;
    particleExplosion.posVar=ccp(0.00,0.00);
    
    particleExplosion.scaleX=2.f;
    particleExplosion.scaleY=2.f;
    [self addChild:particleExplosion];
    
    CGPoint point2= [_starLabel convertToWorldSpace:_starLabel.position];
    particleExplosion.position = ccp(point2.x-5.f,point2.y-10.f);
    particleExplosion.zOrder=1000;
    [particleExplosion resetSystem];
    
    currentStar++;
    if(currentStar>destStar)
        currentStar=destStar;
     currentScore++;
    
    [self runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.2f], [CCActionCallFunc actionWithTarget:self selector:@selector(UpdateStarNos)],nil]];
    
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"Sounds/StarEnd.mp3" volume:1.f pitch:1.f pan:0 loop:false];

}
-(void)UpdateStarNos
{
    if([_gameOver IsGameOver])
        [_gameOver ShowGameOver];
}


NSMutableArray* combineCandies;

- (BOOL)CombineCandy:(Candy *)_candySource toRow:(NSInteger) _row toCol: (NSInteger)_col atGroup:(CGFloat)_group atIndex:(CGFloat) _index
{
    if(combineCandies==nil)
        combineCandies =[NSMutableArray array];
    
    NSMutableArray* removeCandies =[NSMutableArray array];
    for (Candy* candy1 in combineCandies) {
        if([_candies containsObject:candy1]==FALSE)
            [removeCandies addObject:candy1];
    }
    if([removeCandies count] >0)
    {
        for (Candy* candy12 in removeCandies)
            [combineCandies removeObject:candy12];
        
    }
    
    if([fallingCandies containsObject:_candySource] || [genningCandies containsObject:_candySource] )
        return false;
    
    if([_candies containsObject:_candySource]==false)
        return  false;
    
    
    if(![combineCandies containsObject:_candySource] )
        [combineCandies addObject:_candySource];
    
    
    
    
    // isLockFallDown=true;
    isLockCheckExplore=true;
    
    CGSize s = [CCDirector sharedDirector].viewSize;
    
    CGFloat indentX= (s.width - [[GamePlay instance] getColNo] *[Cell getCellWidht])/2  + [Cell getCellWidht]/2 +2;
    CGPoint newPosCandy=ccp(_col*[Cell getCellWidht]+ indentX,_row*[Cell getCellWidht] + [[GamePlay instance] getNodeIndent]);

    currentScore++;
    [(CCLabelTTF*)_scoreLabel setString:[NSString stringWithFormat:@"%d",currentScore]];
    
    
    //remove _candySource
    
      __block Candy* blocksource1=_candySource;
    id actionBG=[CCActionCallBlock actionWithBlock:^{
    
        
        CCParticleSystem* emitter = [CCParticleSystem particleWithFile:@"CandyStars.plist"];
        emitter.position=ccp(10,-50);
        emitter.scaleX=2.f*blocksource1.scaleX;
        emitter.scaleY=2.f*blocksource1.scaleX;
        [blocksource1 addChild:emitter z:5];
        
    }];
    id action0 =[CCActionMoveTo actionWithDuration:0.35f position:newPosCandy];
    id action1 = [CCActionEaseOut actionWithAction:[CCActionScaleTo actionWithDuration:0.35f scaleX:0.f scaleY:0.f] rate:1];
    
    __block Candy* blocksource=_candySource;
    
    id action14 = [CCActionCallBlock actionWithBlock:^{
        
        [_candies removeObject:blocksource];
        [blocksource removeFromParent];
        
        /*
         if([fallingCandies containsObject:blocksource])
         {
             [fallingCandies removeObject:blocksource];
             [blocksource setIsFalling:FALSE];
         }
         */
        if ([fallingCandies count]<=0 && isLockFallDown) {
            isLockFallDown=false;
        }
        
        if([combineCandies containsObject:blocksource] )
            [combineCandies removeObject:blocksource];
        
        if(combineCandies.count<=0)
            [self falldownAvaiableCandies];

        
    }];
    
    
    id action2=[CCActionSequence actions:[CCActionDelay actionWithDuration:_index * 0.04f + (_group-1)*0.3f],actionBG,action0,[CCActionRemove action],action14,[CCActionRemove action], nil ];
    [_candySource runAction:action2];
  
   // [self falldownAvaiableCandies];
    return true;// ((_candyDestiny.scaleX) > [[GamePlay instance] getExploreScale]);
    
}


bool isLookExploreBigCandies=false;

- (void)DoExploreBigCandies
{
    if(isLookExploreBigCandies|| [_gameOver IsGameOver])
        return;
    
    isLookExploreBigCandies=true;
    for(NSInteger i=0;i<rowNo;i++)
    {
        
        for(NSInteger j=0;j<colNo;j++)
        {
            Candy* _candy=  [self getCandyByAddress:i :j];
            
            if([_candy IsBomCandy] || [_candy getWeight] < [[GamePlay instance] getExploreWeight])
                continue;
            
            if([_candy getIsFalling]==FALSE)
            {
                // remove BigCandy
                id action3 = [CCActionEaseOut actionWithAction:[CCActionScaleTo actionWithDuration:0.2f scaleX:_candy.scaleX+0.1 scaleY:_candy.scaleY+0.1] rate:1];
                __block Candy* blockBigCandy = _candy;
                id action4 = [CCActionCallBlock actionWithBlock:^{
                    [self  ExploreBigCandy:blockBigCandy  noCondition:false];
                    
                }];
                
                CGFloat randDelay=((double)arc4random() / ARC4RANDOM_MAX)*0.2f + 0.2f;
                id action5=[CCActionSequence actions:[CCActionDelay actionWithDuration: randDelay],action3,action4,[CCActionRemove action], nil ];
                [_candy runAction:action5];
            }
            
        }
    }
    isLookExploreBigCandies=false;
}


- (void)DoExploreCandies:(NSMutableArray *)_LoangValues _needExploreCandies:(NSMutableArray *)_needExploreCandies
{
    
    if([_needExploreCandies count]<=0)
    {
        return;
    }
    
    
    
    CGSize s = [CCDirector sharedDirector].viewSize;
    
    NSMutableArray* arSourceCandies = [NSMutableArray array];
    NSMutableArray* arDestinyCandes = [NSMutableArray array];
    
    for(Candy* _candy in _needExploreCandies)
    {
        if([arSourceCandies containsObject:_candy])
            continue;
        
        
        NSNumber *valueCandy = [[_LoangValues objectAtIndex:_candy.rowNumber] objectAtIndex:_candy.colNumber];
        for(Candy* _candyT1 in _needExploreCandies)
        {
           // if(_candyT1==_candy )
           //     continue;
            
            NSNumber *valueCandyT1 = [[_LoangValues objectAtIndex:_candyT1.rowNumber] objectAtIndex:_candyT1.colNumber];
            if(valueCandyT1==valueCandy&&( _candy.rowNumber==_candyT1.rowNumber || _candy.colNumber==_candyT1.colNumber))
            {
                if( [arSourceCandies containsObject:_candyT1])
                {
                    Candy*  destCandy=[arDestinyCandes objectAtIndex: [arSourceCandies indexOfObject:_candyT1]];
                    if(( _candy.rowNumber==destCandy.rowNumber || _candy.colNumber==destCandy.colNumber))
                    {
                        [arSourceCandies addObject:_candy];
                        [arDestinyCandes addObject:destCandy ];
                        
                        break;
                    }
                }
            }
        }
        
        if([arSourceCandies containsObject:_candy])
            continue;
        

        
        Candy* maxCandy=nil;
        if([_candy IsBomCandy])
            maxCandy=_candy;
        else
        {
            CGFloat _MaxNeigborWeight=0;
            for(Candy* _candyT1 in _needExploreCandies)
            {
              //  if(_candyT1==_candy )
              //      continue;
                
                NSNumber *valueCandyT1 = [[_LoangValues objectAtIndex:_candyT1.rowNumber] objectAtIndex:_candyT1.colNumber];
                if(valueCandyT1==valueCandy&&( _candy.rowNumber==_candyT1.rowNumber || _candy.colNumber==_candyT1.colNumber))
                {
                    
                    if( _candy.rowNumber==_candyT1.rowNumber)
                    {
                        int iBegin=_candy.colNumber;
                        int iEnd=_candyT1.colNumber;
                        if(iBegin>iEnd)
                        {
                            iBegin=_candyT1.colNumber;
                            iEnd=_candy.colNumber;
                        }
                        BOOL isSameCol=true;
                        for(int i=iBegin+1;i<=iEnd-1;i++)
                        {
                            NSNumber *tempvalue= [[_LoangValues objectAtIndex:_candy.rowNumber] objectAtIndex:i];
                            if( tempvalue!=valueCandy)
                            {
                                isSameCol=false;
                                break;
                            }
                        }
                        
                        if(isSameCol==false)
                            continue;
                    }
                    
                    if( _candy.colNumber==_candyT1.colNumber)
                    {
                        int iBegin=_candy.rowNumber;
                        int iEnd=_candyT1.rowNumber;
                        if(iBegin>iEnd)
                        {
                            iBegin=_candyT1.rowNumber;
                            iEnd=_candy.rowNumber;
                        }
                        BOOL isSameRow=true;
                        for(int i=iBegin+1;i<=iEnd-1;i++)
                        {
                            NSNumber *tempvalue= [[_LoangValues objectAtIndex:i] objectAtIndex:_candy.colNumber];
                            if( tempvalue!=valueCandy)
                            {
                                isSameRow=false;
                                break;
                            }
                        }
                        
                        if(isSameRow==false)
                            continue;
                     
                    }
                    
                    if([_candyT1 IsBomCandy])
                    {
                        maxCandy=_candyT1;
                        break;
                    }else
                    {
                        
                            CGFloat _totalNeigborWeight=0;
                            for(Candy* _candyT2 in _needExploreCandies)
                            {
                                if(_candyT2==_candyT1)
                                    continue;
                                
                                NSNumber *valueCandyT2= [[_LoangValues objectAtIndex:_candyT2.rowNumber] objectAtIndex:_candyT2.colNumber];
                                if( valueCandyT2==valueCandy&&( _candyT1.rowNumber==_candyT2.rowNumber || _candyT1.colNumber==_candyT2.colNumber))
                                {
                                    if( _candyT1.rowNumber==_candyT2.rowNumber)
                                    {
                                        int icounTemp=0;
                                        for(Candy* _candyT3 in _needExploreCandies)
                                        {
                                            NSNumber *valueCandyT3= [[_LoangValues objectAtIndex:_candyT3.rowNumber] objectAtIndex:_candyT3.colNumber];
                                            if( valueCandyT3==valueCandy&& _candyT2.rowNumber==_candyT3.rowNumber)
                                                icounTemp++;
                                        }
                                        if(icounTemp>=3)
                                            _totalNeigborWeight+= [_candyT2 getWeight];
                                        
                                    }else  if( _candyT1.colNumber==_candyT2.colNumber)
                                    {
                                        int icounTemp=0;
                                        for(Candy* _candyT3 in _needExploreCandies)
                                        {
                                            NSNumber *valueCandyT3= [[_LoangValues objectAtIndex:_candyT3.rowNumber] objectAtIndex:_candyT3.colNumber];
                                            if( valueCandyT3==valueCandy&& _candyT2.colNumber==_candyT3.colNumber)
                                                icounTemp++;
                                        }
                                        if(icounTemp>=3)
                                            _totalNeigborWeight+= [_candyT2 getWeight];
                                    }
                                   
                                }
                            }
                            
                            if(  _totalNeigborWeight>=_MaxNeigborWeight)
                            {
                              
                                //  if([arSourceCandies containsObject:_candyT1]==false)
                               {
                                    _MaxNeigborWeight=_totalNeigborWeight;
                                    maxCandy=_candyT1;
                                }
                               // }
                            }
                        
                    }
                    
                }
            }
            
            
            if((maxCandy==nil || [maxCandy IsBomCandy]==false) && lastMovedCandy1!=nil && lastMovedCandy2!=nil)
            {
                NSNumber *valueCandy1 = [[_LoangValues objectAtIndex:lastMovedCandy1.rowNumber] objectAtIndex:lastMovedCandy1.colNumber];
                NSNumber *valueCandy2 = [[_LoangValues objectAtIndex:lastMovedCandy2.rowNumber] objectAtIndex:lastMovedCandy2.colNumber];
                
                if(valueCandy1==valueCandy &&( _candy.rowNumber==lastMovedCandy1.rowNumber || _candy.colNumber==lastMovedCandy1.colNumber))
                    maxCandy=lastMovedCandy1;
                
                else if(valueCandy2==valueCandy&&( _candy.rowNumber==lastMovedCandy2.rowNumber || _candy.colNumber==lastMovedCandy2.colNumber))
                    maxCandy=lastMovedCandy2;
            }
             
        }

         if(maxCandy!=nil)
         {
           //  if( [arSourceCandies containsObject:maxCandy]==false && [arSourceCandies containsObject:_candy]==false && [arDestinyCandes containsObject:_candy]==false
           //     && [combineCandies containsObject:_candy]==false)
          //   {
             /*
                 if( _candy.rowNumber==maxCandy.rowNumber)
                 {
                     int iBegin=_candy.colNumber;
                     int iEnd=maxCandy.colNumber;
                     if(iBegin>iEnd)
                     {
                         iBegin=maxCandy.colNumber;
                         iEnd=_candy.colNumber;
                     }
                     BOOL isOK=true;
                     for(int i=iBegin+1;i<=iEnd-1;i++)
                     {
                         Candy* candytemp=[self getCandyByAddress:_candy.rowNumber :i];
                         if( [arSourceCandies containsObject:candytemp]==false)
                         {
                             isOK=false;
                             break;
                         }else
                         {
                            Candy*  destCandy=[arDestinyCandes objectAtIndex: [arSourceCandies indexOfObject:candytemp]];
                             if( destCandy!=maxCandy)
                             {
                                 isOK=false;
                                 break;
                             }
                         }
                     }
                     
                     if(isOK==false)
                         continue;
                 }
                 
                 if( _candy.colNumber==maxCandy.colNumber)
                 {
                     int iBegin=_candy.rowNumber;
                     int iEnd=maxCandy.rowNumber;
                     if(iBegin>iEnd)
                     {
                         iBegin=maxCandy.rowNumber;
                         iEnd=_candy.rowNumber;
                     }
                 
                     BOOL isOK=true;
                     
                     for(int i=iBegin+1;i<=iEnd-1;i++)
                     {

                         Candy* candytemp=[self getCandyByAddress:i :_candy.colNumber];
                         if( [arSourceCandies containsObject:candytemp]==false)
                         {
                             isOK=false;
                             break;
                         }else
                         {
                             Candy*  destCandy=[arDestinyCandes objectAtIndex: [arSourceCandies indexOfObject:candytemp]];
                             if( destCandy!=maxCandy)
                             {
                                 isOK=false;
                                 break;
                             }
                         }

                     }
                     
                     if(isOK==false)
                         continue;
                     */
                     
             
             if([arSourceCandies containsObject:_candy]==false)
             {

                 [arSourceCandies addObject:_candy];
                 [arDestinyCandes addObject:maxCandy ];
             }
         }
        
    }
    
    NSMutableArray* arDesitnyCandiesProcessed = [NSMutableArray array];
    
    CGFloat iGroupCount=0;
    

    for(Candy* _candyDestiny in arDestinyCandes)
    {
        
        if([arDesitnyCandiesProcessed containsObject:_candyDestiny])
            continue;
        [arDesitnyCandiesProcessed addObject:_candyDestiny];
      
        iGroupCount++;
        
        BOOL canCombine=TRUE;
       
        Candy* maxWeightCandy=_candyDestiny;
        
        CGFloat exCandyIndex=0;
        for(Candy* _candy in arSourceCandies)
        {
            if(_candy==_candyDestiny)
                continue;
            
            Candy*  destCandy=[arDestinyCandes objectAtIndex: [arSourceCandies indexOfObject:_candy]];
            if(_candyDestiny==destCandy)
            {
                
                NSNumber *valueCandy = [[_LoangValues objectAtIndex:_candy.rowNumber] objectAtIndex:_candy.colNumber];
              
                
                for(Candy* _candyTemp in _needExploreCandies)
                {
                    NSNumber *valueCandyTemp = [[_LoangValues objectAtIndex:_candyTemp.rowNumber] objectAtIndex:_candyTemp.colNumber];
                    
                    if(valueCandyTemp==valueCandy )
                        if(//[fallingCandies containsObject:valueCandyTemp] || [fallingCandies containsObject:valueCandyTemp] ||
                           [genningCandies containsObject:valueCandyTemp] || [genningCandies containsObject:valueCandyTemp])
                        {
                            canCombine= false;
                            break;
                        }
                    
                }
                
                if(!canCombine)
                    break;
                
                if([maxWeightCandy getWeight]<[_candy getWeight])
                    maxWeightCandy=_candy;
                
                exCandyIndex++;
           
 
                [self CombineCandy:_candy toRow:_candyDestiny.rowNumber toCol:_candyDestiny.colNumber atGroup:iGroupCount atIndex:exCandyIndex];

            }
            
        }
        
         CGFloat weight=[maxWeightCandy getWeight];
        for(Candy* _candy in arSourceCandies)
        {
            if(_candy==maxWeightCandy)
                continue;
            
            Candy*  destCandy=[arDestinyCandes objectAtIndex: [arSourceCandies indexOfObject:_candy]];
            if(_candyDestiny==destCandy)
            {
                weight+=0.17f*[_candy getWeight];
            }
        }

        CGFloat newScale=weight*[[GamePlay instance] getCandyScale]/[_candyDestiny getBeginWeight];
        id actionBig =[CCActionScaleTo actionWithDuration:0.45f scaleX:newScale scaleY:newScale];
        id actionBig1=[CCActionSequence actions:actionBig, nil ];
        
        __block Candy* blockBigCandy2 = _candyDestiny;
        __block CGFloat blockWeight2=weight;
        id action4 = [CCActionCallBlock actionWithBlock:^{
            
            lastMovedCandy1=nil;
            lastMovedCandy2=nil;
            [blockBigCandy2 setWeight:blockWeight2];
            if([blockBigCandy2 IsBomCandy] || [blockBigCandy2 getWeight] >= [[GamePlay instance] getExploreWeight])
                [self  ExploreBigCandy:blockBigCandy2  noCondition:false];
            
            [self falldownAvaiableCandies];

        }];
        
        CGFloat randDelay=((double)arc4random() / ARC4RANDOM_MAX)*0.2f + 0.5f;
        id action6=[CCActionSequence actions:[CCActionDelay actionWithDuration: iGroupCount*0.2f],actionBig1,[CCActionDelay actionWithDuration: randDelay],action4,nil ];
        [_candyDestiny runAction:action6];
        
        
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"Sounds/Switch.mp3" volume:1.2f pitch:1.f pan:0 loop:false];


    }
    
}

bool isLockCheckExplore=false;
-(NSMutableArray*) checkExplore :(BOOL) checkOnly
{
    
    if(isLockCheckExplore || [_gameOver IsGameOver])
        return (NSMutableArray*)[NSMutableArray array];
    
    NSMutableArray* _needExploreLoangValue = [NSMutableArray array];
    
    NSMutableArray* _needExploreCandies = [NSMutableArray array];
    
    
    isLockCheckExplore=true;
    
    NSMutableArray* _LoangValues = [NSMutableArray array];
    for(NSInteger i=0;i<rowNo;i++)
    {
        NSMutableArray* _temp = [NSMutableArray array];
        
        for(NSInteger j=0;j<colNo;j++)
        {
            Candy* _candy=  [self getCandyByAddress:i :j];
            if(_candy!=nil)
            {
                NSNumber *value = [NSNumber  numberWithInt:i*10+j];
                [_temp addObject:value];
            }else
            {
                NSNumber *value = [NSNumber  numberWithInt:-1];
                [_temp addObject:value];
            }
            
        }
        
        [_LoangValues addObject:_temp];
    }
    
    
    for(NSInteger i=0;i<rowNo;i++)
    {
        
        for(NSInteger j=0;j<colNo;j++)
        {
            
            Candy* _candy=  [self getCandyByAddress:i :j];
            if(_candy!=nil)
            {
                NSNumber *valueLoangCurrent = [[_LoangValues objectAtIndex:i] objectAtIndex:j];
                
                if(i>0)
                {
                    NSNumber *valueLoang = [[_LoangValues objectAtIndex:i-1] objectAtIndex:j];
                    
                    Candy* _candyUp=  [self getCandyByAddress:i-1 :j];
                    if(_candyUp!=nil)
                    {
                        if([[_candy getType] isEqualToString:[_candyUp getType]])
                        {
                            for(NSInteger i1=rowNo-1;i1>=0;i1--)
                            {
                                
                                for(NSInteger j1=colNo-1;j1>=0;j1--)
                                {
                                    Candy* _candyTemp=  [self getCandyByAddress:i1 :j1];
                                    if(_candyTemp!=nil)
                                    {
                                        if([[_LoangValues objectAtIndex:i1] objectAtIndex:j1] == valueLoang)
                                            [[_LoangValues objectAtIndex:i1] setObject:valueLoangCurrent atIndex:j1];
                                        
                                    }
                                    
                                }
                            }
                        }
                    }
                }
                
                if(j>0)
                {
                    NSNumber *valueLoang = [[_LoangValues objectAtIndex:i] objectAtIndex:j-1];
                    
                    Candy* _candyLeft=  [self getCandyByAddress:i :j-1];
                    if(_candyLeft!=nil)
                    {
                        if([[_candy getType] isEqualToString:[_candyLeft getType]])
                        {
                            for(NSInteger i1=rowNo-1;i1>=0;i1--)
                            {
                                
                                for(NSInteger j1=colNo-1;j1>=0;j1--)
                                {
                                    Candy* _candyTemp=  [self getCandyByAddress:i1 :j1];
                                    if(_candyTemp!=nil)
                                    {
                                        if([[_LoangValues objectAtIndex:i1] objectAtIndex:j1] == valueLoang)
                                            [[_LoangValues objectAtIndex:i1] setObject:valueLoangCurrent atIndex:j1];
                                        
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    
    for(NSInteger i=rowNo-1;i>=0;i--)
    {
        
        for(NSInteger j=0;j<colNo;j++)
        {
            
            Candy* _candy=  [self getCandyByAddress:i :j];
            if(_candy!=nil)
            {
                NSNumber *valueLoang = [[_LoangValues objectAtIndex:i] objectAtIndex:j];
                
                int count=0;
                for(NSInteger i1=rowNo-1;i1>=0;i1--)
                {
                    NSNumber *valueLoang1 = [[_LoangValues objectAtIndex:i1] objectAtIndex:j];
                    if(valueLoang1==valueLoang)
                    {
                        BOOL isOk=true;
                        if(i1<=i)
                        {
                            for(NSInteger ii=i1;ii<=i;ii++)
                            {
                                NSNumber *valueLoangTemp = [[_LoangValues objectAtIndex:ii] objectAtIndex:j];
                                if(valueLoangTemp!=valueLoang)
                                    isOk=false;
                                
                            }
                        }else
                        {
                            for(NSInteger ii=i;ii<=i1;ii++)
                            {
                                NSNumber *valueLoangTemp = [[_LoangValues objectAtIndex:ii] objectAtIndex:j];
                                if(valueLoangTemp!=valueLoang)
                                    isOk=false;
                                
                            }
                        }
                        if(isOk)
                            count++;
                    }
                    
                }
                
                if(count>=3)
                {
                    [_needExploreCandies addObject:_candy];
                    if([_needExploreLoangValue containsObject:valueLoang])
                        [_needExploreLoangValue addObject:valueLoang];
                    
                }else
                {
                    
                    count=0;
                    for(NSInteger j1=colNo-1;j1>=0;j1--)
                    {
                        NSNumber *valueLoang1 = [[_LoangValues objectAtIndex:i] objectAtIndex:j1];
                        if(valueLoang1==valueLoang)
                        {
                            BOOL isOk=true;
                            if(j1<=j)
                            {
                                for(NSInteger jj=j1;jj<=j;jj++)
                                {
                                    NSNumber *valueLoangTemp = [[_LoangValues objectAtIndex:i] objectAtIndex:jj];
                                    if(valueLoangTemp!=valueLoang)
                                        isOk=false;
                                    
                                }
                            }else
                            {
                                for(NSInteger jj=j;jj<=j1;jj++)
                                {
                                    NSNumber *valueLoangTemp = [[_LoangValues objectAtIndex:i] objectAtIndex:jj];
                                    if(valueLoangTemp!=valueLoang)
                                        isOk=false;
                                    
                                }
                            }
                            if(isOk)
                                count++;
                        }
                        
                    }
                    if(count>=3)
                    {
                        [_needExploreCandies addObject:_candy];
                        if([_needExploreLoangValue containsObject:valueLoang])
                            [_needExploreLoangValue addObject:valueLoang];
                    }
                    
                }
            }
        }
    }
    
    if(!checkOnly)
    {
        isLockCheckExplore=true;
        
        [self DoExploreCandies:_LoangValues _needExploreCandies:_needExploreCandies];
        /*
         for (Candy* _candy in _candies)
         {
         [_candy setSelectedCandy:false];
         }
         */
    }
    isLockCheckExplore=false;
    return _needExploreCandies;
}


bool isLockFallDown=false;
NSMutableArray* fallingCandies;
-(void) falldownAvaiableCandies
{
    //   if(combineCandies!=nil &&[combineCandies count]>0)
    //     return;
    
    
    
    NSMutableArray* removeCandies = [NSMutableArray array];
    for (Candy* candy1 in fallingCandies) {
        if([_candies containsObject:candy1]==FALSE)
            [removeCandies addObject:candy1];
    }
    if([removeCandies count] >0)
    {
        for (Candy* candy12 in removeCandies)
            [fallingCandies removeObject:candy12];
        
    }
    
    for (Candy* candy1 in combineCandies) {
        if([_candies containsObject:candy1]==FALSE)
            [removeCandies addObject:candy1];
    }
    if([removeCandies count] >0)
    {
        for (Candy* candy12 in removeCandies)
            [combineCandies removeObject:candy12];
        
    }
    
    
    removeCandies = [NSMutableArray array];
    for (Candy* candy1 in genningCandies) {
        if([_candies containsObject:candy1]==FALSE)
            [removeCandies addObject:candy1];
    }
    if([removeCandies count] >0)
    {
        for (Candy* candy12 in removeCandies)
            [genningCandies removeObject:candy12];
        
    }
    
    if ([genningCandies count]<=0 && isLockGenCandies)
        isLockGenCandies=false;
    
    if([fallingCandies count]<=0 && isLockFallDown)
        isLockFallDown=false;
    
    if(isLockFallDown||isLockGenCandies)
        return;
    
    isLockFallDown=true;
    
    CGFloat random = ((double)arc4random() / ARC4RANDOM_MAX);
    
    NSMutableArray* _needFallCandies = [NSMutableArray array];
    NSMutableArray* _newAddressRow= [NSMutableArray array];
    
    CGSize s = [CCDirector sharedDirector].viewSize;
    
    int countCandy=0;
    // do {
    //   countCandy=0;
    
    for(NSInteger i=rowNo-1;i>=0;i--)
    {
        
        for(NSInteger j=0;j<colNo;j++)
        {
            Cell* _cell0 = [self getCellByAddress:i :j];
            if(_cell0==nil || [_cell0 getIsEmpty])
                continue;
            
            
            Candy* _candy=  [self getCandyByAddress:i :j];
            if(_candy!=nil && [_needFallCandies containsObject:_candy]==false&& [fallingCandies containsObject:_candy]==false && [genningCandies containsObject:_candy]==false)
            {
                int count=0;
                
                for(NSInteger i1=i+1;i1<rowNo;i1++)
                {
                    
                    Candy* _candy1=  [self getCandyByAddress:i1 :j];
                    if(_candy1==nil)
                    {
                        count++;
                    }
                    
                    /*else
                     {
                     Candy* _candy0=  [self getCandyByAddress:i1-1 :j];
                     if(_candy0==nil)
                     break;
                     }*/
                    
                    
                }
                
                
                
                if(count>0)
                {
                    
                    int newCount=count;
                    
                    for(int c=rowNo-1;c>_candy.rowNumber;c--)
                    {
                        Cell* _cell = [self getCellByAddress:c :j];
                        if(_cell==nil || [_cell getIsEmpty])
                            newCount--;
                        else
                            break;
                    }
                    count =newCount;
                    NSNumber *value = [NSNumber  numberWithInt:(_candy.rowNumber + count)];
                    /*
                     if( [_needFallCandies containsObject:_candy])
                     {
                     NSInteger indexC=  [_needFallCandies indexOfObject:_candy];
                     NSNumber* valueC=  [_newAddressRow objectAtIndex:indexC];
                     
                     if(valueC.intValue>value.intValue)
                     {
                     [_needFallCandies removeObjectAtIndex:indexC];
                     [_newAddressRow  removeObjectAtIndex:indexC];
                     
                     
                     [_needFallCandies addObject:_candy];
                     [_newAddressRow addObject:value];
                     countCandy++;
                     }
                     }else{
                     */
                    if(count>0)
                    {
                        
                        countCandy++;
                        
                        [_needFallCandies addObject:_candy];
                        [_newAddressRow addObject:value];
                        
                    }
                    // }
                    
                    
                }
            }
        }
    }
    
    
    
    //  } while (countCandy>0);
    
    
    for(NSInteger i=0;i<[_needFallCandies count];i++)
    {
        Candy* _candy=  [_needFallCandies objectAtIndex:i];
        NSNumber* value=  [_newAddressRow objectAtIndex:i];
        if([fallingCandies containsObject:_candy])
            continue;
        
        
        Candy* _candyTemp=  [self getCandyByAddress:value.intValue  :_candy.colNumber];
        if(_candyTemp!=nil)
            continue;
        
        int count=value.intValue - _candy.rowNumber;
        
        CGFloat temp=random>0.5f ? _candy.colNumber: (colNo-_candy.colNumber);
        id action0=[CCActionDelay actionWithDuration:0.05f*(colNo-temp)];
        
        CGFloat indentX= (s.width - [[GamePlay instance] getColNo] *[Cell getCellWidht])/2  + [Cell getCellWidht]/2 +2;
        CGPoint newPosCandy=ccp(_candy.colNumber*[Cell getCellWidht]+ indentX,(_candy.rowNumber + count)*[Cell getCellWidht] + [[GamePlay instance] getNodeIndent]);
        
        
        
        id action1=[CCActionMoveTo actionWithDuration:count*0.23f-(count-1)*0.06f position:ccp(newPosCandy.x,newPosCandy.y+2)];
        id action2=[CCActionFadeIn actionWithDuration:count*0.23f-(count-1)*0.06f];
        id action3=[CCActionSpawn actions:action1,action2, nil];
        
        id action11=[CCActionMoveTo actionWithDuration:0.15f position:ccp(newPosCandy.x,newPosCandy.y -2)];
        id action12=[CCActionMoveTo actionWithDuration:0.15f position:ccp(newPosCandy.x,newPosCandy.y)];
        
        
        [_candy setIsFalling:TRUE];
        isLockFallDown=true;
        
        [fallingCandies addObject:_candy];
        
        __block Candy* blockFallingCandy = _candy;
        __block NSNumber* blockValue= value;
        id action5 = [CCActionCallBlock actionWithBlock:^{
            
            
            // blockFallingCandy.position=ccp(blockFallingCandy.colNumber*[Cell getCellWidht]+ indentX,blockFallingCandy.rowNumber*[Cell getCellWidht] + [[GamePlay instance] getNodeIndent]);
            
            if([fallingCandies containsObject:blockFallingCandy])
                [fallingCandies removeObject:blockFallingCandy];
            
            [blockFallingCandy setIsFalling:FALSE];
            if ([fallingCandies count]<=0 && isLockFallDown) {
                isLockFallDown=false;
               // [self doCheckExplore];
            }
            
            if ([fallingCandies count]<=0)
            {
                lastTimeFinishFalling = [NSDate date];
                [self falldownAvaiableCandies];
                // [self  generateNewCandies];
                //    [self runAction: [CCActionSequence actions:[CCActionDelay actionWithDuration:0.3f],[CCActionCallFunc actionWithTarget:self selector:@selector(generateNewCandies)],nil]];
                
            }
            
            
            
            
        }];
        id action4=[CCActionSequence actions:action0,action3,action5,action11,action12, nil];
        [_candy runAction:action4];
        
        [_candy updateNewAddress:value.intValue :_candy.colNumber];
        
    }
    
    
    
    /* isLockFallDown=(countCandy>0);
     if ([fallingCandies count]<=0 && isLockFallDown) {
     isLockFallDown=false;
     }
     */
    
    if(countCandy<=0)
    {
        isLockFallDown=false;
        [self generateNewCandies];
    }
    // else
    //  [self doCheckExplore];
}

NSDate* lastTimeFinishFalling;
bool isLockGenCandies=false;
NSMutableArray* genningCandies;

-(void) generateNewCandies
{
    // if(combineCandies!=nil &&[combineCandies count]>0)
    //    return;
    
    if( [_gameOver IsGameOver])
        return;
    
    if(isLockFallDown||isLockGenCandies)
        return;
    
    /*
     if(lastTimeFinishFalling!=nil)
     {
     
     NSTimeInterval elapsedSeconds = [[NSDate date]  timeIntervalSinceDate: lastTimeFinishFalling];
     if(elapsedSeconds <0.6f)
     return;
     else
     lastTimeFinishFalling=[NSDate date] ;
     }
     */
    
    isLockGenCandies=true;
    
    CGFloat random = ((double)arc4random() / ARC4RANDOM_MAX);
    
    CGSize s = [CCDirector sharedDirector].viewSize;
    
    int countNew=0;
    for(NSInteger i=rowNo-1;i>=0;i--)
    {
        
        for(NSInteger j=0;j<colNo;j++)
        {
            
            Candy* _candy=  [self getCandyByAddress:i :j];
            if(_candy==nil)
            {
                bool isOK=true;
                for(NSInteger i1=i-1;i1>0;i1--)
                {
                    Candy* _candy1=  [self getCandyByAddress:i1 :j];
                    if(_candy1!=nil)
                    {
                        isOK=false;
                        break;
                    }
                }
                
                
                if(isOK)
                {
                    
                    
                    Cell* _cell =[self getCellByAddress:i :j];
                    if(_cell!=nil && [_cell getIsEmpty]==false)// && [_candies count]<CellVisibleNo)
                    {
                        countNew++;
                        _candy= (Candy*)[Candy loadCandy:i :j];
                        _candy.zOrder= _cell.zOrder+1;
                        
                        
                        CGFloat indentX= (s.width - [[GamePlay instance] getColNo] *[Cell getCellWidht])/2  + [Cell getCellWidht]/2 +2;
                        CGPoint orgPos=ccp(j*[Cell getCellWidht]+ indentX,i*[Cell getCellWidht] + [[GamePlay instance] getNodeIndent]);
                        
                        _candy.position=ccp(orgPos.x,-[Cell getCellWidht]);
                        
                        
                        [self addChild:_candy];
                        [_candies addObject:_candy];
                        
                        isLockGenCandies=true;
                        [genningCandies addObject:_candy];
                        
                        CGFloat temp=random>0.5f ? j: (colNo-j);
                        id action0=[CCActionDelay actionWithDuration:0.002f*(rowNo-i)*(colNo-temp)];
                        
                        id action1=[CCActionMoveTo actionWithDuration:0.04f*(rowNo-i)+ 0.17f position:ccp(orgPos.x,orgPos.y+2)];
                        id action2=[CCActionFadeIn actionWithDuration:0.04f*(rowNo-i)+ 0.17f];
                        id action3=[CCActionSpawn actions:action1,action2, nil];
                        
                        id action11=[CCActionMoveTo actionWithDuration:0.15f position:ccp(orgPos.x,orgPos.y-2)];
                        id action12=[CCActionMoveTo actionWithDuration:0.15f position:orgPos];
                        
                          [_candy setIsFalling:TRUE];
                        __block Candy* blockCandyGen=_candy;
                        id action5 = [CCActionCallBlock actionWithBlock:^{
                            
                            [blockCandyGen setIsFalling:FALSE];
                            blockCandyGen.position=ccp(blockCandyGen.colNumber*[Cell getCellWidht]+ indentX,blockCandyGen.rowNumber*[Cell getCellWidht] + [[GamePlay instance] getNodeIndent]);
                            
                            if([genningCandies containsObject:blockCandyGen])
                                [genningCandies removeObject:blockCandyGen];
                            
                            if ([genningCandies count]<=0 && isLockGenCandies) {
                                isLockGenCandies=false;
                                
                                // [self falldownAvaiableCandies];
                                // [self generateNewCandies];
                                [self doCheckExplore];
                                
                            }
                            
                            
                            
                        }];
                        
                        id action4=[CCActionSequence actions:action0, action1,action11,action12,action5, nil];
                        [_candy runAction:action4];
                    }
                }
                
            }
        }
        
    }
    
    
    
    if(countNew<=0)
    {
        isLockGenCandies=false;
        [self doCheckExplore];
    }
}


@end
