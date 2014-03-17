//
//  ViewController.m
//  DoIt
//
//  Created by Charles Northup on 3/17/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>
{
    IBOutlet UITableView *myTableView;
    NSMutableArray *items;
    IBOutlet UITextField *myTextField;
    UITableViewCell *cell;
    BOOL isEditModeEnabled;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    items = [[NSMutableArray alloc] initWithObjects:@"One", @"Two", @"Three", nil];
    BOOL isEditModeEnabled = NO;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [items count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    cell = [tableView dequeueReusableCellWithIdentifier:@"myReusedIdentifier"];
    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *completedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (isEditModeEnabled)
    {
        [items removeObjectAtIndex:indexPath.row];
        [myTableView reloadData];
        
    }
    else
    {
    completedCell.textLabel.textColor = [UIColor greenColor];
    }
}

//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)//indexPath{
 //   return isEditModeEnabled;
//}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [items removeObjectAtIndex:indexPath.row];
        [myTableView reloadData];
    }
}


- (IBAction)onAddButtonPressed:(id)sender {
    [items addObject:myTextField.text];
    [myTableView reloadData];
    myTextField.text = nil;
    [myTextField resignFirstResponder];
}
- (IBAction)onEditButtonPressed:(UIButton*)sender
{
    [sender setTitle:@"Done" forState:(isEditModeEnabled==YES)];
    [sender setTitle:@"Edit" forState:(isEditModeEnabled==NO)];
    isEditModeEnabled =! isEditModeEnabled;

    
}
- (IBAction)setPriority:(UISwipeGestureRecognizer *)sender
{
   
}


@end
