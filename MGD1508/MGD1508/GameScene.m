//
//  GameScene.m
//  MobileGame
//
//  Created by Shaun Thompson on 8/6/15.
//  Copyright (c) 2015 Shaun Thompson. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

static const uint32_t heroCategory      =  0x1 << 0;
static const uint32_t worldCategory     =  0x1 << 1;
static const uint32_t enemyCategory     =  0x1 << 1;



-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    // Background image
    SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"paperbackground"];
    bgImage.position = CGPointMake(self.size.width/2, self.size.height/2);
    bgImage.xScale = 1;
    bgImage.yScale = 1;
    bgImage.physicsBody.categoryBitMask = worldCategory;
    [self addChild:bgImage];
    
    /*
    // title on screen (this was a test, will be removed in alpha version)
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myLabel.text = @"It's Sticks!";
    myLabel.fontSize = 45;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   (CGRectGetMidY(self.frame)+100));
    [self addChild:myLabel];
     */
    
    
    // Create main character texture
    SKTexture* h1Texture = [SKTexture textureWithImageNamed:@"cRun1"];
    h1Texture.filteringMode = SKTextureFilteringNearest;
    SKTexture* h2Texture = [SKTexture textureWithImageNamed:@"crun2"];
    h2Texture.filteringMode = SKTextureFilteringNearest;

    // Main character node assignment & physics body
    _hero = [SKSpriteNode spriteNodeWithTexture:h1Texture];
    _hero.xScale = 1;
    _hero.yScale = 1;
    _hero.name = @"hero";
    _hero.position = CGPointMake(CGRectGetMidX(self.frame),
                                CGRectGetMidY(self.frame));
    _hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_hero.size];
    _hero.physicsBody.dynamic = YES;
    _hero.physicsBody.allowsRotation = NO;
    _hero.physicsBody.categoryBitMask = heroCategory;
    _hero.physicsBody.collisionBitMask = worldCategory | enemyCategory;
    _hero.physicsBody.contactTestBitMask = worldCategory |  enemyCategory;
    
    [self addChild:_hero];
    
    // Animate hero movement
    SKAction* run = [SKAction repeatActionForever:[SKAction animateWithTextures:@[h1Texture, h2Texture] timePerFrame:0.2]];
    [_hero runAction:run];
    
    // Enemy fish sprite node assignment & physics body
    SKSpriteNode *fish = [SKSpriteNode spriteNodeWithImageNamed:@"Fish"];
    fish.xScale = .35;
    fish.yScale = .35;
    fish.name = @"fish";
    
    fish.position = CGPointMake((CGRectGetMidX(self.frame)-100),
                                CGRectGetMidY(self.frame));
    fish.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:fish.size];
    fish.physicsBody.dynamic = YES;
    fish.physicsBody.allowsRotation = NO;
    fish.physicsBody.categoryBitMask = enemyCategory;
    fish.physicsBody.contactTestBitMask = heroCategory;
    
    [self addChild:fish];
    
    // Enemy Bee sprite node assignment & physics body
    SKSpriteNode *bee = [SKSpriteNode spriteNodeWithImageNamed:@"Bee"];
    bee.xScale = 0.5;
    bee.xScale = 0.5;
    bee.name = @"bee";
    bee.position = CGPointMake((CGRectGetMidX(self.frame)+100),
                               CGRectGetMidY(self.frame));
    //bee.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bee.size];
    bee.physicsBody.dynamic = YES;
    bee.physicsBody.allowsRotation = NO;
    bee.physicsBody.categoryBitMask = enemyCategory;
    bee.physicsBody.contactTestBitMask = heroCategory;
    
    
    [self addChild:bee];
    
    
    // Ground Image
    SKTexture* gTexture = [SKTexture textureWithImageNamed:@"brick"];
    gTexture.filteringMode = SKTextureFilteringNearest;
    
    // Create action to simulate ground movement
    SKAction* gMovement = [SKAction moveByX:-gTexture.size.width*2 y:0 duration:0.02 * gTexture.size.width*2];
    SKAction* gReset    = [SKAction moveByX:gTexture.size.width*2 y:0 duration:0];
    SKAction* gSequence = [SKAction repeatActionForever:[SKAction sequence:@[gMovement, gReset]]];

    // Set loop to duplicate node texture in order to create platform
    for( int i = 0; i < 2 + self.frame.size.width / ( gTexture.size.width * 2 ); ++i ) {
        
        SKSpriteNode* ground = [SKSpriteNode spriteNodeWithTexture:gTexture];
        
        [ground setScale:2.0];
        
        ground.position = CGPointMake(i * ground.size.width, ground.size.height / 2);
        
        [ground runAction:gSequence];
        
        [self addChild:ground];
    }
    
    SKNode* groundNode = [SKNode node];
    
    groundNode.position = CGPointMake(0, gTexture.size.height);
    groundNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.frame.size.width, gTexture.size.height * 2)];
    groundNode.physicsBody.dynamic = NO;
    [self addChild:groundNode];
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    

    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        
        
        // define location of user touch
        CGPoint location = [touch locationInNode:self];

        // determine if user touch is equivelant to node location
        SKNode *node = [self nodeAtPoint:location];
        
        // run sound or action with corresponding with appropriate node
        if ([node.name isEqualToString:@"hero"]) {
            [node runAction:[SKAction playSoundFileNamed:@"grunt.mp3" waitForCompletion:NO]];
            
        }
        else if ([node.name isEqualToString:@"fish"]){
            [node runAction:[SKAction playSoundFileNamed:@"glub.mp3" waitForCompletion:NO]];
        }
        else if ([node.name isEqualToString:@"bee"]){
            [node runAction:[SKAction playSoundFileNamed:@"insect.mp3" waitForCompletion:NO]];
        }
        
        // Move bees based on user input
        SKAction *heroMove = [SKAction moveTo:location duration:2];
        [_hero runAction:heroMove];
        
        

    }  
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
}

/*
- (void)addCollisionWallAtWorldPoint:(CGPoint)worldPoint withWidth:(CGFloat)width height:(CGFloat)height {
    // Create a rectangle with the specified size, and a basic node
    wallNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rect.size];
    wallNode.physicsBody.dynamic = NO;
    wallNode.physicsBody.categoryBitMask = APAColliderTypeWall;
}
*/

// Physics Delegate init function
-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {

        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;

    }
    return self;
}



- (void)didBeginContact:(SKPhysicsContact *)contact
{

    NSLog(@"Body A: %@ contacting Body B: %@",contact.bodyA.node.name, contact.bodyB.node.name);
    
    SKPhysicsBody *firstBody, *secondBody;
    
    firstBody = contact.bodyA;
    secondBody = contact.bodyB;
    
    if(firstBody.categoryBitMask == enemyCategory || secondBody.categoryBitMask == enemyCategory)
    {
        SKNode *node = contact.bodyA.node;
        NSLog(@"COLISSION");
        [node runAction: [SKAction playSoundFileNamed:@"eating.mp3" waitForCompletion:NO]];
        
    }
    
    


    

    
}


@end
