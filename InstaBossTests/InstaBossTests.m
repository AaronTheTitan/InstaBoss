//
//  InstaBossTests.m
//  InstaBossTests
//
//  Created by Aaron Bradley on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "BossObject.h"

@interface InstaBossTests : XCTestCase

@end

@implementation InstaBossTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCase {
    NSLog(@"----------->\t%@", [BossObject generateID]);
    NSLog(@"----------->\t%@", [BossObject generateTimeStamp]);
}



@end
