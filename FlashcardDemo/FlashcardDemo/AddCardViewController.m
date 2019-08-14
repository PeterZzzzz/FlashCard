//
//  AddCardViewController.m
//  FlashcardDemo
//
//  Created by ZhengYang on 2019/8/8.
//  Copyright © 2019 ZhengYang. All rights reserved.
//

#import "AddCardViewController.h"
#import "ViewController.h"

@interface AddCardViewController ()

@property (weak, nonatomic) IBOutlet UITextField *wordTextfield;
@property (weak, nonatomic) IBOutlet UITextField *desTextfield;
@property (weak, nonatomic) IBOutlet UILabel *helpText;

@end

@implementation AddCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)addButtonClicked {
    if ([self.wordTextfield.text isEqualToString:@""] || [self.desTextfield.text isEqualToString:@""]) {
        self.helpText.text = @"Input all information";
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *allLists = [defaults objectForKey:@"allLists"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:allLists];
    if ([dict objectForKey:self.wordTextfield.text]==NULL) {
        [dict setObject:self.desTextfield.text forKey:self.wordTextfield.text];
        self.helpText.text = @"Add successed";
    }else
    {
        self.helpText.text = @"Word already exist";
    }
    [defaults setObject:dict forKey:@"allLists"];
    [defaults synchronize];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
