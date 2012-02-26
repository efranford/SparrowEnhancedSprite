//
//  ESpriteState.h
//  AppScaffold
//
//  Created by Elliot Franford on 1/16/12.
//  Copyright (c) 2012 Abandon Hope Games, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

//<State name="idle" anmationPrefix="away_" animationFPS="10"/>
@interface ESpriteState : NSObject{

@private
    NSString* mStateName;
    NSString* mAnimationPrefix;
    int mAnimationFPS;
    BOOL mLoop;
}

@property (nonatomic,assign) NSString* stateName;
@property (nonatomic,assign) NSString* animationPrefix;
@property (nonatomic,assign) int animationFPS;
@property (nonatomic,assign) BOOL loop;

- (id) init;
- (id) initWithName:(NSString*)name prefix:(NSString*)prefix fps:(int)fps loop:(BOOL)loop;

@end
