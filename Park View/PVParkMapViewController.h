#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface PVParkMapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *mapTypeSegmentedControl;
- (IBAction)menuDown:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIImageView *titleIcon;

@property (weak, nonatomic) IBOutlet UIView *weView;
@property (weak, nonatomic) IBOutlet UILabel *weLabel;
@property (weak, nonatomic) IBOutlet UILabel *name1;
@property (weak, nonatomic) IBOutlet UILabel *name2;
@property (weak, nonatomic) IBOutlet UILabel *name3;
@property (weak, nonatomic) IBOutlet UILabel *name4;

@property (weak, nonatomic) IBOutlet UIView *menu;
- (IBAction)menuDown:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UIButton *stationButton;
@property (weak, nonatomic) IBOutlet UIButton *weButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *weiterButton;
@property (weak, nonatomic) IBOutlet UIButton *positionButton;
@property (weak, nonatomic) IBOutlet UIButton *statusButton;

- (IBAction)statusDown:(id)sender;

- (IBAction)mapTypeChanged:(id)sender;
- (IBAction)weiterDown:(id)sender;
- (IBAction)positionDown:(id)sender;
- (IBAction)weDown:(id)sender;
- (IBAction)stationDown:(id)sender;
- (IBAction)mapDown:(id)sender;

@end
