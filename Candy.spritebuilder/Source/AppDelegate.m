/*
 * SpriteBuilder: http://www.spritebuilder.org
 *
 * Copyright (c) 2012 Zynga Inc.
 * Copyright (c) 2013 Apportable Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
#define ARC4RANDOM_MAX      0x100000000
#import "cocos2d.h"

#import "AppDelegate.h"
#import "CCBuilderReader.h"
#import "GamePlay.h"
@implementation AppController

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Configure Cocos2d with the options set in SpriteBuilder
    NSString* configPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Published-iOS"]; // TODO: add support for Published-Android support
    configPath = [configPath stringByAppendingPathComponent:@"configCocos2d.plist"];
    
    NSMutableDictionary* cocos2dSetup = [NSMutableDictionary dictionaryWithContentsOfFile:configPath];
    
    // Note: this needs to happen before configureCCFileUtils is called, because we need apportable to correctly setup the screen scale factor.
#ifdef APPORTABLE
    if([cocos2dSetup[CCSetupScreenMode] isEqual:CCScreenModeFixed])
        [UIScreen mainScreen].currentMode = [UIScreenMode emulatedMode:UIScreenAspectFitEmulationMode];
    else
        [UIScreen mainScreen].currentMode = [UIScreenMode emulatedMode:UIScreenScaledAspectFitEmulationMode];
#endif
    
    // Configure CCFileUtils to work with SpriteBuilder
    [CCBReader configureCCFileUtils];
    
    // Do any extra configuration of Cocos2d here (the example line changes the pixel format for faster rendering, but with less colors)
    //[cocos2dSetup setObject:kEAGLColorFormatRGB565 forKey:CCConfigPixelFormat];
    
    [self setupCocos2dWithOptions:cocos2dSetup];
    
    return YES;
}

- (CCScene*) startScene
{
    
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

    NSString* bestLevel=[[NSUserDefaults standardUserDefaults ] objectForKey:@"bestLevel"];
    if(bestLevel==nil)
        bestLevel=@"0";
    if([bestLevel intValue]<96)
        [GamePlay setLevelNo: [bestLevel intValue]+1];
    else
        [GamePlay setLevelNo: [bestLevel intValue]];


    CCScene* gameplay= (CCScene*) [CCBReader loadAsScene:@"GamePlay"];
    return (CCScene*)gameplay;

}

@end
