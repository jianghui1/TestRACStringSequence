##### `RACStringSequence`作为`RACSequence`的子类，顾名思义，就是处理`string`数据的。

完整测试用例[在这里](https://github.com/jianghui1/TestRACStringSequence)。

分析`.m`中的方法：

    + (RACSequence *)sequenceWithString:(NSString *)string offset:(NSUInteger)offset {
    	NSCParameterAssert(offset <= string.length);
    
    	if (offset == string.length) return self.empty;
    
    	RACStringSequence *seq = [[self alloc] init];
    	seq->_string = [string copy];
    	seq->_offset = offset;
    	return seq;
    }
初始化一个`RACStringSequence`对象，同时保存参数`string` `offset`。

测试用例：

    - (void)test_sequenceWithString
    {
        RACSequence *sequence = [RACStringSequence sequenceWithString:@"abc" offset:0];
        NSLog(@"sequenceWithString -- %@", sequence);
        
        // 打印日志：
        /*
         2018-08-17 17:27:52.782259+0800 TestRACStringSequence[51424:18355473] sequenceWithString -- <RACStringSequence: 0x6040004317e0>{ name = , string = abc }
         */
    }
***

    - (id)head {
    	return [self.string substringWithRange:NSMakeRange(self.offset, 1)];
    }
通过保存的`string`调用`substringWithRange:`方法，获取到指定偏移量`offset`位置的字符，作为`head`值。

测试用例：

    - (void)test_head
    {
        RACSequence *sequence = [RACStringSequence sequenceWithString:@"abc" offset:0];
        NSLog(@"head -- %@", sequence.head);
        
        // 打印日志：
        /*
         2018-08-17 17:30:05.796562+0800 TestRACStringSequence[51512:18362582] head -- a
         */
    }
***

    - (RACSequence *)tail {
    	RACSequence *sequence = [self.class sequenceWithString:self.string offset:self.offset + 1];
    	sequence.name = self.name;
    	return sequence;
    }
通过调用`sequenceWithString:offset:`设置偏移量增加`1`，生成一个`RACSequence`对象作为`tail`值。

测试用例：

    - (void)test_tail
    {
        RACSequence *sequence = [RACStringSequence sequenceWithString:@"abc" offset:0];
        NSLog(@"tail -- %@", sequence.tail);
        
        // 打印日志：
        /*
         2018-08-17 17:31:20.424395+0800 TestRACStringSequence[51571:18366588] tail -- <RACStringSequence: 0x604000231cc0>{ name = , string = bc }
         */
    }
***

    - (NSArray *)array {
    	NSUInteger substringLength = self.string.length - self.offset;
    	NSMutableArray *array = [NSMutableArray arrayWithCapacity:substringLength];
    
    	[self.string enumerateSubstringsInRange:NSMakeRange(self.offset, substringLength) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
    		[array addObject:substring];
    	}];
    
    	return [array copy];
    }
通过保存的`string` 调用`enumerateSubstringsInRange:`方法拿到从指定偏移量`offset`开始一直到字符串结束的所有字符，组成的字符数组。

测试用例：

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
***

##### 所以，该类的作用就是将字符串转换成序列，然后通过序列的方法完成对字符串的操作。
