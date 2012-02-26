//
//  ESpriteManager.h
//  AppScaffold
//
//  Created by Elliot Franford on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
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
