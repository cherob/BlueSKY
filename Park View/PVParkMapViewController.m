#import "PVParkMapViewController.h"
#import "PVMapOptionsViewController.h"
#import "PVPark.h"
#import "PVParkMapOverlayView.h"
#import "PVParkMapOverlay.h"
#import "PVAttractionAnnotation.h"
#import "PVAttractionAnnotationView.h"
#import "PVCharacter.h"
#import <QuartzCore/QuartzCore.h>

UIView *menuBox;
int menuIs = 0;
int status = 0;

@interface PVParkMapViewController ()

@property (nonatomic, strong) PVPark *park;
@property (nonatomic, strong) NSMutableArray *selectedOptions;

@end

@implementation PVParkMapViewController
@synthesize menuButton, mapButton, stationButton, weButton, descLabel, iconImage, weiterButton, positionButton, statusButton, navBar, titleIcon, weView, name1, name2, name3, name4, weLabel;

- (void)viewDidLoad
{
    navBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 55);
    [self.view addSubview:navBar];
    
    titleIcon.frame = CGRectMake(32, 5, 300, 58);
    
    [self.view addSubview:titleIcon];
    
    CGRect rect = CGRectMake(0, 0, 150, 30);
    UIGraphicsBeginImageContext( rect.size );
    [titleIcon.image drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    titleIcon.image = picture1;
    titleIcon.frame = CGRectMake((self.view.frame.size.width/2)-(150/2), 10, 150, 30);

    
    NSData *imageData = UIImagePNGRepresentation(picture1);
    UIImage *img=[UIImage imageWithData:imageData];
    
    self.selectedOptions = [NSMutableArray array];
    self.park = [[PVPark alloc] initWithFilename:@"CoordSize"];
    
    weiterButton.layer.cornerRadius = 8;
    weiterButton.clipsToBounds = YES;

    [self.view addSubview:iconImage];
    
    weView.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44);
    weView.hidden = YES;
    
    [self.view insertSubview:weView aboveSubview:self.mapView];
    name4.hidden = YES;
    [self.view addSubview:name4];
    name3.hidden = YES;
    [self.view addSubview:name3];
    name2.hidden = YES;
    [self.view addSubview:name2];
    name1.hidden = YES;
    [self.view addSubview:name1];
    weLabel.hidden = YES;
    [self.view addSubview:weLabel];
    
    CLLocationDegrees latDelta = self.park.overlayTopLeftCoordinate.latitude - self.park.overlayBottomRightCoordinate.latitude;
    
    CLLocationCoordinate2D noLocation;
    noLocation.latitude = 51.025904;
    noLocation.longitude = 13.723427;

    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 1700, 1700);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion animated:YES];
    self.mapView.showsUserLocation = YES;
    
    menuBox = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 0, self.view.frame.size.height)];
    menuBox.backgroundColor = [UIColor darkGrayColor];
    menuBox.alpha = 0.9;
    [self.view insertSubview:menuBox aboveSubview:self.weView];
    menuButton.hidden = NO;
    
    menuButton.frame = CGRectMake(10, 8, 30, 30);
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"]forState:UIControlStateNormal];
    [self.view addSubview:menuButton];
    menuButton.hidden = NO;
    
    mapButton.frame = CGRectMake(-150, 0, 150, 35);
    [mapButton setBackgroundImage:[UIImage imageNamed:@"mapButton.png"]forState:UIControlStateNormal];
    [menuBox addSubview:mapButton];
    mapButton.hidden = NO;
    
    statusButton.frame = CGRectMake(-150, 34, 150, 35);
    [statusButton setBackgroundImage:[UIImage imageNamed:@"statusButton.png"]forState:UIControlStateNormal];
    [menuBox addSubview:statusButton];
    statusButton.hidden = NO;

    stationButton.frame = CGRectMake(-150, 68, 150, 35);
    [stationButton setBackgroundImage:[UIImage imageNamed:@"stationButton.png"]forState:UIControlStateNormal];
    [menuBox addSubview:stationButton];
    stationButton.hidden = NO;
    
    weButton.frame = CGRectMake(-150, 102, 150, 35);
    [weButton setBackgroundImage:[UIImage imageNamed:@"weButton.png"]forState:UIControlStateNormal];
    [menuBox addSubview:weButton];
    weButton.hidden = NO;
    
    positionButton.frame = CGRectMake(self.view.frame.size.width-10-40, self.view.frame.size.height-10-40, 40, 40);
    [positionButton setBackgroundImage:[UIImage imageNamed:@"positionButton.png"]forState:UIControlStateNormal];
    [self.view addSubview:positionButton];
    positionButton.hidden = YES;

    [self addOverlay];
    
    [NSTimer scheduledTimerWithTimeInterval:5
                                     target:self
                                   selector:@selector(updateData)
                                   userInfo:nil
                                    repeats:YES];
    mapButton.hidden = NO;
    stationButton.hidden = NO;
    weButton.hidden = NO;
    
    [super viewDidLoad];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    if(location.y>44&&location.x>150&&menuIs==1){
        [UIView animateWithDuration:0.150 animations:^{
            [menuButton setTransform:CGAffineTransformRotate(menuButton.transform, M_PI*2)];
            menuBox.frame = CGRectMake(-150, 44, 150, self.view.frame.size.height);
            mapButton.frame = CGRectMake(-150, 0, 150, 35);
            statusButton.frame = CGRectMake(-150, 34, 150, 35);
            stationButton.frame = CGRectMake(-150, 68, 150, 35);
            weButton.frame = CGRectMake(-150, 102, 150, 35);
            [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"]forState:UIControlStateNormal];
        }];
        menuIs = 0;
    }
}

