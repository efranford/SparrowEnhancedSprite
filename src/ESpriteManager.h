//
//  ESpriteManager.h
//  AppScaffold
//
//  Created by Elliot Franford on 1/16/12.
//  Copyright (c) 2012 Abandon Hope Games, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESprite.h"

@interface ESpriteManager

@property (nonatomic,assign) NSMutableDictionary* sprites;

+(id)initManager;
+(void) addSprite:(ESprite*)sprite withName:(NSString*)name;
+(void) removeSpriteWithName:(NSString*)name;
+(ESprite*) spriteByName:(NSString*)name;
+(void) setSpriteState:(NSString*)state forSpriteWithName:(NSString*)name;
+(void) advanceTime:(double)time;
@end
