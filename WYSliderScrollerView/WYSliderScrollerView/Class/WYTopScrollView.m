//
//  WYTopScrollView.m
//  WYSliderScrollerView
//
//  Created by 王王 on 16/1/20.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "WYTopScrollView.h"

#import "WYRootScrollView.h"

#import "Macros.h"

//按钮空隙
#define BUTTONGAP 0
//滑条宽度
#define CONTENTSIZEX WIDTH
//按钮id
#define BUTTONID (sender.tag-100)
//滑动id
#define BUTTONSELECTEDID (scrollViewSelectedChannelID - 100)


@implementation WYTopScrollView

@synthesize nameArray;
@synthesize scrollViewSelectedChannelID;


//+ (WYTopScrollView *)shareInstance {
//    static WYTopScrollView *_instance;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance=[[self alloc] initWithFrame:CGRectMake(0, viewOriginY, CONTENTSIZEX, 44)];
//    });
//    return _instance;
//}

- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, viewOriginY, CONTENTSIZEX, 44);
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        userSelectedChannelID = 100;
        scrollViewSelectedChannelID = 100;
        
        self.buttonOriginXArray = [NSMutableArray array];
        self.buttonWithArray = [NSMutableArray array];
        if ([self respondsToSelector:@selector(adjustRootViewPageWithNotification:)]) {
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustRootViewPageWithNotification:) name:NOTIFICATIONPOSTTOTOPVIEW object:nil];
        }
        
    }
    return self;
}

- (void)initWithNameButtons:(NSInteger )segmentPages
{
    
    float xPos = 0.0;
    for (int i = 0; i < [self.nameArray count]; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = [self.nameArray objectAtIndex:i];
        
        [button setTag:i+100];
        if (i == 0) {
            button.selected = YES;
        }
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13.0];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:UIColorFromRGB(0x868686) forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0xbb0b15) forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        
        //这是按照string的大小来排布
        //        int buttonWidth = [title sizeWithFont:button.titleLabel.font
        //                            constrainedToSize:CGSizeMake(150, 30)
        //                                lineBreakMode:NSLineBreakByClipping].width;
        float buttonWidth = CONTENTSIZEX/segmentPages;
        
        button.frame = CGRectMake(xPos, 9, buttonWidth, 30);
        
        [_buttonOriginXArray addObject:@(xPos)];
        
        xPos += buttonWidth;
        
        [_buttonWithArray addObject:@(button.frame.size.width)];
        
        [self addSubview:button];
    }
    
    self.contentSize = CGSizeMake(xPos, 44);
    
    shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BUTTONGAP, 0, [[_buttonWithArray objectAtIndex:0] floatValue], 44)];
    [shadowImageView setImage:[UIImage imageNamed:@"red_line_and_shadow.png"]];
    [self addSubview:shadowImageView];
}

//点击顶部条滚动标签
- (void)selectNameButton:(UIButton *)sender
{
    [self adjustScrollViewContentX:sender];
    
    //如果更换按钮
    if (sender.tag != userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[self viewWithTag:userSelectedChannelID];
        lastButton.selected = NO;
        //赋值按钮ID
        userSelectedChannelID = sender.tag;
    }
    
    //按钮选中状态
    if (!sender.selected) {
        sender.selected = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [shadowImageView setFrame:CGRectMake(sender.frame.origin.x, 0, [[_buttonWithArray objectAtIndex:BUTTONID] floatValue], 44)];
            
        } completion:^(BOOL finished) {
            if (finished) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATIONPOSTTOROOTVIEW object:nil userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",BUTTONID] forKey:@"buttonid"]];
                NSLog(@"sssssss");
                //赋值滑动列表选择频道ID
                scrollViewSelectedChannelID = sender.tag;
            }
        }];
        
    }
    //重复点击选中按钮
    else {
        
    }
}

- (void)adjustScrollViewContentX:(UIButton *)sender
{
    
    float originX = [[_buttonOriginXArray objectAtIndex:BUTTONID] floatValue];
    float width = [[_buttonWithArray objectAtIndex:BUTTONID] floatValue];
    
    //    NSLog(@"%f",sender.frame.origin.x - self.contentOffset.x );
    //    NSLog(@"%f",CONTENTSIZEX-(BUTTONGAP+width));
    if (sender.frame.origin.x - self.contentOffset.x > CONTENTSIZEX-(BUTTONGAP+width)) {
        [self setContentOffset:CGPointMake(self.contentOffset.x+width , 0)  animated:YES];
    }
    
    if (sender.frame.origin.x - self.contentOffset.x < 5) {
        [self setContentOffset:CGPointMake(originX,0)  animated:YES];
    }
}

//滚动内容页顶部滚动
- (void)setButtonUnSelect
{
    //滑动撤销选中按钮
    UIButton *lastButton = (UIButton *)[self viewWithTag:scrollViewSelectedChannelID];
    lastButton.selected = NO;
}

- (void)setButtonSelect
{
    //滑动选中按钮
    UIButton *button = (UIButton *)[self viewWithTag:scrollViewSelectedChannelID];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [shadowImageView setFrame:CGRectMake(button.frame.origin.x, 0, [[_buttonWithArray objectAtIndex:button.tag-100] floatValue], 44)];
        
    } completion:^(BOOL finished) {
        if (finished) {
            if (!button.selected) {
                button.selected = YES;
                userSelectedChannelID = button.tag;
            }
        }
    }];
    
}

-(void)setScrollViewContentOffset
{
    
    float originX = [[_buttonOriginXArray objectAtIndex:BUTTONSELECTEDID] floatValue];
    float width = [[_buttonWithArray objectAtIndex:BUTTONSELECTEDID] floatValue];
    
    if (originX - self.contentOffset.x > CONTENTSIZEX-(BUTTONGAP+width)) {
        [self setContentOffset:CGPointMake(self.contentOffset.x+width, 0)  animated:YES];
    }
    
    if (originX - self.contentOffset.x < 5) {
        [self setContentOffset:CGPointMake(originX,0)  animated:YES];
    }
}

//当rootview滑动时修改top
- (void)adjustRootViewPageWithNotification:(NSNotification *)notification
{
    NSDictionary *dict = [notification userInfo];
    NSInteger page = [[dict objectForKey:@"positionid"] integerValue];
    [self setButtonUnSelect];
    self.scrollViewSelectedChannelID = page+100;
    [self setButtonSelect];
    [self setScrollViewContentOffset];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NOTIFICATIONPOSTTOTOPVIEW object:nil];
    
}


@end
