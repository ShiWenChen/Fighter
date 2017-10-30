//
//  GameScene.m
//  Fighter
//
//  Created by ShiWen on 2017/10/23.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "GameScene.h"
#import "HeroFIghter.h"
#import "EnemesFighter.h"
#import "HeroMissiles.h"
#import "EnemyMissiles.h"

typedef enum : NSUInteger {
    EnemesOneFly = 1,
    EnemesTriangleFly=2,
    EnemesPositiveDiagonal=3,
    EnemesDiagonalDiagonal = 4
} EnemesType;

@interface GameScene()
{
    NSTimer *_addEnemesTimer;
}
@property (nonatomic ,strong) SKNode *fighterNode;
@property (nonatomic , strong)HeroFIghter *heroFighter;
@property (nonatomic,assign )float lastUpdate;
@property (nonatomic,assign) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic,assign) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic,assign) double timeinterval;




@end

@implementation GameScene
-(instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        //        背景色
        SKSpriteNode *ground = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:63.0/255.0 green:130.0/255.0 blue:210.0/255.0 alpha:1.0] size:size];
        ground.position = CGPointMake((self.frame.size.width / 2), (self.frame.size.height / 2));
        [self addChild:ground];
        //        粒子效果
        SKEmitterNode *backGroud1 = [SKEmitterNode emitterNamed:@"CloudParticleEmitter"];
        backGroud1.position = CGPointMake(size.width/2, size.height/2+200);
        [ground addChild:backGroud1];
        
//        再添加一个云，增加深度
        SKEmitterNode *backGroud2 = [SKEmitterNode emitterNamed:@"CloudParticleEmitter"];
        backGroud2.position = CGPointMake(size.width/2, size.height/2+200);
        [ground addChild:backGroud2];
        
        
        self.fighterNode = [SKNode node];
        [self addChild:self.fighterNode];
        
//        英雄增加边框，使其不会飞出屏幕
        NSLog(@"%f",WIDTH);
        SKSpriteNode *heroBox = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(WIDTH - 5, HIGHT - 5)];
        heroBox.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(5, 5, WIDTH - 5, HIGHT - 5)];
        heroBox.physicsBody.categoryBitMask = heroBoundingBoxCategory;
        heroBox.physicsBody.collisionBitMask = heroFighterCategory|heroMissileCategory|enemyMissleCategory|enemyFighterCategory;
        heroBox.physicsBody.contactTestBitMask = heroFighterCategory;
        heroBox.position = CGPointMake(WIDTH/2, HIGHT/2);
        [self.fighterNode addChild:heroBox];
        
        [self.fighterNode addChild:self.heroFighter];
        NSLog(@"%@",self.view);
        [self addEmemesWithType:EnemesTriangleFly];
        _addEnemesTimer = [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
            int type = arc4random()%4;
            [self addEmemesWithType:type];
        }];
        
        
    }
    return self;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    self.heroFighter.position = CGPointMake(point.x, HIGHT - point.y);
}
-(HeroFIghter *)heroFighter{
    if (!_heroFighter) {
        _heroFighter = [[HeroFIghter alloc] init];
        _heroFighter.position = CGPointMake(WIDTH/2, HIGHT/2);
        
    }
    return _heroFighter;
}
-(void)update:(NSTimeInterval)currentTime{
    //    让物体在一定的时间间隔内生成
    CFTimeInterval  timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    
    if (timeSinceLast > 1) {
        timeSinceLast = 1/60.0;
    }
    self.lastUpdateTimeInterval = currentTime;
    
    self.lastSpawnTimeInterval += timeSinceLast;
    if (self.timeinterval < 0.0) {
        self.timeinterval = 0;
    }

    if (self.lastSpawnTimeInterval > 0.2) {
        self.lastSpawnTimeInterval = 0;
        [self addMissiles];
    }
}

/**
添加炮弹
 */
