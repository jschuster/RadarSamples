/**
 CustomTableView.m
 TableViewCellAnimationBug

 Created by Joachim Schuster on 30.09.13.
    Copyright (c) 2013 catchingtales. All rights reserved.
 */

#import "CustomTableView.h"

@implementation CustomTableView

/*
 Set a Breakpoint in the dealloc method. Run the App.
 - tap "Show me the TableView" button and navigate back directly. 
    -> dealloc will be called.
 - tab "Show me the TableView" button
    - delete a cell (swipe or edit) -> deletion of the cell is animated. See TableViewController:tableView:commitEditingStyle:forRowAtIndexPath:
    - navigate back
    -> dealloc will not be called.
       CustomTableViewCells will not be released either.
 */
- (void)dealloc {
  
}

@end
