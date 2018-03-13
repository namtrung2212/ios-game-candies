//
//  Candy.m
//  Candy
//
//  Created by Nam Trung on 1/5/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Candy.h"

#define ARC4RANDOM_MAX      0x100000000

#define CANDYNODESCALE      1.f
#define CANDYNODEINDENTX      80.f
@implementation Candy
{
   
    CCNode* _shadow;
    CCNode* _candyNode;
    
    NSInteger rowNbr;
    NSInteger colNbr;
    
    BOOL isSelected;
    
    BOOL isFalling;
    BOOL isBomCandy;
    
    NSString* _type;
    
    CGFloat weight;
    CGFloat beginWeight;
}

-(NSString*) getType
{
    return _type;
}

+ (Candy*)loadCandy: (NSInteger) row : (NSInteger) col
{
    
    Candy* _candy= (Candy*)[CCBReader load:@"Sprites/Candy"];
    [_candy initCandy:row :col];
    return _candy;
}


- (void)initCandy: (NSInteger) row : (NSInteger) col
{
    rowNbr=row;
    colNbr=col;
    isSelected=FALSE;
    isBomCandy=false;
    
    self.positionType = CCPositionTypeMake(CCPositionUnitPoints, CCPositionUnitPoints, CCPositionReferenceCornerTopLeft) ;
  
    CGSize s = [CCDirector sharedDirector].viewSize;

    CGFloat indentX= (s.width - [[GamePlay instance] getColNo] *[Cell getCellWidht])/2  + [Cell getCellWidht]/2 +2;
    self.position=ccp(col*[Cell getCellWidht]+ indentX,row*[Cell getCellWidht] + [[GamePlay instance] getNodeIndent]);
    
    
     CGFloat random= (((double)arc4random() / ARC4RANDOM_MAX)*100.f) ;
    if([GamePlay getLevelNo]<16)
     isBomCandy=random<1.3f;
   else if([GamePlay getLevelNo] % 24 >16)
        isBomCandy=random<2.5f;
    else
        isBomCandy=random<2.f;
     random = ((double)arc4random() / ARC4RANDOM_MAX)*[[GamePlay instance] getCandyTypeNo];
    if(random<=1)
    {
        if(isBomCandy)
        {
            _candyNode= (CCNode*)[CCBReader load:@"Sprites/BomBlue"];
            _type=@"Blue";
        }else
        {
            _candyNode= (CCNode*)[CCBReader load:@"Sprites/Blue"];
            _type=@"Blue";
        }
    }
    else if(random<=2)
    {
        if(isBomCandy)
        {
            _candyNode= (CCNode*)[CCBReader load:@"Sprites/BomRed"];
            _type=@"Red";
        }else
        {
            _candyNode= (CCNode*)[CCBReader load:@"Sprites/Red"];
            _type=@"Red";
        }

    }
    else if(random<=3)
    {
        
        if(isBomCandy)
        {
            _candyNode= (CCNode*)[CCBReader load:@"Sprites/BomYellow"];
            _type=@"Yellow";

        }else
        {
            _candyNode= (CCNode*)[CCBReader load:@"Sprites/Yellow"];
            _type=@"Yellow";
        }

    }
    else if(random<=4)
    {
        
        if(isBomCandy)
        {
            _candyNode= (CCNode*)[CCBReader load:@"Sprites/BomPurple"];
            _type=@"Purple";
            
        }else
        {
            _candyNode= (CCNode*)[CCBReader load:@"Sprites/Purple"];
            _type=@"Purple";
        }
        
    }
    else if(random<=5)
    {
   
        if(isBomCandy)
        {
            _candyNode= (CCNode*)[CCBReader load:@"Sprites/BomGreen"];
            _type=@"Green";

        }else
        {
            _candyNode= (CCNode*)[CCBReader load:@"Sprites/Green"];
            _type=@"Green";
        }
        
    }
    else
    {
        isBomCandy=false;
        _candyNode= (CCNode*)[CCBReader load:@"Sprites/Dark2"];
        _type=@"Dark2";
    }

    
    
     random = ((double)arc4random() / ARC4RANDOM_MAX)*10;
    if(random<5)
    {
        _candyNode.scaleX=0.64f+ 0.08f;
        _candyNode.scaleY=0.64f+ 0.08f;
    }else if(random<7)
    {
        _candyNode.scaleX=0.64f + 0.12f;
        _candyNode.scaleY=0.64f + 0.12f;
    }else if(random<9)
    {
        _candyNode.scaleX=0.64f + 0.17f;
        _candyNode.scaleY=0.64f + 0.17f;
    }else
    {
        _candyNode.scaleX=0.64f + 0.21f;
        _candyNode.scaleY=0.64f + 0.21f;
    }
    
    if(isBomCandy)
    {
        _candyNode.scaleX=0.64f + 0.21f;
        _candyNode.scaleY=0.64f + 0.21f;
    }
    weight=_candyNode.scaleX;
    beginWeight=_candyNode.scaleX;
    orgScaleX=_candyNode.scaleX;
    orgScaleY=_candyNode.scaleY;
    _shadow.scaleX=_candyNode.scaleX;
    _shadow.scaleY=_candyNode.scaleY;
    _shadow.position=ccp(_candyNode.position.x,_candyNode.position.y- _candyNode.contentSize.height*_candyNode.scaleX/2.15f );
    random = ((double)arc4random() / ARC4RANDOM_MAX)*2;
    if(random<=1)
    {
        _shadow.visible=false;
    }else
    {
        _shadow.visible=true;
    }
    
    [self schedule:@selector(startAnimation) interval:random * 8.f ];
    
    
    [self addChild:_candyNode];
   
}

