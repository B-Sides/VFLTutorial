//
//  BDFirstViewController.m
//  VFLTutorial
//
//  Created by David Pettigrew on 5/13/14.
//  Copyright (c) 2014 Burnside Digital. All rights reserved.
//

#import "BDFirstViewController.h"

@interface BDFirstViewController ()

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UISlider *heightSlider;
@property (nonatomic, strong) UISlider *sideSpaceSlider;
@property (nonatomic, strong) UISlider *bottomSpaceSlider;
@property (nonatomic, strong) NSMutableDictionary *labelMetrics;
@property (nonatomic, strong) NSArray *labelConstraints;

@end

@implementation BDFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Our knobs
    [self addLabelHeightSlider];
    [self addSideSpaceSlider];
    [self addBottomSpaceSlider];
    [self addStaticLabel];
    
    // The label we will control
    self.label1 = [[UILabel alloc] init];
    self.label1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.label1];
    self.label1.text = @"Hello from VFL. Hello from VFL. Hello from VFL. Hello from VFL. Hello from VFL. Hello from VFL. Hello from VFL. Hello from VFL.";
    self.label1.numberOfLines = 0;
    self.label1.textColor = [UIColor blackColor];
    self.label1.backgroundColor = [UIColor grayColor];
    
    // The metrics that will define the label's constraints and we will adjust with our knobs
    self.labelMetrics = [NSMutableDictionary dictionaryWithDictionary:@{
                              @"height" : @50.0,
                              @"sideSpace" : @20.0,
                              @"topSpace" : @20.0,
                              @"bottomSpace" : @100.0
                              }];
    
    [self configureLayout:self.labelMetrics];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 
- (void)addLabelHeightSlider {
    self.heightSlider = [UISlider new];
    self.heightSlider.translatesAutoresizingMaskIntoConstraints = NO;
    self.heightSlider.maximumValue = 200.0;
    self.heightSlider.value = 50.0;
    [self.heightSlider addTarget:self action:@selector(sliderDidChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.heightSlider];

    NSDictionary* viewDict = NSDictionaryOfVariableBindings(_heightSlider);
    NSDictionary *sliderMetrics = @{
                                   @"height" : @30.0,
                                   @"sideSpace" : @20.0,
                                   @"topSpace" : @20.0,
                                   };
    
    // Standard space to sides of superview
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_heightSlider]-|" options:0 metrics:sliderMetrics views:viewDict]];
    
    // Space to top of superview
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topSpace-[_heightSlider]" options:0 metrics:sliderMetrics views:viewDict]];
    
    // Height constraint
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_heightSlider(height)]" options:0 metrics:sliderMetrics views:viewDict]];
    
}

- (void)addSideSpaceSlider {
    self.sideSpaceSlider = [UISlider new];
    self.sideSpaceSlider.translatesAutoresizingMaskIntoConstraints = NO;
    self.sideSpaceSlider.maximumValue = 200.0;
    self.sideSpaceSlider.value = 20.0;
    [self.sideSpaceSlider addTarget:self action:@selector(sliderDidChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.sideSpaceSlider];
    
    NSDictionary* viewDict = NSDictionaryOfVariableBindings(_sideSpaceSlider, _heightSlider);
    NSDictionary *sliderMetrics = @{
                                    @"height" : @30.0,
                                    @"sideSpace" : @20.0,
                                    @"betweenSpace" : @20.0,
                                    };
    
    // Standard space to sides of superview
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_sideSpaceSlider]-|" options:0 metrics:sliderMetrics views:viewDict]];
    
    // Space between heightSlider and sideSpaceSlider
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_heightSlider]-betweenSpace-[_sideSpaceSlider]" options:0 metrics:sliderMetrics views:viewDict]];
    
    // Height constraint
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_sideSpaceSlider(height)]" options:0 metrics:sliderMetrics views:viewDict]];
}

