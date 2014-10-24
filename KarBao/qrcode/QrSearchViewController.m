//
//  QrSearchViewController.m
//  qrcode
//
//  Created by Caland on 14-10-16.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import "QrSearchViewController.h"
#import "QRUtil.h"


@interface QrSearchViewController ()

//Device
@property (nonatomic, retain) AVCaptureDevice *device;
@property (nonatomic, retain) AVCaptureDeviceInput *input;
@property (nonatomic, retain) AVCaptureMetadataOutput *output;
@property (nonatomic, retain) AVCaptureSession *session;
@property (nonatomic, retain) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic, retain) UIImageView *line;


@property (nonatomic, retain) NSTimer *timer;


/*!
 定义导航栏左侧按钮
 */
@property(nonatomic, retain) UIBarButtonItem *leftBarItem;



//遮罩层
@property (nonatomic, retain) UIView *northView;
@property (nonatomic, retain) UIView *sourthView;
@property (nonatomic, retain) UIView *eastView;
@property (nonatomic, retain) UIView *westView;
@property (nonatomic, retain) UIImageView *centerView;
@property (nonatomic, retain) UILabel *messageLabel;

@property (nonatomic, retain) UIImageView *qrcodeView;
@property (nonatomic, retain) UIButton *resetQrCodeButton;


@end

@implementation QrSearchViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.cameraType = AVCaptureDevicePositionBack; //默认打开后置摄像头进行拍摄
        self.isStore = YES;
        self.infoDict = nil;
    }
    return self;
}

- (id) init
{
    if (self = [super init]) {
        self.cameraType = AVCaptureDevicePositionBack; //默认打开后置摄像头进行拍摄
        self.isStore = YES;
        self.infoDict = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //退回按钮
    if (self.navigationController) {
        self.title = @"二维码扫描";
        self.navigationItem.leftBarButtonItem = self.leftBarItem;
        //        _blackPicker.layer.cornerRadius = 51.0;
    }
    
    //修改view的contentInset
    self.view.contentMode = UIViewContentModeTop;
    
    num = 0;
    isDown = YES;
    if (!self.isStore) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(lineAnimanate) userInfo:nil repeats:YES];
    }
    
    
    [self addSubViews];
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.device = [self cameraWithPosition:self.cameraType];
    
    NSAssert(self.device!=nil, @"QRSearchViewController:Device shouldn't be nil.");
    
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    NSAssert(self.input != nil, @"QRSearchViewController:Input shouldn't be nil.");
    
    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    self.output.rectOfInterest = CGRectMake(0.1, 0.1, 0.8, 0.8);//设置取值的范围，就是扫描的范围。
    
    self.session = [[AVCaptureSession alloc] init];
 
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    
    
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    NSLog(@"self.view.frame:%@", NSStringFromCGRect(self.view.frame));
    
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
//    CGRect rect = CGRectMake(0, 0, 768, 1024);
//    _preview.frame = rect;
    _preview.frame = self.view.frame;
    
//    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
//        _preview.frame = CGRectMake(0, 0, 768, 960);
//    }else {
//        _preview.frame = CGRectMake(0, 0, 1024, 768);
//    }
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    [self.session startRunning];
    
    [self setOrigation:self.interfaceOrientation for:_preview.connection];
    
}
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.session stopRunning];
    [self.timer invalidate];
}



/**
 *  得到指定的Device
 */
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position )
            return device;
    return nil;
}