-(void)updateData{
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
    [self addOverlay];
    NSLog(@"Update1");
}

#pragma mark - Add methods

- (void)addOverlay {
    PVParkMapOverlay *overlay = [[PVParkMapOverlay alloc] initWithPark:self.park];
    [self.mapView addOverlay:overlay];
}

#pragma mark - Map View delegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:PVParkMapOverlay.class]) {
        NSURL *url = [NSURL URLWithString:
                      @"http://10.11.12.1/Hello_World.png"];
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
        PVParkMapOverlayView *overlayView = [[PVParkMapOverlayView alloc] initWithOverlay:overlay overlayImage:image];
        NSLog(@"Update2");
        return overlayView;
    } else if ([overlay isKindOfClass:MKPolyline.class]) {
        MKPolylineRenderer *lineView = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        lineView.strokeColor = [UIColor greenColor];
        
        return lineView;
    } else if ([overlay isKindOfClass:MKPolygon.class]) {
        MKPolygonRenderer *polygonView = [[MKPolygonRenderer alloc] initWithOverlay:overlay];
        polygonView.strokeColor = [UIColor magentaColor];
        
        return polygonView;
    } else if ([overlay isKindOfClass:PVCharacter.class]) {
        MKCircleRenderer *circleView = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        circleView.strokeColor = [(PVCharacter *)overlay color];
        
        return circleView;
    }
    
    return nil;
}



#pragma mark - Helper methods

