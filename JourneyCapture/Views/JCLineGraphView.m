//
//  JCLineGraphView.m
//  JourneyCapture
//
//  Created by Chris Sloey on 19/05/2014.
//  Copyright (c) 2014 FCD. All rights reserved.
//

#import "JCLineGraphView.h"
#import "JCStatViewModel.h"

@implementation JCLineGraphView

- (id)initWithViewModel:(JCStatViewModel *)statsViewModel
{
    self = [super initWithViewModel:statsViewModel];
    if (self) {
        JBLineChartView *lineChartView = [JBLineChartView new];
        lineChartView.delegate = self;
        lineChartView.dataSource = self;
        lineChartView.translatesAutoresizingMaskIntoConstraints = NO;
        lineChartView.frame = CGRectMake(0, 0, 0, 0);
        lineChartView.minimumValue = 0;
        lineChartView.showsLineSelection = NO;
        lineChartView.showsVerticalSelection = NO;
        [self.graphView removeFromSuperview];
        self.graphView = lineChartView;
        [self addSubview:self.graphView];
    }
    return self;
}

#pragma mark - JBLineChartViewDataSource

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView
{
    return 1;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
    return [self.viewModel countOfStats];
}

#pragma mark - JBLineChartViewDelegate

-(CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex
            atLineIndex:(NSUInteger)lineIndex
{
    return [self.viewModel statValueAtIndex:horizontalIndex];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex
{
    return [UIColor jc_blueColor];
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex
{
    return 4.0f;
}

-(BOOL)lineChartView:(JBLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex
{
    return YES;
}

@end