-(void) startAnimation
{
    if(isBomCandy==false)
    {
        CCBAnimationManager* animationManager = _candyNode.userObject;
        [animationManager runAnimationsForSequenceNamed:animationManager.runningSequenceName];
    }
        [self unschedule:@selector(startAnimation) ];
    
    
    id action1=[CCActionScaleTo actionWithDuration:1.f scaleX:_candyNode.scaleX*1.06f scaleY:_candyNode.scaleY*1.052f];
    id action2=[CCActionScaleTo actionWithDuration:1.f scaleX:_candyNode.scaleX*0.95f scaleY:_candyNode.scaleY*1.0f];
    id action3=[CCActionRepeatForever actionWithAction:[CCActionSequence actions:action1,action2, nil]];
    
    [_candyNode runAction:action3];
    
}

-(void) setSelectedCandy:(BOOL) select
{
    if ([[[GamePlay instance] getGameOver] IsGameOver])
        return;
    
    isSelected=select;
   /*
    if(isSelected)
    {
        _candyNode.scaleX+=0.125f;
        _candyNode.scaleY+=0.125f;
    }else
    {
        _candyNode.scaleX=orgScaleX;
        _candyNode.scaleY=orgScaleY;
        
    }
    
    */
    [self updateShadow];
    
    if(select)
    {
       
      /*  if([_type isEqualToString: @"Red"] || [_type isEqualToString: @"Dark1"])
        {
        
            ccColor4F  colorSelect={0.93,1.00,0.93,1.00};
             [((CCSprite*)_candyNode) setColor: [CCColor colorWithCcColor4f:colorSelect] ];
            
        }else
        {
       */
            ccColor4F colorSelect={1.00,0.80,0.40,0.60};
            [((CCSprite*)_candyNode) setColor: [CCColor colorWithCcColor4f:colorSelect] ];
       // }
        
        CCParticleExplosion* particleExplosion;
        particleExplosion = [[CCParticleExplosion alloc] initWithTotalParticles:1500];
        particleExplosion.texture = [[CCTextureCache sharedTextureCache] addImage:@"focus2.png"];
        particleExplosion.angle=90.0;
        particleExplosion.angleVar=360.0;
        ccBlendFunc blendFunc={GL_SRC_ALPHA,GL_ONE};
        particleExplosion.blendFunc=blendFunc;
        particleExplosion.duration=0.04;
        //  particle.emitterMode=kCCParticleModeGravity;
        ccColor4F startColor={0.86,0.57,0.42,1.00};
        particleExplosion.startColor=[CCColor colorWithCcColor4f:startColor];
        ccColor4F startColorVar={0.00,0.00,0.00,0.00};
        particleExplosion.startColorVar=[CCColor colorWithCcColor4f:startColorVar];
        ccColor4F endColor={0.00,0.00,0.00,1.00};
        particleExplosion.endColor=[CCColor colorWithCcColor4f:endColor];
        ccColor4F endColorVar={0.00,0.00,0.00,0.00};
        particleExplosion.endColorVar=[CCColor colorWithCcColor4f:endColorVar];
        particleExplosion.startSize=0.00;
        particleExplosion.startSizeVar=0.00;
        particleExplosion.endSize=30.00;
        particleExplosion.endSizeVar=5.00;
        particleExplosion.gravity=ccp(2.00,10.00);
        particleExplosion.radialAccel=5.00;
        particleExplosion.radialAccelVar=10.00;
        particleExplosion.speed=200;
        particleExplosion.speedVar= 10;
        particleExplosion.tangentialAccel= 1000;
        particleExplosion.tangentialAccelVar=30;
        particleExplosion.totalParticles=1500;
        particleExplosion.life=0.00;
        particleExplosion.lifeVar=0.50;
        particleExplosion.startSpin=0.00;
        particleExplosion.startSpinVar=0.00;
        particleExplosion.endSpin=0.00;
        particleExplosion.endSpinVar=0.00;
        
        particleExplosion.posVar=ccp(0.00,0.00);
        
        [self addChild:particleExplosion];
        particleExplosion.position = _candyNode.position;
        [particleExplosion resetSystem];

    }else
    {
        ccColor4F colorSelect={1.00,1.00,1.00,1.00};
        [((CCSprite*)_candyNode) setColor: [CCColor colorWithCcColor4f:colorSelect] ];
    }
    
}
-(BOOL) getIsSelectedCandy
{
    return isSelected;
}


