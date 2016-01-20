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
#define BUTTONGAP 10
//滑条宽度
#define CONTENTSIZEX 320
//按钮id
#define BUTTONID (sender.tag-100)
//滑动id
#define BUTTONSELECTEDID (scrollViewSelectedChannelID - 100)


@implementation WYTopScrollView

@synthesize nameArray;
@synthesize scrollViewSelectedChannelID;

+ (WYTopScrollView *)shareInstance {
    static WYTopScrollView *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[[self alloc] initWithFrame:CGRectMake(0, IOS7_STATUS_BAR_HEGHT, CONTENTSIZEX, 44)];
    });
    return _instance;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        userSelectedChannelID = 100;
        scrollViewSelectedChannelID = 100;
        
        self.buttonOriginXArray = [NSMutableArray array];
        self.buttonWithArray = [NSMutableArray array];
    }
    return self;
}

- (void)initWithNameButtons
{
    float xPos = 5.0;
    for (int i = 0; i < [self.nameArray count]; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = [self.nameArray objectAtIndex:i];
        
        [button setTag:i+100];
        if (i == 0) {
            button.selected = YES;
        }
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:20.0];
        [button setTitleColor:UIColorFromRGB(0x868686) forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0xbb0b15) forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        
        int buttonWidth = [title sizeWithFont:button.titleLabel.font
                            constrainedToSize:CGSizeMake(150, 30)
                                lineBreakMode:NSLineBreakByClipping].width;
        
        button.frame = CGRectMake(xPos, 9, buttonWidth, 30);
        
        [_buttonOriginXArray addObject:@(xPos)];
        
        xPos += buttonWidth+BUTTONGAP;
        
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
                //设置新闻页出现
                [[WYRootScrollView shareInstance] setContentOffset:CGPointMake(BUTTONID*320, 0) animated:YES];
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
    
    if (sender.frame.origin.x - self.contentOffset.x > CONTENTSIZEX-(BUTTONGAP+width)) {
        [self setContentOffset:CGPointMake(originX - 30, 0)  animated:YES];
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
        [self setContentOffset:CGPointMake(originX - 30, 0)  animated:YES];
    }
    
    if (originX - self.contentOffset.x < 5) {
        [self setContentOffset:CGPointMake(originX,0)  animated:YES];
    }
}


@end
