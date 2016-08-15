//
//  ViewController.h
//  NguyenTam4
//
//  Created by Nguyen, Tam N. (UMSL-Student) on 7/27/16.
//  Copyright © 2016 Nguyen, Tam N. (UMSL-Student). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *myNameOutlet;
@property (weak, nonatomic) IBOutlet UIButton *myPlayButtonOutlet;

- (IBAction)myPlayButtonPressed:(id)sender;


@end

