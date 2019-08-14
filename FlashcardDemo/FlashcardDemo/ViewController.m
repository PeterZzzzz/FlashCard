//
//  ViewController.m
//  FlashcardDemo
//
//  Created by ZhengYang on 2019/8/8.
//  Copyright © 2019 ZhengYang. All rights reserved.
//

#import "ViewController.h"
#import "CardView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *filterSwitch;


@end

@implementation ViewController

static ViewController *_sharedInstance;

+ (ViewController *) sharedInstance
{
    if (!_sharedInstance)
    {
        _sharedInstance = [[ViewController alloc] init];
    }
    
    return _sharedInstance;
}

- (id) init
{
    if (self = [super init])
    {
        self.righSwipedArray = [[NSMutableArray alloc]init];
        self.cardContainer = [[UIView alloc]init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.dict = [defaults objectForKey:@"allLists"];
    for (NSString *keys in self.dict) {
        NSLog(@"所有key = %@ AND obj = %@",keys,[self.dict objectForKey:keys]);
    }
    NSDictionary *d = [defaults objectForKey:@"learnedLists"];
    for (NSString *keys in d) {
        NSLog(@"学习的key = %@ AND obj = %@",keys,[self.dict objectForKey:keys]);
    }


}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    [self setUpCardsFromDict:self.dict];
    NSLog(@"%@",self.dict);


}

- (NSMutableDictionary*)setUpData
{
    if (self.filterSwitch.on == true) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.dict = [defaults objectForKey:@"learnedLists"];
        self.helpText.text = @"You didn't mark any cards as learned";
    }else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.dict = [defaults objectForKey:@"allLists"];
        self.helpText.text = @"You need add some cards to start playing";

    }
    
    if (self.dict.count==0) {
        [self.helpText setHidden:false];
        [self.cardContainer setHidden:true];
    }else
    {
        [self.helpText setHidden:true];
        [self.cardContainer setHidden:false];
    }

    return self.dict;
}

- (void)loadDataList
{
    if (self.filterSwitch.on == true) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.dict = [defaults objectForKey:@"learnedLists"];
    }else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.dict = [defaults objectForKey:@"allLists"];
        
    }
}

- (void)setUpCardsFromDict: (NSMutableDictionary*) dict
{
    [self.cardContainer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.righSwipedArray removeAllObjects];

    for (NSString *str in dict) {
        CardView *card = [[CardView alloc]initWithFrame:self.cardContainer.bounds];
        [self.cardContainer addSubview:card];
        card.textLabel.text = str;
        card.descriLabel.text = [dict objectForKey:str];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *learnedList = [defaults objectForKey:@"learnedLists"];
        NSMutableDictionary *d = [[NSMutableDictionary alloc]initWithDictionary:learnedList];
        if ([d objectForKey:card.textLabel.text]!=NULL)
        {
            card.learnedSwitch.on = YES;
            card.learnedLabel.text = @"Learned";
        }
    }
    
}


- (IBAction)switchClicked {
    if (self.filterSwitch.on == true) {
        self.titleLabel.text = @"Learned cards";
    }else
    {
        self.titleLabel.text = @"All cards";
    }
    [self setUpData];
    [self setUpCardsFromDict:self.dict];

}

- (IBAction)shuffleBtnClicked {
    
    [self loadDataList];
    NSMutableDictionary *randomDict = [[NSMutableDictionary alloc]init];
    if (self.dict.count != 0) {
        NSMutableArray *keyArray  =  [NSMutableArray arrayWithArray:[self.dict allKeys]];
        for (NSInteger i = keyArray.count; i>1; i--) {
            NSInteger j = arc4random_uniform(i);
            [keyArray exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
        }
        NSLog(@"%@",keyArray);
        for (NSString *str in keyArray) {
            NSLog(@"%@",str);
            [randomDict setObject:[self.dict objectForKey:str] forKey:str];
        }
    }
    self.dict = randomDict;
    [self setUpCardsFromDict:self.dict];
    
}

- (void)leftSwipCard
{
    if (self.righSwipedArray.count == 0) {
        NSLog(@"无法左滑!!!");
        return;
    }else
    {
//        NSString *word = [self.righSwipedArray lastObject];
//        [self loadDataList];
//        CardView *card = [[CardView alloc]initWithFrame:CGRectMake(self.cardContainer.bounds.origin.x, self.cardContainer.bounds.origin.y, 414, 500)];
//        [self.cardContainer addSubview:card];
//        card.textLabel.text = word;
//        card.descriLabel.text = [self.dict objectForKey:word];
//        NSLog(@"创建%@--%@",self.cardContainer,card.descriLabel.text);
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        NSMutableDictionary *learnedList = [defaults objectForKey:@"learnedLists"];
//        NSMutableDictionary *d = [[NSMutableDictionary alloc]initWithDictionary:learnedList];
//        if ([d objectForKey:card.textLabel.text]!=NULL)
//        {
//            card.learnedSwitch.on = YES;
//            card.learnedLabel.text = @"Learned";
//        }
//        [self.righSwipedArray removeLastObject];
        
        
        CardView *card = [self.righSwipedArray lastObject];
        [self.cardContainer addSubview:card];

        NSLog(@"创建%@--%@",self.cardContainer,card.descriLabel.text);
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        NSMutableDictionary *learnedList = [defaults objectForKey:@"learnedLists"];
//        NSMutableDictionary *d = [[NSMutableDictionary alloc]initWithDictionary:learnedList];
//        if ([d objectForKey:card.textLabel.text]!=NULL)
//        {
//            card.learnedSwitch.on = YES;
//            card.learnedLabel.text = @"Learned";
//        }
        [self.righSwipedArray removeLastObject];
    }
}

//- (void)rightSwipCard:(NSString *)word
//{
//    NSLog(@"llllll%@",self.righSwipedArray);
//
//    [self.righSwipedArray addObject:word];
//    NSLog(@"张%@",self.righSwipedArray);
//
//}

- (void)rightSwipCard:(CardView *)card
{
    NSLog(@"llllll%@",self.righSwipedArray);
    
    [self.righSwipedArray addObject:card];
    NSLog(@"张%@",self.righSwipedArray);
    
}

@end
