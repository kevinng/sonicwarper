//
//  SettingsViewController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 30/10/16.
//  Copyright © 2016 Sonicwarper. All rights reserved.
//

@import CoreAudioKit;
#import "SettingsViewController.h"
#import "Settings.h"
#import "MIDIEngine.h"
#import "Mappings.h"
#import "SVProgressHUD.h"
#import "MBProgressHUD.h"
#import "MotionEngine.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *editMode;
@property (weak, nonatomic) IBOutlet UISegmentedControl *pages;

@end

@implementation SettingsViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  Settings *settings = [Settings shared];
  self.editModeIsOn = settings.editModeIsOn;
  
  self.pages.selectedSegmentIndex = [Mappings shared].currentPage;
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  
  // Connect to all sources/destinations on all devices.
  MIDIEngine *engine = [MIDIEngine shared];
  [engine connectAll];
}

#pragma mark - Getters/setters

- (void)setEditModeIsOn:(BOOL)editModeIsOn {
  _editModeIsOn = editModeIsOn;
  [self.editMode setOn:editModeIsOn];
}

#pragma mark - Action methods

- (IBAction)done:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)editModeIsChanged:(id)sender {
  Settings *settings = [Settings shared];
  settings.editModeIsOn = [(UISwitch *)sender isOn];
  [self.parentVC showEditMode:settings.editModeIsOn];
}

- (IBAction)pageDidChanged:(id)sender {
  [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
  [SVProgressHUD show];
  
  [Mappings shared].currentPage = ((UISegmentedControl *)sender).selectedSegmentIndex;
  
  dispatch_async(dispatch_get_main_queue(), ^{
    
    // Refresh button behaviors.
    [[ButtonBehaviors shared] refreshBehaviors];
    
    // Refresh bowswitch look.
    [((ViewController *)[UIApplication sharedApplication].keyWindow.rootViewController) refreshLooks];
    
    [SVProgressHUD dismiss];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
  });
}

#pragma mark - TableViewController methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0 && indexPath.row == 0) {
    // "Connect via Bluetooth LE" - segue bluetooth view controller.
    CABTMIDILocalPeripheralViewController *viewController = [[CABTMIDILocalPeripheralViewController alloc] init];
    [self.navigationController pushViewController: viewController animated:YES];
  } else if (indexPath.section == 2 && indexPath.row == 1) {
    // "Override Current Page with Sample Mapping".
    
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Warning"
                                message:@"You are about to override the current page with a sample mapping. You will lose all settings on this page."
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Proceed"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * _Nonnull action) {
                                                   [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                                                   [SVProgressHUD show];
                                                   
                                                   NSInteger currentPage = [Mappings shared].currentPage;
                                                   [[Mappings shared] overrideWithSampleMappingOnPage:currentPage];
                                                   
                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                       
                                                       // Refresh button behaviors.
                                                       [[ButtonBehaviors shared] refreshBehaviors];
                                                       
                                                       // Refresh bowswitch look.
                                                       [((ViewController *)[UIApplication sharedApplication].keyWindow.rootViewController) refreshLooks];
                                                       
                                                       [SVProgressHUD dismiss];
                                                       [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                                   });
                                               }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    [self.tableView reloadData];
  } else if (indexPath.section == 3 && indexPath.row == 0) {
    // "Reset Motion Sensors".
    [SVProgressHUD show];
    [[MotionEngine shared] reset];
    [self.tableView reloadData];
    [SVProgressHUD dismiss];
  }
}

@end