#pragma mark -private method
- (void) addSubViews{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    float goldRate = 0.618, heightRate = 0.429, widthRate = 0.572;
    float borderWidth = self.view.frame.size.width;
    float borderHeight = self.view.frame.size.height;
    
    float centerHeight = borderHeight * heightRate;
    float centerWidth = borderWidth * widthRate;
    
    
    float northHeight = borderHeight * (goldRate - heightRate);
    
    
    float eastOriX = 0;
    float eastOriY = northHeight;
    float eastHeight = centerHeight;
    float eastWidth = (borderWidth - centerWidth)/2;
    
    float westOriY = eastOriY;
    float westOriX = borderWidth - eastWidth;
    float westWidth = eastWidth;
    float westHeight = centerHeight;
    
    float sourthOriX = 0;
//    float sourthOriY = borderHeight * goldRate;
    float sourthOriY = northHeight + centerHeight;
    float sourthWidth = borderWidth;
    float sourthHeight = borderHeight - sourthOriY;
    
    
    //后置摄像头
    if (self.cameraType == AVCaptureDevicePositionBack)
    {
        self.northView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, borderWidth, northHeight)];
        self.northView.backgroundColor = [UIColor lightGrayColor];
        self.northView.alpha = 0.4;
        [self.view addSubview:self.northView];
        
        self.sourthView = [[UIView alloc] initWithFrame:CGRectMake(sourthOriX, sourthOriY, sourthWidth, sourthHeight)];
        self.sourthView.backgroundColor = [UIColor lightGrayColor];
        self.sourthView.alpha = 0.4;
        [self.view addSubview:self.sourthView];
        
        self.eastView = [[UIView alloc] initWithFrame:CGRectMake(eastOriX, eastOriY, eastWidth, eastHeight)];
        self.eastView.backgroundColor = [UIColor lightGrayColor];
        self.eastView.alpha = 0.4;
        [self.view addSubview:self.eastView];
        
        self.westView = [[UIView alloc] initWithFrame:CGRectMake(westOriX, westOriY, westWidth, westHeight)];
        self.westView.backgroundColor = [UIColor lightGrayColor];
        self.westView.alpha = 0.4;
        [self.view addSubview:self.westView];
        
        UIImage *borderImage = [UIImage imageNamed:QRBorderImageName];
        UIImage *lineImage = [UIImage imageNamed:QRLineImageName];
        self.centerView = [[UIImageView alloc] initWithFrame:CGRectMake(eastOriX + eastWidth, eastOriY, centerWidth, centerHeight)];
        self.centerView.contentMode = UIViewContentModeScaleAspectFit;
        self.centerView.image = borderImage;
        //    self.centerView.alpha = 0;
        [self.view addSubview:self.centerView];
        
        self.line = [[UIImageView alloc] initWithFrame:CGRectMake(eastOriX + eastWidth, eastOriY, centerWidth, 2)];
        self.line.contentMode = UIViewContentModeScaleAspectFill;
        self.line.image = lineImage;
        [self.view addSubview:self.line];
        
        self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, centerWidth, 22)];
        self.messageLabel.text = QRMessageText;
        self.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.messageLabel.numberOfLines = 1;
        self.messageLabel.font = [UIFont systemFontOfSize:17.0];
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        self.messageLabel.center = CGPointMake(borderWidth/2, sourthOriX + 10);
        [self.view addSubview:self.messageLabel];
        
    }else if(self.cameraType == AVCaptureDevicePositionFront)
    {
        //前置摄像头
        if (self.isStore) {
            //商店模式下
            self.northView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, borderWidth, northHeight)];
            self.northView.backgroundColor = [UIColor lightGrayColor];
            self.northView.alpha = 0.4;
            [self.view addSubview:self.northView];
            
            self.sourthView = [[UIView alloc] initWithFrame:CGRectMake(sourthOriX, sourthOriY, sourthWidth , sourthHeight)];
            self.sourthView.backgroundColor = [UIColor lightGrayColor];
            self.sourthView.alpha = 0.4;
            [self.view addSubview:self.sourthView];
            
            self.eastView = [[UIView alloc] initWithFrame:CGRectMake(eastOriX, eastOriY, eastWidth, eastHeight)];
            self.eastView.backgroundColor = [UIColor lightGrayColor];
            self.eastView.alpha = 0.4;
            [self.view addSubview:self.eastView];
            
            self.westView = [[UIView alloc] initWithFrame:CGRectMake(westOriX, westOriY, westWidth, westHeight)];
            self.westView.backgroundColor = [UIColor lightGrayColor];
            self.westView.alpha = 0.4;
            [self.view addSubview:self.westView];
            
            
            NSAssert(self.infoDict!= nil, @"QRSearchViewController:Info Dictionary shouldn't be nil.");
            NSString *infoStr = [self.infoDict objectForKey:QRDicInfoKey];
            NSAssert(infoStr, @"QRSearchViewController:Info Dictionary should contain a NSString value with QRDicInfoKey key be nil.");
            self.qrcodeView = [[UIImageView alloc] initWithFrame:CGRectMake(eastOriX + eastWidth, eastOriY, centerWidth, centerHeight)];
            self.qrcodeView.contentMode = UIViewContentModeScaleAspectFit;
            self.qrcodeView.image = [QRUtil generateUsingString:infoStr];
            [self.view addSubview:self.qrcodeView];
            
            
            
        }else {
            //用户模式下，二维码在上方，扫描框在下方
            self.northView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, borderWidth, northHeight)];
            self.northView.backgroundColor = [UIColor lightGrayColor];
            self.northView.alpha = 0.4;
            [self.view addSubview:self.northView];
            
            self.sourthView = [[UIView alloc] initWithFrame:CGRectMake(sourthOriX, sourthOriY, sourthWidth , sourthHeight)];
            self.sourthView.backgroundColor = [UIColor lightGrayColor];
            self.sourthView.alpha = 0.4;
            [self.view addSubview:self.sourthView];
            
            self.eastView = [[UIView alloc] initWithFrame:CGRectMake(eastOriX, eastOriY, eastWidth, eastHeight)];
            self.eastView.backgroundColor = [UIColor lightGrayColor];
            self.eastView.alpha = 0.4;
            [self.view addSubview:self.eastView];
            
            self.westView = [[UIView alloc] initWithFrame:CGRectMake(westOriX, westOriY, westWidth, westHeight)];
            self.westView.backgroundColor = [UIColor lightGrayColor];
            self.westView.alpha = 0.4;
            [self.view addSubview:self.westView];
            
            UIImage *borderImage = [UIImage imageNamed:QRBorderImageName];
            UIImage *lineImage = [UIImage imageNamed:QRLineImageName];
            self.centerView = [[UIImageView alloc] initWithFrame:CGRectMake(eastOriX + eastWidth, eastOriY, centerWidth, centerHeight)];
            self.centerView.contentMode = UIViewContentModeScaleAspectFit;
            self.centerView.image = borderImage;
            //    self.centerView.alpha = 0;
            [self.view addSubview:self.centerView];
            
            self.line = [[UIImageView alloc] initWithFrame:CGRectMake(eastOriX + eastWidth, eastOriY, centerWidth, 2)];
            self.line.contentMode = UIViewContentModeScaleAspectFill;
            self.line.image = lineImage;
            [self.view addSubview:self.line];
            
            self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, centerWidth, 22)];
            self.messageLabel.text = QRMessageText;
            self.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
            self.messageLabel.numberOfLines = 1;
            self.messageLabel.font = [UIFont systemFontOfSize:17.0];
            self.messageLabel.textAlignment = NSTextAlignmentCenter;
            self.messageLabel.center = CGPointMake(borderWidth/2, sourthOriX + 10);
            [self.view addSubview:self.messageLabel];
        }
        
    }
}

