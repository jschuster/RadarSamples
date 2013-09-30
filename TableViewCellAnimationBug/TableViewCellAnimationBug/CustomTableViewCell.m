/**
 CustomTableViewCell.m
 TableViewCellAnimationBug

 Created by Joachim Schuster on 30.09.13.
    Copyright (c) 2013 catchingtales. All rights reserved.
 */

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

/*
 Set a Breakpoint in the dealloc method. Run the App in iOS 7.0 environment.
 - tap "Show me the TableView" button and navigate back directly.
    -> dealloc will be called.
 - tab "Show me the TableView" button
    - delete a cell (swipe or edit) -> deletion of the cell is animated. See TableViewController:tableView:commitEditingStyle:forRowAtIndexPath:
    - navigate back
    -> dealloc will not be called.
        CustomTableView will not be released either.
 
 Run the App in iOS 6.x environment will release all objects as expected, no memory leak.
 */
- (void)dealloc {
  
}

@end
