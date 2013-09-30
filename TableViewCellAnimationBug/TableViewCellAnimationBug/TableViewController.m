/**
 TableViewController.m
 TableViewCellAnimationBug

 Created by Joachim Schuster on 29.09.13.
    Copyright (c) 2013 catchingtales. All rights reserved.
 */

#import "TableViewController.h"

@interface TableViewController ()

@property (nonatomic, strong) NSMutableArray* cellTitles;
@end

@implementation TableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.cellTitles = [NSMutableArray array];
  [self.cellTitles addObject:@"first"];
  [self.cellTitles addObject:@"second"];
  [self.cellTitles addObject:@"third"];

  self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
  return [_cellTitles count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
  static NSString* CellIdentifier = @"Cell";
  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  cell.textLabel.text = [_cellTitles objectAtIndex:[indexPath row]];
  return cell;
}

- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath {
  return YES;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [self.cellTitles removeObjectAtIndex:[indexPath row]];
    
    /*
     Deleting the row animated will cause the memory leak.
     Comment the deleteRowsAtIndexPaths line and uncomment the reloadData line to show that the 
      deletion without animation is not affected.
     */
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
//    [tableView reloadData];
  }
}

@end
