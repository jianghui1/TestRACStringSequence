//
//  TestRACStringSequenceTests.m
//  TestRACStringSequenceTests
//
//  Created by ys on 2018/8/17.
//  Copyright © 2018年 ys. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <ReactiveCocoa.h>
#import <RACStringSequence.h>

@interface TestRACStringSequenceTests : XCTestCase

@end

@implementation TestRACStringSequenceTests

- (void)test_sequenceWithString
{
    RACSequence *sequence = [RACStringSequence sequenceWithString:@"abc" offset:0];
    NSLog(@"sequenceWithString -- %@", sequence);
    
    // 打印日志：
    /*
     2018-08-17 17:27:52.782259+0800 TestRACStringSequence[51424:18355473] sequenceWithString -- <RACStringSequence: 0x6040004317e0>{ name = , string = abc }
     */
}

- (void)test_head
{
    RACSequence *sequence = [RACStringSequence sequenceWithString:@"abc" offset:0];
    NSLog(@"head -- %@", sequence.head);
    
    // 打印日志：
    /*
     2018-08-17 17:30:05.796562+0800 TestRACStringSequence[51512:18362582] head -- a
     */
}

- (void)test_tail
{
    RACSequence *sequence = [RACStringSequence sequenceWithString:@"abc" offset:0];
    NSLog(@"tail -- %@", sequence.tail);
    
    // 打印日志：
    /*
     2018-08-17 17:31:20.424395+0800 TestRACStringSequence[51571:18366588] tail -- <RACStringSequence: 0x604000231cc0>{ name = , string = bc }
     */
}

- (void)test_array
{
    RACSequence *sequence = [RACStringSequence sequenceWithString:@"abc" offset:0];
    NSLog(@"array -- %@", sequence.array);
    
    // 打印日志：
    /*
     2018-08-17 17:32:16.880412+0800 TestRACStringSequence[51625:18369711] array -- (
     a,
     b,
     c
     )
     */
}

@end
