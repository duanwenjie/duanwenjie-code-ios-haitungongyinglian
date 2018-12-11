//
//  HaiWaiHeadView.h
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2017/3/28.
//  Copyright © 2017年 学宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HaiWaiHeadDelegate <NSObject>


/**
 选择了分组 全选或全取消

 @param bSelecte YES 为全选  NO 为全取消
 */
- (void)tapHaiWaiHead:(BOOL)bSelecte;

@end

@interface HaiWaiHeadView : UIView


@property (nonatomic, weak) id<HaiWaiHeadDelegate> delegate;


/**
 改变选择圆圈是否选中

 @param isSelect YES为选中  NO为不勾选
 */
- (void)changeImageSelectState:(BOOL)isSelect;

@end
