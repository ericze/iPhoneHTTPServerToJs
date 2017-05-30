//
//  ViewController.m
//  iPhoneHTTPServerToJS
//
//  Created by wangZL on 2017/5/27.
//  Copyright © 2017年 EricZe. All rights reserved.
//

#import "ViewController.h"
#import <SSZipArchive.h>
#import <AFNetworking.h>



//http://octgh9scz.bkt.clouddn.com/index.zip?attname=&e=1495881439&token=LNefbQ5CufvndBztjWvk21WSnMYonbt9dtsORbSJ:-rQaaUQJ7lhoT9Wc_Zm80lNtr3s
@interface ViewController ()<SSZipArchiveDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.webView];
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask,YES);//使用C函数NSSearchPathForDirectoriesInDomains来获得沙盒中目录的全路径。
    NSString *ourDocumentPath =[documentPaths objectAtIndex:0];
    NSString *downloadStr = [self DownloadTextFile:@"http://octgh9scz.bkt.clouddn.com/index.zip?attname=&e=1495881439&token=LNefbQ5CufvndBztjWvk21WSnMYonbt9dtsORbSJ:-rQaaUQJ7lhoT9Wc_Zm80lNtr3s" fileName:@"index.zip"];
    [self OpenZip:downloadStr unzipto:[NSString stringWithFormat:@"%@/index.html",ourDocumentPath]];
   
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSString*)DownloadTextFile:(NSString*)fileUrl   fileName:(NSString*)_fileName
{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask,YES);//使用C函数NSSearchPathForDirectoriesInDomains来获得沙盒中目录的全路径。
    NSString *ourDocumentPath =[documentPaths objectAtIndex:0];
    NSString *FileName=[ourDocumentPath stringByAppendingPathComponent:_fileName];//fileName就是保存文件的文件名

    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:fileUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:_fileName];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
      //  NSLog(@"File downloaded to: %@", filePath);
        NSString *str = [NSString stringWithFormat:@"%@/index.html",ourDocumentPath];
        [self OpenZip:[NSString stringWithFormat:@"%@/index.zip",ourDocumentPath] unzipto:ourDocumentPath];
        NSString *html = [NSString stringWithContentsOfFile:str encoding:NSUTF8StringEncoding error:nil];
        
        [self.webView loadHTMLString:html baseURL:nil];
    }];
    [downloadTask resume];

    return FileName;
}

- (void)OpenZip:(NSString*)zipPath  unzipto:(NSString*)_unzipto
{
    [SSZipArchive unzipFileAtPath:zipPath toDestination:_unzipto delegate:self];
}

@end