- (void)loadSelectedOptions {
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
    for (NSNumber *option in self.selectedOptions) {
        switch ([option integerValue]) {
            case PVMapOverlay:
                [self addOverlay];
                break;
            default:
                break;
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PVMapOptionsViewController *optionsViewController = segue.destinationViewController;
    optionsViewController.selectedOptions = self.selectedOptions;
}

- (IBAction)closeOptions:(UIStoryboardSegue *)exitSegue {
    PVMapOptionsViewController *optionsViewController = exitSegue.sourceViewController;
    self.selectedOptions = optionsViewController.selectedOptions;
    [self loadSelectedOptions];
}

- (IBAction)mapTypeChanged:(id)sender {
    switch (self.mapTypeSegmentedControl.selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        default:
            break;
    }
}

- (IBAction)weiterDown:(id)sender {
    menuButton.hidden = NO;
    weiterButton.hidden = YES;
    descLabel.hidden = YES;
    iconImage.hidden = YES;
    positionButton.hidden = NO;
}

- (IBAction)positionDown:(id)sender {

}

- (IBAction)weDown:(id)sender {
    status = 3;
    weView.hidden = NO;
    name1.hidden = NO;
    name2.hidden = NO;
    name3.hidden = NO;
    name4.hidden = NO;
    weLabel.hidden = NO;
    if(menuIs==1){
        [UIView animateWithDuration:0.150 animations:^{
            [menuButton setTransform:CGAffineTransformRotate(menuButton.transform, M_PI*2)];
            menuBox.frame = CGRectMake(-150, 44, 150, self.view.frame.size.height);
            mapButton.frame = CGRectMake(-150, 0, 150, 35);
            statusButton.frame = CGRectMake(-150, 34, 150, 35);
            stationButton.frame = CGRectMake(-150, 68, 150, 35);
            weButton.frame = CGRectMake(-150, 102, 150, 35);
            [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"]forState:UIControlStateNormal];
        }];
        menuIs = 0;
    }else{
        [UIView animateWithDuration:0.150 animations:^{
            [menuButton setTransform:CGAffineTransformRotate(menuButton.transform, M_PI*2)];
            menuBox.frame = CGRectMake(0, 44, 150, self.view.frame.size.height);
            mapButton.frame = CGRectMake(0, 0, 150, 35);
            statusButton.frame = CGRectMake(0, 34, 150, 35);
            stationButton.frame = CGRectMake(0, 68, 150, 35);
            weButton.frame = CGRectMake(0, 102, 150, 35);
            [menuButton setBackgroundImage:[UIImage imageNamed:@"arrow.png"]forState:UIControlStateNormal];
        }];
        menuIs = 1;
    }
}

- (IBAction)stationDown:(id)sender {
    status = 2;
    if(menuIs==1){
        [UIView animateWithDuration:0.150 animations:^{
            [menuButton setTransform:CGAffineTransformRotate(menuButton.transform, M_PI*2)];
            menuBox.frame = CGRectMake(-150, 44, 150, self.view.frame.size.height);
            mapButton.frame = CGRectMake(-150, 0, 150, 35);
            statusButton.frame = CGRectMake(-150, 34, 150, 35);
            stationButton.frame = CGRectMake(-150, 68, 150, 35);
            weButton.frame = CGRectMake(-150, 102, 150, 35);
            [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"]forState:UIControlStateNormal];
        }];
        menuIs = 0;
    }else{
        [UIView animateWithDuration:0.150 animations:^{
            [menuButton setTransform:CGAffineTransformRotate(menuButton.transform, M_PI*2)];
            menuBox.frame = CGRectMake(0, 44, 150, self.view.frame.size.height);
            mapButton.frame = CGRectMake(0, 0, 150, 35);
            statusButton.frame = CGRectMake(0, 34, 150, 35);
            stationButton.frame = CGRectMake(0, 68, 150, 35);
            weButton.frame = CGRectMake(0, 102, 150, 35);
            [menuButton setBackgroundImage:[UIImage imageNamed:@"arrow.png"]forState:UIControlStateNormal];
        }];
        menuIs = 1;
    }
}

- (IBAction)mapDown:(id)sender {
    status = 0;
    weView.hidden = YES;
    name1.hidden = YES;
    name2.hidden = YES;
    name3.hidden = YES;
    name4.hidden = YES;
    weLabel.hidden = YES;
    if(menuIs==1){
        [UIView animateWithDuration:0.150 animations:^{
            [menuButton setTransform:CGAffineTransformRotate(menuButton.transform, M_PI*2)];
            menuBox.frame = CGRectMake(-150, 44, 150, self.view.frame.size.height);
            mapButton.frame = CGRectMake(-150, 0, 150, 35);
            statusButton.frame = CGRectMake(-150, 34, 150, 35);
            stationButton.frame = CGRectMake(-150, 68, 150, 35);
            weButton.frame = CGRectMake(-150, 102, 150, 35);
            [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"]forState:UIControlStateNormal];
        }];
        menuIs = 0;
    }else{
        [UIView animateWithDuration:0.150 animations:^{
            [menuButton setTransform:CGAffineTransformRotate(menuButton.transform, M_PI*2)];
            menuBox.frame = CGRectMake(0, 44, 150, self.view.frame.size.height);
            mapButton.frame = CGRectMake(0, 0, 150, 35);
            statusButton.frame = CGRectMake(0, 34, 150, 35);
            stationButton.frame = CGRectMake(0, 68, 150, 35);
            weButton.frame = CGRectMake(0, 102, 150, 35);
            [menuButton setBackgroundImage:[UIImage imageNamed:@"arrow.png"]forState:UIControlStateNormal];
        }];
        menuIs = 1;
    }
}

- (IBAction)menuDown:(id)sender {
    if(menuIs==1){
        [UIView animateWithDuration:0.150 animations:^{
            [menuButton setTransform:CGAffineTransformRotate(menuButton.transform, M_PI*2)];
            menuBox.frame = CGRectMake(-150, 44, 150, self.view.frame.size.height);
            mapButton.frame = CGRectMake(-150, 0, 150, 35);
            statusButton.frame = CGRectMake(-150, 34, 150, 35);
            stationButton.frame = CGRectMake(-150, 68, 150, 35);
            weButton.frame = CGRectMake(-150, 102, 150, 35);
            [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"]forState:UIControlStateNormal];
        }];
        menuIs = 0;
    }else{
        [UIView animateWithDuration:0.150 animations:^{
            [menuButton setTransform:CGAffineTransformRotate(menuButton.transform, M_PI*2)];
            menuBox.frame = CGRectMake(0, 44, 150, self.view.frame.size.height);
            mapButton.frame = CGRectMake(0, 0, 150, 35);
            statusButton.frame = CGRectMake(0, 34, 150, 35);
            stationButton.frame = CGRectMake(0, 68, 150, 35);
            weButton.frame = CGRectMake(0, 102, 150, 35);
            [menuButton setBackgroundImage:[UIImage imageNamed:@"arrow.png"]forState:UIControlStateNormal];
        }];
        menuIs = 1;
    }
}

- (IBAction)statusDown:(id)sender {
    status = 1;
    NSURL *url = [NSURL URLWithString:@"http://10.11.12.1/abfrage.php?lat=51.045904&lon=13.710027"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"ret=%@", ret);
    if(menuIs==1){
        [UIView animateWithDuration:0.150 animations:^{
            [menuButton setTransform:CGAffineTransformRotate(menuButton.transform, M_PI*2)];
            menuBox.frame = CGRectMake(-150, 44, 150, self.view.frame.size.height);
            mapButton.frame = CGRectMake(-150, 0, 150, 35);
            statusButton.frame = CGRectMake(-150, 34, 150, 35);
            stationButton.frame = CGRectMake(-150, 68, 150, 35);
            weButton.frame = CGRectMake(-150, 102, 150, 35);
            [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"]forState:UIControlStateNormal];
        }];
        menuIs = 0;
    }else{
        [UIView animateWithDuration:0.150 animations:^{
            [menuButton setTransform:CGAffineTransformRotate(menuButton.transform, M_PI*2)];
            menuBox.frame = CGRectMake(0, 44, 150, self.view.frame.size.height);
            mapButton.frame = CGRectMake(0, 0, 150, 35);
            statusButton.frame = CGRectMake(0, 34, 150, 35);
            stationButton.frame = CGRectMake(0, 68, 150, 35);
            weButton.frame = CGRectMake(0, 102, 150, 35);
            [menuButton setBackgroundImage:[UIImage imageNamed:@"arrow.png"]forState:UIControlStateNormal];
        }];
        menuIs = 1;
    }
   if([ret isEqual:@"1"]){
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Gute Luft" message:@"Heute ist die Luftqualität wirklich sehr gut. Sie verdient es nicht beschmutzt zu werden. Schwing dich auf dein Rad!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:@"Ok"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action){
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    }
    if([ret isEqual:@"2"]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Normale Luft" message:@"Ein normaler Tag für ein bodenständiges Verkehrsmittel. Also rauf auf's Fahrrad." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction
                                 actionWithTitle:@"Ok"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action){
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                 }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    if([ret isEqual:@"3"]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Achtung" message:@"Heute ist die Luftqualität wirklich sehr schlecht. Vielleicht solltest du mal das Fahrrad nehmen." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction
                                 actionWithTitle:@"Ok"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action){
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                 }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
@end
