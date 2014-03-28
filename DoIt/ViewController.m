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
    UISwipeGestureRecognizer *setPriority = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onswipe:)];
    setPriority.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:setPriority];
}

-(void)onswipe:(UIGestureRecognizer *)setPriority{
    CGPoint point = [setPriority locationInView:myTableView];
    NSIndexPath *indexPath = [myTableView indexPathForRowAtPoint:point];
    UITableViewCell *pCell = [myTableView cellForRowAtIndexPath:indexPath];
//    if ([pCell.backgroundColor isEqual:nil]) {
//        NSLog(@"d");
//        pCell.backgroundColor = [UIColor greenColor];
//    }
//    } else if (pCell.backgroundColor == [UIColor greenColor]) {
//        pCell.backgroundColor = [UIColor yellowColor];
//    } else if (pCell.backgroundColor == [UIColor yellowColor]) {
//        pCell.backgroundColor = [UIColor redColor];
//    }
    //pCell.backgroundColor = [UIColor redColor];
    
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


@end
