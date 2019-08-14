//
//  CardView.m
//  FlashcardDemo
//
//  Created by ZhengYang on 2019/8/9.
//  Copyright © 2019 ZhengYang. All rights reserved.
//

#import "CardView.h"
#import "ViewController.h"
@implementation CardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    UIButton *card = [[UIButton alloc]initWithFrame:CGRectMake(frame.origin.x
                                                            , frame.origin.y, frame.size.width, frame.size.height)];
    [self addSubview:card];
    card.backgroundColor = [UIColor grayColor];
    self.cardBackGround = card;
    [self.cardBackGround addTarget:self action:@selector(dragCard:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.cardBackGround addTarget:self action:@selector(ifCardRemove) forControlEvents:UIControlEventTouchUpInside];
    self.isDrag = NO;
    
    
    
    UILabel *descriText = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, self.cardBackGround.bounds.size.width-20, self.cardBackGround.bounds.size.height/2)];
    descriText.text = @"Answer";
    descriText.backgroundColor = [UIColor blueColor];
    descriText.textAlignment = NSTextAlignmentCenter;
    [descriText addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(descriLabelClicked)]];
    descriText.userInteractionEnabled = YES;
    [self.cardBackGround addSubview:descriText];
    self.descriLabel = descriText;
    
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, self.cardBackGround.bounds.size.width-20, self.cardBackGround.bounds.size.height/2)];
    text.text = @"testtesttest";
    text.backgroundColor = [UIColor yellowColor];
    text.textAlignment = NSTextAlignmentCenter;
    [text addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textLabelClicked)]];
    text.userInteractionEnabled = YES;
    [self.cardBackGround addSubview:text];
    self.textLabel = text;
    
    UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.cardBackGround.bounds)-64, 90, 44)];
    deleteBtn.backgroundColor = [UIColor brownColor];
    [deleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.cardBackGround addSubview:deleteBtn];
    
    
    UILabel *learnedText = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.cardBackGround.bounds)-200, CGRectGetMaxY(self.cardBackGround.bounds)-64, 180, 44)];
    learnedText.text = @"Marked as learned";
    learnedText.backgroundColor = [UIColor lightGrayColor];
    learnedText.textAlignment = NSTextAlignmentCenter;
    [self.cardBackGround addSubview:learnedText];
    self.learnedLabel = learnedText;
    
    
    UISwitch *s = [[UISwitch alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.cardBackGround.bounds)-130, CGRectGetMaxY(self.cardBackGround.bounds)-108, 80, 40)];
    s.on = NO;
    [s addTarget:self action:@selector(switchClicked) forControlEvents:UIControlEventValueChanged];
    [self.cardBackGround addSubview:s];
    self.learnedSwitch = s;
    
    return self;
}

- (void)deleteBtnClick
{
    ViewController *vc = [[ViewController alloc]init];
    [vc loadDataList];
    NSLog(@"%@",vc.dict);
    NSMutableDictionary *mdict = [[NSMutableDictionary alloc]initWithDictionary:vc.dict];
    [mdict removeObjectForKey:self.textLabel.text];
    vc.dict = mdict;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:vc.dict forKey:@"allLists"];
    [defaults synchronize];
    
    [self removeFromSuperview];
    if (vc.dict.count==0) {
        [vc.helpText setHidden:false];
        vc.cardContainer.backgroundColor = [UIColor greenColor];
        [vc.cardContainer setHidden:true];
    }else
    {
        [vc.helpText setHidden:true];
        vc.cardContainer.backgroundColor = [UIColor yellowColor];

        [vc.cardContainer setHidden:false];
    }
    
    
//    if (self.learnedSwitch.on == true) {
//        NSMutableDictionary *d = [defaults objectForKey:@"learnedLists"];
//        [d removeObjectForKey:self.textLabel.text];
//        [defaults setObject:d forKey:@"learnedLists"];
//        [defaults synchronize];
//    }
    
    NSLog(@"delete %@",self.textLabel.text);
}

- (void)switchClicked {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *learnedList = [defaults objectForKey:@"learnedLists"];
    NSMutableDictionary *d = [[NSMutableDictionary alloc]initWithDictionary:learnedList];
    NSLog(@"%@",d);

    if (self.learnedSwitch.on == true) {
        self.learnedLabel.text = @"Learned";
        [d setObject:self.descriLabel.text forKey:self.textLabel.text];
        [defaults setObject:d forKey:@"learnedLists"];
        [defaults synchronize];
        
    }else
    {
        self.learnedLabel.text = @"Marked as learned";
        [d removeObjectForKey:self.textLabel.text];
        [defaults setObject:d forKey:@"learnedLists"];
        [defaults synchronize];
    }
}

- (void)textLabelClicked
{
    [UIView beginAnimations:@"doflip" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.textLabel cache:YES];
    [UIView setAnimationDidStopSelector:@selector(animation1Finished)];
    [UIView commitAnimations];

}

- (void)descriLabelClicked
{
    [UIView beginAnimations:@"doflip" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.descriLabel cache:YES];
    [UIView setAnimationDidStopSelector:@selector(animation2Finished)];
    [UIView commitAnimations];
}

- (void)animation1Finished
{
    [self.textLabel setHidden:YES];
    [self.descriLabel setHidden:NO];
}

- (void)animation2Finished
{
    [self.textLabel setHidden:NO];
    [self.descriLabel setHidden:YES];
}


- (void) dragCard: (UIControl *) c withEvent:ev
{
    if (!self.isDrag) {
        self.startX = [[[ev allTouches] anyObject]locationInView:self].x;
        self.offX = c.frame.size.width/2 - self.startX;
        self.isDrag = YES;
//        NSLog(@"%f:::::%f",self.startX,self.offX);
    }
    c.center = CGPointMake([[[ev allTouches] anyObject]locationInView:self].x+self.offX, c.center.y);
    float dist = c.center.x-self.bounds.size.width/2;
    self.dist = dist;
//    NSLog(@"%f",self.dist);
//    NSLog(@"%f:::::%f",c.center.x,c.center.y);

}

-(void)ifCardRemove{
    self.isDrag = NO;
    ViewController *vc = [ViewController sharedInstance];

    if (self.dist < 15 && self.dist > -15) {
        NSLog(@"用户信息");
        self.cardBackGround.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);

    }else if(self.dist < 200 && self.dist > -200){
        
        NSLog(@"弹簧效果");
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:10.0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.cardBackGround.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        } completion:nil];
        
    }else if(self.dist < -200){

        self.cardBackGround.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [vc leftSwipCard];
        NSLog(@"上一张");

        
        
        
        
    }else if(self.dist > 200)
    {
        [vc rightSwipCard:self];
        [self removeFromSuperview];
//        [vc rightSwipCard:self.textLabel.text];
        
        NSLog(@"下一张%@",vc.righSwipedArray);
        
    }
    
}



@end
