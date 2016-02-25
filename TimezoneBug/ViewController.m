//
//  ViewController.m
//  TimezoneBug
//
//  Created by Xuan on 2/25/16.
//  Copyright © 2016 Wingzero. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)applyCalendarToCurrentTimeZone:(NSCalendar *)calendar {
    if (![calendar.timeZone isEqualToTimeZone:[NSTimeZone localTimeZone]]) {
        calendar.timeZone = [NSTimeZone localTimeZone];
    }
}

-(NSDateComponents *)getDateComponentsFromDate:(NSDate *)date {
    NSDateComponents *components;
    static NSCalendar *ISO8601 = nil;
    static NSCalendarUnit unit;
    if (!ISO8601) {
        ISO8601 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
        ISO8601.firstWeekday = 2; // Sunday = 1, Saturday = 7
        ISO8601.minimumDaysInFirstWeek = 7;
        unit = NSCalendarUnitYear|NSCalendarUnitYearForWeekOfYear|NSCalendarUnitQuarter|NSCalendarUnitWeekOfYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    }
    
    [self applyCalendarToCurrentTimeZone:ISO8601];
    
    components = [ISO8601 components:unit fromDate:date];
    return components;
}

- (IBAction)updateLabel:(id)sender {
    NSDate *currentDate = [NSDate date];
    NSDateComponents *components = [self getDateComponentsFromDate:currentDate];
    NSString *text = [NSString stringWithFormat:@"Day:%ld", components.day];
    self.textLabel.text = text;
}

@end