- (void)addBottomSpaceSlider {
    self.bottomSpaceSlider = [UISlider new];
    self.bottomSpaceSlider.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomSpaceSlider.minimumValue = 50.0;
    self.bottomSpaceSlider.maximumValue = 200.0;
    self.bottomSpaceSlider.value = 100.0;
    [self.bottomSpaceSlider addTarget:self action:@selector(sliderDidChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.bottomSpaceSlider];
    
    NSDictionary* viewDict = NSDictionaryOfVariableBindings(_bottomSpaceSlider, _sideSpaceSlider);
    NSDictionary *sliderMetrics = @{
                                    @"height" : @30.0,
                                    @"sideSpace" : @20.0,
                                    @"betweenSpace" : @20.0,
                                    };
    
    // Standard space to sides of superview
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_bottomSpaceSlider]-|" options:0 metrics:sliderMetrics views:viewDict]];
    
    // Space between sideSpaceSlider and bottomSpaceSlider
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_sideSpaceSlider]-betweenSpace-[_bottomSpaceSlider]" options:0 metrics:sliderMetrics views:viewDict]];
    
    // Height constraint
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomSpaceSlider(height)]" options:0 metrics:sliderMetrics views:viewDict]];
}

- (void)addStaticLabel {
    self.label2 = [[UILabel alloc] init];
    self.label2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.label1];
    self.label2.text = @"I am a fixed label";
    self.label2.numberOfLines = 1;
    self.label2.textColor = [UIColor blackColor];
    self.label2.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.label2];
    
    NSDictionary* viewDict = NSDictionaryOfVariableBindings(_bottomSpaceSlider, _label2);
    NSDictionary *sliderMetrics = @{
                                    @"height" : @30.0,
                                    @"sideSpace" : @20.0,
                                    @"betweenSpace" : @20.0,
                                    };
    
    // Standard space to sides of superview
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_label2]-|" options:0 metrics:sliderMetrics views:viewDict]];
    
    // Space between _label2 and bottomSpaceSlider
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomSpaceSlider]-betweenSpace-[_label2]" options:0 metrics:sliderMetrics views:viewDict]];
    
    // Height constraint
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_label2(30)]" options:0 metrics:sliderMetrics views:viewDict]];
}

#pragma mark Actions
- (IBAction)sliderDidChange:(id)sender {
    if ([sender isEqual:self.heightSlider]) {
        self.labelMetrics[@"height"] = @(self.heightSlider.value);
    }
    else if ([sender isEqual:self.sideSpaceSlider]) {
        self.labelMetrics[@"sideSpace"] = @(self.sideSpaceSlider.value);
    }
    else if ([sender isEqual:self.bottomSpaceSlider]) {
        self.labelMetrics[@"bottomSpace"] = @(self.bottomSpaceSlider.value);
    }
    [self configureLayout:self.labelMetrics];
}

#pragma mark
- (void)configureLayout:(NSDictionary *)metrics {
    if ([self.labelConstraints isKindOfClass:[NSArray class]]) {
        [self.view removeConstraints:self.labelConstraints];
    }
    NSLog(@"metrics: %@ ", metrics);
    
    NSDictionary* viewDict = NSDictionaryOfVariableBindings(_label1, _label2);
    
    // Connection to sides of superview
    self.labelConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-sideSpace-[_label1]-sideSpace-|" options:0 metrics:metrics views:viewDict];
    
    // Connection to bottom of superview
    self.labelConstraints = [self.labelConstraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_label1]-bottomSpace-|" options:0 metrics:metrics views:viewDict]];
    
    // Height constraints
    self.labelConstraints = [self.labelConstraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_label1(>=_label2@1000,height@999)]" options:0 metrics:metrics views:viewDict]];

    // Width constraints
    self.labelConstraints = [self.labelConstraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_label1(>=50)]" options:0 metrics:metrics views:viewDict]];

    [self.view addConstraints:self.labelConstraints];
}

@end