-(void) setIsFalling:(BOOL) fall
{
    isFalling=fall;
}
-(BOOL) getIsFalling
{
    return  isFalling;
}

-(NSInteger) rowNumber
{
    return  rowNbr;
}
-(NSInteger) colNumber
{
    return colNbr;
}
-(void) setRowNumber:(NSInteger) row
{
    rowNbr=row;
}
-(void) setColNumber:(NSInteger) col
{
    colNbr=col;
}

-(BOOL) IsBomCandy
{
    return isBomCandy;
}
-(CGFloat) getWeight
{
    return weight;
}

-(CGFloat) getBeginWeight
{
    return  beginWeight;
}
-(CGFloat) getRealScale
{
    return weight*[[GamePlay instance] getCandyScale]/beginWeight;
}

-(void) setWeight:(CGFloat) _weight
{
    weight=_weight;
}

- (void)didLoadFromCCB {
    self.userInteractionEnabled=TRUE;
    self.claimsUserInteraction=TRUE;
    self.scaleX=[[GamePlay instance] getCandyScale];
    self.scaleY=[[GamePlay instance] getCandyScale];
    
    isFalling=false;
    // self.zOrder=1;
    
   
}

-(void) updatePosition
{
    if(isFalling)
        return;
    
    CGSize s = [CCDirector sharedDirector].viewSize;
    CGFloat indentX= (s.width - [[GamePlay instance] getColNo] *[Cell getCellWidht])/2  + [Cell getCellWidht]/2 +2;
    CGFloat newX=colNbr*[Cell getCellWidht]+ indentX;
    CGFloat newY=rowNbr*[Cell getCellWidht] + [[GamePlay instance] getNodeIndent];
    
    if (fabs(self.position.x-newX)>=0.0001f || fabs(self.position.y-newY)>=0.0001f)
        self.position=ccp(newX,newY);
}

CCTime lastTime=0;
CGFloat oldX;
CGFloat oldY;

