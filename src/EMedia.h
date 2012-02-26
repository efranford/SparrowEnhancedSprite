//
//  EMedia.h
//  Extended Media
//
//  Created by Elliot Franford on 1/16/12.
//  Copyright (c) 2012 Abandon Hope Games, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPStage.h"
#import "SPSoundChannel.h"
#import "SPTextureAtlas.h"
#import "SPAudioEngine.h"

@interface EMedia : NSObject

@property (nonatomic,retain) SPStage* stage;
@property (nonatomic,retain) SPJuggler* juggler;

+ (void)initTextures:(NSString*)atlasFile;
+ (void)releaseTextures;
+ (SPTexture *)atlasTexture:(NSString *)name;
+ (NSArray *)texturesStartingWith:(NSString *)name;

+ (void)initAudio;
+ (void)releaseAudio;

+ (void)initStage;
+ (void)releaseStage;
+ (SPStage*)getStage;
+ (void)onAddToStage:(SPEvent*)evt;

+ (void)initJuggler;
+ (void)releaseJuggler;
+ (SPJuggler*)getJuggler;

+ (void)playSound:(NSString *)soundName;
+ (SPSoundChannel *)soundChannel:(NSString *)soundName;

extern int RETINA_WIDTH;
extern int RETINA_HEIGHT;
extern int NORMAL_WIDTH;
extern int NORMAL_HEIGHT;

@end
