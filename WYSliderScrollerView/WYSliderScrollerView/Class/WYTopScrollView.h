//
//  WYTopScrollView.h
//  WYSliderScrollerView
//
//  Created by 王王 on 16/1/20.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYTopScrollView.h"


//通知，主要是Top和Rootview之间联系使用
#define NOTIFICATIONPOSTTOROOTVIEW   @"TopViewNatification"
#define NOTIFICATIONPOSTTOTOPVIEW   @"RootViewNatification"


@interface WYTopScrollView : UIScrollView<UIScrollViewDelegate>
{
    NSArray *nameArray;
    NSInteger userSelectedChannelID;        //点击按钮选择名字ID
    NSInteger scrollViewSelectedChannelID;  //滑动列表选择名字ID
    
    UIImageView *shadowImageView;   //选中阴影
}


@property (nonatomic, retain) NSArray *nameArray;

@property(nonatomic,retain)NSMutableArray *buttonOriginXArray;
@property(nonatomic,retain)NSMutableArray *buttonWithArray;

@property (nonatomic, assign) NSInteger scrollViewSelectedChannelID;

//+ (WYTopScrollView *)shareInstance;
/**
 *    加载顶部标签
 *
 *  @param segmentPages 顶部被平均分割成几份
 */
- (void)initWithNameButtons:(NSInteger )segmentPages;
/**
 *  滑动撤销选中按钮
 */
- (void)setButtonUnSelect;
/**
 *  滑动选择按钮
 */
- (void)setButtonSelect;
/**
 *  滑动顶部标签位置适应
 */
-(void)setScrollViewContentOffset;



@end
