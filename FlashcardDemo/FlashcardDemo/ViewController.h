//
//  ViewController.h
//  FlashcardDemo
//
//  Created by ZhengYang on 2019/8/8.
//  Copyright © 2019 ZhengYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"


@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *helpText;
@property (strong, nonatomic) IBOutlet UIView *cardContainer;
@property(nonatomic,strong) NSMutableDictionary *dict;
@property(nonatomic,strong) NSMutableArray *righSwipedArray;
- (void)loadDataList;
- (void)leftSwipCard;
//- (void)rightSwipCard:(NSString *)word;
- (void)rightSwipCard:(CardView *)card;
+ (ViewController *) sharedInstance;  

@end

