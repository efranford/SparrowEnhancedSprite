//
//  Game.h
//  AppScaffold
//

#import <Foundation/Foundation.h>
#import "ESprite.h"
#import "ESpriteManager.h"
@interface Game : SPStage{
    @private
    ESprite* sprite;
}
- (void)onButtonTriggered:(SPEvent *)event;
- (void)onAwayButtonTriggered:(SPEvent *)event;
@end
