//
//  Cell.m
//  Candy
//
//  Created by Nam Trung on 1/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Cell.h"
#define ARC4RANDOM_MAX      0x100000000

#define CELLBGSCALE      0.9f
#define CELLBGWIDHT      330.f

@implementation Cell
{
    CCSprite* _cellBG;
    CCNode*  _grass;
    
    NSInteger rowNbr;
    NSInteger colNbr;
    
    BOOL isEmpty;
}


-(BOOL) getIsEmpty
{
    return  isEmpty;
}

+ (Cell*)loadCell: (NSInteger) row : (NSInteger) col {
    
    Cell* _cell= (Cell*)[CCBReader load:@"Sprites/Cell"];
  
    _cell.userInteractionEnabled=FALSE;
    
    
    [_cell setCellPosition:row :col];
    return _cell;
}

+ (CGFloat)getCellWidht
{
    return CELLBGWIDHT * CELLBGSCALE * [[GamePlay instance] getCandyScale]+0.5f;
}

- (void)setCellPosition: (NSInteger) row : (NSInteger) col
{
    rowNbr=row;
    colNbr=col;
    
    isEmpty=false;
    if([[GamePlay instance] getBoardType]<=0)
    {
        if(rowNbr<=1 && colNbr<=1 && !(rowNbr==1 && colNbr==1))
            isEmpty=true;
        else  if(rowNbr>=[[GamePlay instance] getRowNo]-2 && colNbr>=[[GamePlay instance] getColNo]-2 && !(rowNbr==[[GamePlay instance] getRowNo]-2 && colNbr==[[GamePlay instance] getColNo]-2))
            isEmpty=true;
        
    }else if([[GamePlay instance] getBoardType]<=1)
    {
        if(rowNbr<=1 && colNbr>=[[GamePlay instance] getColNo]-2 && !(rowNbr==1 && colNbr==[[GamePlay instance] getColNo]-2))
            isEmpty=true;
        else  if(rowNbr>=[[GamePlay instance] getRowNo]-2 && colNbr<=1 && !(rowNbr==[[GamePlay instance] getRowNo]-2 && colNbr==1))
            isEmpty=true;
    }else if([[GamePlay instance] getBoardType]<=2)
    {
        if(rowNbr<=1 &&  (colNbr<=1  || colNbr>=[[GamePlay instance] getColNo]-2) && !(rowNbr==1 &&  (colNbr==1  ||colNbr==[[GamePlay instance] getColNo]-2)))
            isEmpty=true;
        else  if(rowNbr>=[[GamePlay instance] getRowNo]-2 && (colNbr<=1  || colNbr>=[[GamePlay instance] getColNo]-2) && !(rowNbr==[[GamePlay instance] getRowNo]-2 && (colNbr==1  ||colNbr==[[GamePlay instance] getColNo]-2)))
            isEmpty=true;
    }


}
- (void)initCell {
    
    
    if(!isEmpty)
    {
        NSString* path=nil;
        
        if(rowNbr==0|| [[[GamePlay instance] getCellByAddress:rowNbr-1 :colNbr] getIsEmpty])
        {
            if(colNbr==0|| [[[GamePlay instance] getCellByAddress:rowNbr :colNbr-1] getIsEmpty])
                path= @"Resources/Grounds/9_part_01.png";
            else if(colNbr==[[GamePlay instance] getColNo]-1|| [[[GamePlay instance] getCellByAddress:rowNbr :colNbr+1] getIsEmpty])
                path= @"Resources/Grounds/9_part_03.png";
            else
                path= @"Resources/Grounds/9_part_02.png";
            
        }else if(rowNbr == [[GamePlay instance] getRowNo]-1|| [[[GamePlay instance] getCellByAddress:rowNbr+1 :colNbr] getIsEmpty])
        {
            if(colNbr==0|| [[[GamePlay instance] getCellByAddress:rowNbr :colNbr-1] getIsEmpty])
                path= @"Resources/Grounds/9_part_07.png";
            else if(colNbr==[[GamePlay instance] getColNo]-1|| [[[GamePlay instance] getCellByAddress:rowNbr :colNbr+1] getIsEmpty])
                path= @"Resources/Grounds/9_part_09.png";
            else
                path= @"Resources/Grounds/9_part_08.png";
        }else
        {
            if(colNbr==0|| [[[GamePlay instance] getCellByAddress:rowNbr :colNbr-1] getIsEmpty])
                path= @"Resources/Grounds/9_part_04.png";
            else if(colNbr==[[GamePlay instance] getColNo]-1|| [[[GamePlay instance] getCellByAddress:rowNbr :colNbr+1] getIsEmpty])
                path= @"Resources/Grounds/9_part_06.png";
            else
                path= @"Resources/Grounds/9_part_05.png";
        }
        
       
        if(path!=nil)
        {
            CCSpriteFrame* imageframe = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:path];
            _cellBG.spriteFrame=imageframe;
            _cellBG.scaleX=CELLBGSCALE;
            _cellBG.scaleY=CELLBGSCALE;
            _cellBG.opacity=0.55f;
        }
        
        CGFloat random = ((double)arc4random() / ARC4RANDOM_MAX)*2;
        if(random<=1)
        {
            _grass.opacity=1.f;
            _grass.scaleX=0.85f;
            _grass.scaleY=0.85f;
            _grass.visible=true;
            
        }else
        {
            _grass.visible=false;
        }

    }else
    {
        _cellBG.visible=false;
         _grass.visible=false;
    }
    
    CGSize s = [CCDirector sharedDirector].viewSize;
    CGFloat indentX= (s.width - [[GamePlay instance] getColNo] *[Cell getCellWidht])/2  + [Cell getCellWidht]/2;
    self.position=ccp(colNbr*[Cell getCellWidht] + indentX,rowNbr*[Cell getCellWidht] + [[GamePlay instance] getNodeIndent]);
    self.positionType = CCPositionTypeMake(CCPositionUnitPoints, CCPositionUnitPoints, CCPositionReferenceCornerTopLeft) ;
    
    self.userInteractionEnabled=FALSE;

}


-(BOOL) isHasGrass
{
    return _grass.visible;
}
-(NSInteger) RowNumber
{
    return  rowNbr;
}
-(NSInteger) ColumnNumber
{
    return colNbr;
}
- (void)didLoadFromCCB {
   
    self.scaleX=[[GamePlay instance] getCandyScale];
    self.scaleY=[[GamePlay instance] getCandyScale];
    self.zOrder=1;
    self.userInteractionEnabled=FALSE;
    

}

@end
