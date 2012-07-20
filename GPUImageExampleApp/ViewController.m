//
//  ViewController.m
//  GPUImageExampleApp
//
//  Created by Riley Testut on 7/20/12.
//  Copyright (c) 2012 Riley Testut. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage.h"

@interface ViewController ()

@property (strong, nonatomic) GPUImageView *filteredVideoView;
@property (strong, nonatomic) GPUImageFilter *filter;
@property (strong, nonatomic) GPUImageVideoCamera *videoCamera;

@end

//change this to see the exact opposite effect
static BOOL imageViewIsSmall = NO;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionBack];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    self.filter = [[GPUImageSepiaFilter alloc] init];
    self.filteredVideoView = [[GPUImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    if (imageViewIsSmall) {
        self.filteredVideoView.frame = CGRectMake(0.0, 0.0, 160, 240);
    }
    
    self.filteredVideoView.tag = 10;
    [self.filteredVideoView setFillMode:kGPUImageFillModePreserveAspectRatio];
    [self.filteredVideoView setBackgroundColorRed:1.0 green:0 blue:0 alpha:1.0];
    [self.view insertSubview:self.filteredVideoView atIndex:0];
    
    if (imageViewIsSmall) {
        [self.filter forceProcessingAtSize:CGSizeMake(360, 640)];
    }
    else {
        [self.filter forceProcessingAtSize:CGSizeMake(720, 1280)];
    }
    
    // Add the view somewhere so it's visible
    
    [self.videoCamera addTarget:self.filter];
    [self.filter addTarget:self.filteredVideoView];
    
    [self.videoCamera startCameraCapture];
    
}

- (IBAction)changeImageViewSize:(id)sender {
    
    if (!imageViewIsSmall) {
        self.filteredVideoView.frame = CGRectMake(0, 0, 160, 240);
        [self.filter forceProcessingAtSize:CGSizeMake(360, 640)];
        imageViewIsSmall = YES;
    }
    else {
        [self.filter forceProcessingAtSize:CGSizeMake(720, 1280)];
        self.filteredVideoView.frame = CGRectMake(0, 0, 320, 480);
        imageViewIsSmall = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
