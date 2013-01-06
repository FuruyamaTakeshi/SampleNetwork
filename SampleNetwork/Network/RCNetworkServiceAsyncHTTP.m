//
//  RCNetworkServiceAsyncHTTP.m
//  SampleNetwork
//
//  Created by 古山 健司 on 12/12/29.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import "RCNetworkServiceAsyncHTTP.h"

@implementation RCNetworkServiceAsyncHTTP

- (void)dealloc
{
    [self.connection release];
    [super dealloc];
}
- (void)sendAsynchronousRequest:(NSData *)data withStringUrl:(NSString *)urlString
{
    LOG_METHOD;
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:10];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Context"];
    [request setValue:[NSString stringWithFormat:@"%d", [data length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:data];
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [request release];
    
}

#pragma mark -
#pragma mark delegate


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    LOG_METHOD;
    int statusCode = [((NSHTTPURLResponse*)response) statusCode];
    if (statusCode >= 400) {
        //
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    LOG_METHOD;
    
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    LOG_METHOD;
    [error domain];
    [error code];
    [error localizedDescription];
    
    if ([error code] == NSURLErrorNotConnectedToInternet) {
        return;
    }
    LOG(@"errorCode=%d", [error code]);
    if ([self.delegate respondsToSelector:@selector(didFailWithError:)]) {
        [self.delegate didFailWithError:error];
    }
}

- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    LOG_METHOD;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    LOG_METHOD;
    LOG(@"Succeeded! Received bytes of data");
    
}
@end