-(void)addMissiles{
    if (!self.scene.isPaused) {
        HeroMissiles *missle1 = [[HeroMissiles alloc]init];
        missle1.position = CGPointMake(-17, 20);
        [self.heroFighter addChild:missle1];
        SKAction *moveAction1 = [SKAction moveTo:CGPointMake(-17, 1000) duration:1];
        SKAction *removeAction1 = [SKAction removeFromParent];
        SKAction *sequence1 = [SKAction sequence:@[moveAction1,removeAction1]];
        [missle1 runAction:sequence1];
        HeroMissiles *missle2 = [[HeroMissiles alloc]init];
        missle2.position = CGPointMake(17, 20);
        [self.heroFighter addChild:missle2];
        SKAction *moveAction2 = [SKAction moveTo:CGPointMake(17, 1000) duration:1];
        SKAction *removeAction2 = [SKAction removeFromParent];
        SKAction *sequence2 = [SKAction sequence:@[moveAction2,removeAction2]];
        [missle2 runAction:sequence2];
    }
}
//添加敌机
-(void)addEmemesWithType:(EnemesType)type{
    //        enemsfighter宽度为60

    float interval = (WIDTH - 60 * 5)/6;

    if (type == EnemesOneFly) {
        NSLog(@"横着一字排开");
        for (int i = 0; i<5; i++) {
            EnemesFighter *enemsfighter = [[EnemesFighter alloc] init];
            
            enemsfighter.position = CGPointMake(interval+enemsfighter.size.width/2 +(interval + enemsfighter.size.width) * i, HIGHT + enemsfighter.size.height/2);
            [self action:enemsfighter];
            [self addEnemesMissilesWith:enemsfighter];

            [self addChild:enemsfighter];
        }
        
    }
    if (type == EnemesTriangleFly) {
        NSLog(@"三角状飞来");
//        enemsfighter高度为52
        int fighterHigth = 52;
        for (int i = 0; i<5; i++) {
            EnemesFighter *enemsfighter = [[EnemesFighter alloc] init];
            if (i<3) {
                enemsfighter.position = CGPointMake(interval+enemsfighter.size.width/2 +(interval + enemsfighter.size.width) * i, HIGHT+5*fighterHigth  - (enemsfighter.size.height + fighterHigth)*i);

            }
            if (i == 3) {
                enemsfighter.position = CGPointMake(interval+enemsfighter.size.width/2 +(interval + enemsfighter.size.width) * i, HIGHT+5*fighterHigth  - (enemsfighter.size.height + fighterHigth));

            }
            if (i == 4) {
                enemsfighter.position = CGPointMake(interval+enemsfighter.size.width/2 +(interval + enemsfighter.size.width) * i, HIGHT+5*fighterHigth);
                
            }

            [self action:enemsfighter];
            [self addEnemesMissilesWith:enemsfighter];

            [self addChild:enemsfighter];
        }
    }
    if (type == EnemesPositiveDiagonal) {
        NSLog(@"对角线飞来");
        //        enemsfighter高度为52
        int fighterHigth = 52;
        for (int i = 0; i<5; i++) {
            EnemesFighter *enemsfighter = [[EnemesFighter alloc] init];
            enemsfighter.position = CGPointMake(interval+enemsfighter.size.width/2 +(interval + enemsfighter.size.width) * i, HIGHT+9*fighterHigth  - (enemsfighter.size.height + fighterHigth)*i);

            [self action:enemsfighter];
            [self addEnemesMissilesWith:enemsfighter];

            [self addChild:enemsfighter];
        }
    }
    if (type == EnemesDiagonalDiagonal) {
        int fighterHigth = 52;
        for (int i = 0; i<5; i++) {
            EnemesFighter *enemsfighter = [[EnemesFighter alloc] init];
            enemsfighter.position = CGPointMake(interval+enemsfighter.size.width/2 +(interval + enemsfighter.size.width) * i, HIGHT+enemsfighter.size.height   + (enemsfighter.size.height + fighterHigth)*i);
            
            [self action:enemsfighter];
            [self addEnemesMissilesWith:enemsfighter];
            [self addChild:enemsfighter];
        }
    }
    
}

-(void)addEnemesMissilesWith:(EnemesFighter*)fight{
    EnemyMissiles *missle1 = [[EnemyMissiles alloc]init];
    missle1.position = CGPointMake(0, 20);
    [fight addChild:missle1];
    SKAction *moveAction1 = [SKAction moveTo:CGPointMake(0, 1000) duration:2];
    SKAction *removeAction1 = [SKAction removeFromParent];
    SKAction *sequence1 = [SKAction sequence:@[moveAction1,removeAction1]];
    [missle1 runAction:sequence1];
}

-(void)action:(SKSpriteNode *)node{
    SKAction *rotate = [SKAction rotateToAngle:M_PI duration:0];
    SKAction *move = [SKAction moveTo:CGPointMake(node.position.x, -1000) duration:10];
    SKAction *remove = [SKAction removeFromParent];
    
    [node runAction:[SKAction sequence:@[rotate,move,remove]]];
}








@end
