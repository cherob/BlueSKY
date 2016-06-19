#import "PVMapOptionsViewController.h"

@implementation PVMapOptionsViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionCell"];
    switch (indexPath.row) {
        case PVMapBoundary:
            cell.textLabel.text = @"Park Boundary";
            break;
        case PVMapOverlay:
            cell.textLabel.text = @"Map Overlay";
            break;
        case PVMapPins:
            cell.textLabel.text = @"Attraction Pins";
            break;
        case PVMapCharacterLocation:
            cell.textLabel.text = @"Character Location";
            break;
        case PVMapRoute:
            cell.textLabel.text = @"Route";
            break;
        default:
            break;
    }
    
    if ([self.selectedOptions containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.selectedOptions removeObject:[NSNumber numberWithInteger:indexPath.row]];
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.selectedOptions addObject:[NSNumber numberWithInteger:indexPath.row]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