bool checkPos=TRUE;
- (void)update:(CCTime)delta {
    
    if(oldX!=self.position.x)
        oldX=self.position.x;
    
    if(oldY!=self.position.y)
        oldY=self.position.y;
    
    if(self.position.x==oldX && self.position.y ==oldY)
    {
       
            lastTime+=delta;
            if(lastTime>20)
            {
               
                BOOL isfound=false;
                for(Candy* _candy in [[GamePlay instance] Candies])
                {
                    if(_candy.position.x==self.position.x && _candy.position.y==self.position.y)
                    {
                        [_candy updatePosition];
                        isfound=true;
                    }
                }
                
                [self updatePosition];
              
                lastTime=0;
              
                if([self getWeight] > [[GamePlay instance] getExploreWeight])
                    [[GamePlay instance]  ExploreBigCandy:self noCondition:false ];
                
            }
        

    }else
        lastTime=0;
    
}

- (void)onEnter
{
    [super onEnter];
    self.userInteractionEnabled = YES;
    
    [self updateShadow];
}

CGFloat orgScaleX;
CGFloat orgScaleY;
CGPoint OrgPoint;

CGPoint beginPoint;


- (BOOL)hitTestWithWorldPos:(CGPoint)pos
{
    CGSize s = [CCDirector sharedDirector].viewSize;
    
    if(pos.x>self.position.x +[Cell getCellWidht]/2
       ||pos.x<self.position.x -[Cell getCellWidht]/2
       ||pos.y>s.height - self.position.y +[Cell getCellWidht]/2
       ||pos.y<s.height - self.position.y -[Cell getCellWidht]/2)
        return(NO);
    
    OrgPoint=_candyNode.position;
    
    return(YES);
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    /*
     CGPoint touchLocation = [touch locationInWorld];
     touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
     touchLocation = [self convertToNodeSpace:touchLocation];
     beginPoint=touchLocation;
     */
    // _candy.scaleX=1.115f;
    // _candy.scaleY=1.115f;
    
   /* CCParticleSystem* emitter = [CCParticleSystem particleWithFile:@"click.plist"];
    emitter.position=_candyNode.position;
    emitter.scaleX=1.3f;
    emitter.scaleY=1.3f;
    emitter.opacity=0.6f;
    emitter.zOrder=1;
    [ emitter setStartColor:[CCColor colorWithCcColor4f:ccc4f(1.00,1.00,1.00,1.0)]];
     [ emitter setEndColor:[CCColor colorWithCcColor4f:ccc4f(1.00,1.00,1.00,1.0)]];
    [self addChild:emitter z:0];
    */
    
    if ([[[GamePlay instance] getGameOver] IsGameOver])
        return;
    if(isFalling==FALSE && [[GamePlay instance] getIsLockTouch]==false)
    {
        [self setSelectedCandy:TRUE];
        [self.parent touchBegan:touch withEvent:event];
    }
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    /*
     CGPoint touchLocation = [touch locationInView: [touch view]];
     touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
     touchLocation = [self convertToNodeSpace:touchLocation];
     */
    if ([[[GamePlay instance] getGameOver] IsGameOver])
        return;
    [self.parent touchEnded:touch withEvent:event];
    
    
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if ([[[GamePlay instance] getGameOver] IsGameOver])
        return;
    /*
     CGPoint touchLocation = [touch locationInView: [touch view]];
     touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
     touchLocation = [self convertToNodeSpace:touchLocation];
     
     if(_candy.scaleX!=orgScaleX)
     {
     if(fabsf(beginPoint.x - touchLocation.x) > fabsf(beginPoint.y - touchLocation.y) )
     _candy.position=ccp( OrgPoint.x - (beginPoint.x - touchLocation.x),OrgPoint.y);
     else
     _candy.position=ccp( OrgPoint.x,OrgPoint.y - (beginPoint.y - touchLocation.y));
     }*/
    
     [self.parent touchMoved:touch withEvent:event];
}

-(void) updateShadow
{
    Cell* _cell= (Cell*)  [[GamePlay instance] getCellByAddress:rowNbr :colNbr ];
    if(_cell!=nil && [_cell isHasGrass])
        _shadow.visible=false;
    else
    {
        _shadow.zOrder=_candyNode.zOrder-1;
        _shadow.visible=true;
    }
}
- (void)updateNewAddress: (NSInteger) row : (NSInteger) col
{
    
    rowNbr=row;
    colNbr=col;
       
}



-(void) doExplore
{

    
}
@end
