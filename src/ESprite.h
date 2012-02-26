//
//  ESprite.h
//  Extended Sprite
//
//  Created by Elliot Franford on 1/16/12.
//  Copyright (c) 2012 Abandon Hope Games, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPMovieClip.h"
#import "SPEvent.h"
#import "SPEnterFrameEvent.h"
#import "ESpriteState.h"
#import "SPMacros.h"
#import "EMedia.h"

@interface ESprite : SPSprite <NSXMLParserDelegate> {
#define EVENT_TYPE_SPRITE_ANIMATION_CHANGE @"spriteAnimationChanged"
@private
    NSMutableDictionary* stateAnimationDictionary;
    SPMovieClip* currentAnimation;
    NSString* spriteAtlasFile;
    ESpriteState* currentState;
    SPJuggler* juggler;
}
- (id) initWithESpriteFile:(NSString*)file;
- (id) initWithESpriteFile:(NSString*)file AndInitialAnimation:(NSString*)initialAnimation;
- (id) getAnimation;

- (void)onMoveSprite:(SPEvent*)evt:(float)speed:(float)angle;
- (void)setSpritePositionX:(int)x Y:(int)y;
- (void)parseTMXXml:(NSString *)path;
- (ESpriteState*)getFirstAnimation;
- (void)setState:(ESpriteState*)state;
- (void)setStateUsingKey:(NSString*)key;
- (void)changeState:(ESpriteState*)state;
- (void)advanceTime:(double)time;


@property (nonatomic,assign) NSMutableDictionary* stateAnimationDictionary;
@property (nonatomic,assign) SPMovieClip* currentAnimation;
@property (nonatomic,assign) NSString* spriteAtlasFile;
@property (nonatomic,assign) ESpriteState* currentState;
@property (nonatomic,assign) SPJuggler* juggler;
@end
