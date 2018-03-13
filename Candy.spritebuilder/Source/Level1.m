//
//  Level1.m
//  Candy
//
//  Created by Nam Trung on 1/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Level1.h"

#define ARC4RANDOM_MAX      0x100000000
@implementation Level1
{
    CCNode* _BG;
    
}

- (void)didLoadFromCCB {
    
     
    //self.userInteractionEnabled = false;
    
    NSInteger rand=((double)arc4random() / ARC4RANDOM_MAX)*10;
    NSString* path=nil;
    
    if(rand<=1)
        path= @"Resources/BG/bg1.png";
    else if(rand<=2)
        path= @"Resources/BG/bg2.png";
    else if(rand<=3)
        path= @"Resources/BG/bg3.png";
    else if(rand<=4)
        path= @"Resources/BG/bg4.png";
    
    else if(rand<=5)
        path= @"Resources/BG/bg5.png";
    else if(rand<=6)
        path= @"Resources/BG/bg6.png";
    else
        path= @"Resources/BG/bg2.png";
    
    [((CCSprite*)_BG) setTexture:[[CCTextureCache sharedTextureCache] addImage:path]];
    
    CGSize s = [CCDirector sharedDirector].viewSize;
    _BG.scaleX=s.height/(_BG.contentSize.height-50);
    _BG.scaleY=s.height/(_BG.contentSize.height-50);
   // _BG.position = ccp(_BG.position.x , 0);

  //  [self schedule:@selector(genNewOtherCars) interval:2.5f ];
  //  self.scaleX=1.f;
   // self.scaleY=1.f;
}

CGFloat BGSpeedRatio=10;
- (void)update:(CCTime)delta {
    CGSize s = [CCDirector sharedDirector].viewSize;
    CGFloat newX=_BG.position.x;
    newX-=(delta*BGSpeedRatio);
    if(newX<=0||newX>=s.width){
        BGSpeedRatio=-BGSpeedRatio;
        newX-=(delta*BGSpeedRatio);
    }
    
    _BG.position=ccp(newX,_BG.position.y);
    
}

@end
