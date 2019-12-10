//
//  ViewController.m
//  DistanceApp
//
//  Created by Nursultan on 11.12.2019.
//  Copyright © 2019 Nursultan Askarbekuly. All rights reserved.
//

#import "DistanceController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface DistanceController ()

@property (nonatomic) DGDistanceRequest *distanceReq;

@property (weak, nonatomic) IBOutlet UITextField *startLocationTextField;

@property (weak, nonatomic) IBOutlet UITextField *firstDestinationTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondDestinationTextField;
@property (weak, nonatomic) IBOutlet UITextField *thirdDestinationTextField;

@property (weak, nonatomic) IBOutlet UILabel *firstDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdDistanceLabel;

@property (weak, nonatomic) IBOutlet UIButton *calculateDistanceButton;

@end

@implementation DistanceController

- (IBAction)calculateDistanceButtonPressed:(id)sender {
    
    self.calculateDistanceButton.enabled = NO;
    
    NSString *startLocation = self.startLocationTextField.text;
    
    NSString *firstDestination = self.firstDestinationTextField.text;
    NSString *secondDestination = self.secondDestinationTextField.text;
    NSString *thirdDestination = self.thirdDestinationTextField.text;
    NSArray *destinations = @[firstDestination,secondDestination,thirdDestination];
    
    self.distanceReq = [[DGDistanceRequest alloc] initWithLocationDescriptions:destinations sourceDescription:startLocation];
    
    __weak DistanceController *weakSelf = self;
    
    self.distanceReq.callback = ^(NSArray *distances) {
        DistanceController *strongSelf = weakSelf;
        if (!strongSelf) return;
        
        if (distances.count > 2
            && distances[0] != NULL
            && distances[1] != NULL
            && distances[2] != NULL) {
            
            NSString *firstDistance = [NSString stringWithFormat:@"%.2f km", ([distances[0] floatValue]/1000.0)];
            strongSelf.firstDistanceLabel.text = firstDistance;
            
            NSString *secondDistance = [NSString stringWithFormat:@"%.2f km", ([distances[1] floatValue]/1000.0)];
            strongSelf.secondDistanceLabel.text = secondDistance;
            
            NSString *thirdDistance = [NSString stringWithFormat:@"%.2f km", ([distances[2] floatValue]/1000.0)];
            strongSelf.thirdDistanceLabel.text = thirdDistance;
        } else {
            strongSelf.firstDistanceLabel.text = @"Error,";
            strongSelf.secondDistanceLabel.text = @"please enter";
            strongSelf.thirdDistanceLabel.text = @"correct data";
        }
        
        strongSelf.distanceReq = nil;
        strongSelf.calculateDistanceButton.enabled = YES;
    };
    
    [self.distanceReq start];
    
}


@end