/**
 *  @abstract 重新生成二维码
 *
 */
- (void) resetQrCodeImage
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *sdate = [dateFormat stringFromDate:[NSDate date]];
    
    NSString *str = [NSString stringWithFormat:@"%@_%@", [self.infoDict objectForKey:QRDicInfoKey], sdate];
    self.qrcodeView.image = [QRUtil generateUsingString:str];    
}




- (void) lineAnimanate
{
    float ff = self.isStore ? self.qrcodeView.frame.size.height/2 : self.centerView.frame.size.height /2;
    if (isDown) {
        num ++;
        CGRect frame = self.line.frame;
        frame.origin.y += 2;
        self.line.frame = frame;
        if (num >= ff) {
            isDown = NO;
        }
    }else {
        num --;
        CGRect frame = self.line.frame;
        frame.origin.y -= 2;
        self.line.frame = frame;
        if (! num > 0) {
            isDown = YES;
        }
    }
    
}

#pragma mark
#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void) captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSString *strValue = nil;
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *metaDataObject = [metadataObjects objectAtIndex:0];
        strValue = metaDataObject.stringValue;
    }
    if (self.isStore) {
        [self dismissViewControllerAnimated:YES completion:^{
            if ([self.delegate respondsToSelector:@selector(qrCodeViewController:didFinishedStoreWithString:)]) {
                [self.delegate qrCodeViewController:self didFinishedStoreWithString:strValue];
            }
        }];
    }else {
        [self dismissViewControllerAnimated:YES completion:^{
            if ([self.delegate respondsToSelector:@selector(qrCodeViewController:didFinishedCustomWithString:)]) {
                [self.delegate qrCodeViewController:self didFinishedCustomWithString:strValue];
            }
        }];
    }
}

#pragma mark - Property Methods

- (UIBarButtonItem *)leftBarItem {
    if (!_leftBarItem) {
        _leftBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                                                     target:self
                                                                     action:@selector(backButtonClicked:)];
    }
    
    return _leftBarItem;
}

-(void)backButtonClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(qrCodeVideControllerCanceledSearch:)]) {
        [self.delegate qrCodeVideControllerCanceledSearch:self];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

//设置摄像头的orientation
- (void) setOrigation:(UIInterfaceOrientation) orientation for:(AVCaptureConnection *) conn
{
    switch (orientation) {
        case UIInterfaceOrientationLandscapeLeft:
        {
            [conn setVideoOrientation:AVCaptureVideoOrientationLandscapeLeft];
            break;
        }
        case UIInterfaceOrientationLandscapeRight:
        {
            [conn setVideoOrientation:AVCaptureVideoOrientationLandscapeRight];
            break;
        }
        case UIInterfaceOrientationPortrait:
        {
            [conn setVideoOrientation:AVCaptureVideoOrientationPortrait];
            break;
        }
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            [conn setVideoOrientation:AVCaptureVideoOrientationPortraitUpsideDown];
            break;
        }
        default:
            break;
    }
}

#pragma mark
#pragma mark - UIInterfaceOrigation

- (BOOL) shouldAutorotate{
    return NO;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self setOrigation:toInterfaceOrientation for:_preview.connection];
//    //竖屏状态下
//    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
//        _preview.frame = CGRectMake(0, 0, 768, 960);
//    }else {
//        _preview.frame = CGRectMake(0, 0, 1024, 768);
//    }
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
