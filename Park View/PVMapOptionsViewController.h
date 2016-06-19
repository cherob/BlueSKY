#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PVMapOption ) {
    PVMapBoundary = 0,
    PVMapOverlay,
    PVMapPins,
    PVMapCharacterLocation,
    PVMapRoute
};

@interface PVMapOptionsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *selectedOptions;

@end
