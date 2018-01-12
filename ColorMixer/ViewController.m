//
//  ViewController.m
//  ColorMixer
//
//  Created by lösen är 0000 on 2018-01-12.
//  Copyright © 2018 Robert Eriksson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *redAmount;
@property (weak, nonatomic) IBOutlet UISlider *greenAmount;
@property (weak, nonatomic) IBOutlet UISlider *blueAmount;
@property (weak, nonatomic) IBOutlet UIView *colorDisplay;
@property (weak, nonatomic) IBOutlet UIView *leftColorDisplay;
@property (weak, nonatomic) IBOutlet UIView *rightColorDisplay;
@property (weak, nonatomic) IBOutlet UIView *randomColorDisplay;

@property float redColor;
@property float greenColor;
@property float blueColor;
@property float difficulty;
@property int gamesWon;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.gamesWon = 0;
    [self refresh];
    [self refreshRandomColor];
}

- (IBAction)sliderChanged:(id)sender {
    [self refresh];
    if ([self isColorSimilar]){
        [self refreshRandomColor];
    }
}

- (IBAction)resetColor:(id)sender {
    self.redAmount.value = 0.5f;
    self.greenAmount.value = 0.5f;
    self.blueAmount.value = 0.5f;
    [self refresh];
}

- (IBAction)invertColor:(id)sender {
    self.redAmount.value = 1 - self.redAmount.value;
    self.greenAmount.value = 1 - self.greenAmount.value;
    self.blueAmount.value = 1 - self.blueAmount.value;
    [self refresh];
}

- (IBAction)randomColor:(id)sender {
    self.redAmount.value = arc4random_uniform(100) / 100.0f;
    self.greenAmount.value = arc4random_uniform(100) / 100.0f;
    self.blueAmount.value = arc4random_uniform(100) / 100.0f;
    [self refresh];
}

- (void) refresh{
    self.colorDisplay.backgroundColor = [self currentColor];
    self.leftColorDisplay.backgroundColor = [self currentLeftColor];
    self.rightColorDisplay.backgroundColor = [self currentRightColor];
}

- (UIColor*)currentColor {
    return [UIColor colorWithRed:self.redAmount.value
                           green:self.greenAmount.value
                            blue:self.blueAmount.value
                           alpha:1.0f];
}

- (UIColor*)currentLeftColor {
    return [UIColor colorWithRed:self.redAmount.value - 0.2f
                           green:self.greenAmount.value - 0.2f
                            blue:self.blueAmount.value - 0.2f
                           alpha:1.0f];
}

- (UIColor*)currentRightColor {
    return [UIColor colorWithRed:self.redAmount.value + 0.2f
                           green:self.greenAmount.value + 0.2f
                            blue:self.blueAmount.value + 0.2f
                           alpha:1.0f];
}

- (void)refreshRandomColor{
    self.redColor = arc4random_uniform(1000) / 1000.0f;
    self.greenColor = arc4random_uniform(1000) / 1000.0f;
    self.blueColor = arc4random_uniform(1000) / 1000.0f;
    
    self.randomColorDisplay.backgroundColor = [UIColor colorWithRed:self.redColor green:self.greenColor blue:self.blueColor alpha:1.0f];
}

- (Boolean)isColorSimilar{
    int sum = 0;
    
    switch (self.gamesWon) {
        case 0:
            self.difficulty = 0.1f;
            break;
        case 1:
            self.difficulty = 0.01f;
            break;
        case 2:
            self.difficulty = 0.001f;
            break;
        case 3:
            self.difficulty = 0.0001f;
            break;
        case 4:
            self.difficulty = 0.00001f;
            break;
        case 5:
            self.difficulty = 0.000001f;
            break;
        default:
            self.difficulty = 0.1f;
            break;
    }
    
    if (self.redAmount.value > (self.redColor - self.difficulty) && self.redAmount.value < (self.redColor + self.difficulty)){
        sum++;
    }
    if (self.greenAmount.value > (self.greenColor - self.difficulty) || self.greenAmount.value < (self.greenColor + self.difficulty)){
        sum++;
    }
    if (self.blueAmount.value > (self.blueColor - self.difficulty) || self.blueAmount.value < (self.blueColor + self.difficulty)){
        sum++;
    }
    if (sum == 3){
        self.gamesWon++;
        return true;
    }
    else{
        return false;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
