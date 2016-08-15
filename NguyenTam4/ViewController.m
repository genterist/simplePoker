//
//  ViewController.m
//  NguyenTam4
//
//  Created by Nguyen, Tam N. (UMSL-Student) on 7/27/16.
//  Copyright © 2016 Nguyen, Tam N. (UMSL-Student). All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    AppDelegate *myDelegate;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    myDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self.myPlayButtonOutlet.enabled = NO;

}


- (IBAction)myPlayButtonPressed:(id)sender {
}

- (BOOL) textFieldShouldReturn: (UITextField *) textField {
    if (textField == self.myNameOutlet) {
        myDelegate.myName = self.myNameOutlet.text;
        self.myPlayButtonOutlet.enabled = YES;
        [textField resignFirstResponder];
    }

    return YES;
}
@end
