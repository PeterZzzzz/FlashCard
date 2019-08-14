//
//  CardView.h
//  FlashcardDemo
//
//  Created by ZhengYang on 2019/8/9.
//  Copyright © 2019 ZhengYang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardView : UIView

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *descriLabel;
@property (nonatomic, strong) UILabel *learnedLabel;
@property (nonatomic, strong) UISwitch *learnedSwitch;
@property (nonatomic, strong) UIButton *cardBackGround;
@property (nonatomic,assign) CGFloat        dist;
@property (nonatomic,assign) BOOL isDrag;
@property (nonatomic,assign) CGFloat startX;
@property (nonatomic,assign) CGFloat offX;

@end

NS_ASSUME_NONNULL_END
