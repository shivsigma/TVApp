//
//  Request.m
//  Vinly
//
//  Created by HARDIK TALAVIYA on 2/2/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "Request.h"
#import "AccountManager.h"


#define TIMEOUT_INTERVAL       40.0

@implementation Request

@synthesize delegate = _delegate;
@synthesize message = _message;
@synthesize methodType = _methodType;
@synthesize responseData = _responseData;
@synthesize IsSuccess = _isSuccess;
@synthesize StatusCode = _statusCode;
@synthesize Tag = _Tag;
@synthesize postData = _postData;
@synthesize errorCode = _errorCode;


- (id) initWithUrlPart:(NSString *)urlPart andDelegate:(id<RequestDelegate>)del andMethod:(RequestMethod)method {
    self = [super init];
    if (self)
    {
        _urlString = [NSString stringWithFormat:@"%@%@",BASE_URL,urlPart];
        _delegate = del;
        _methodType = method;
        _postParameters = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)setParameter:(id)parameter forKey:(NSString *)key
{
    [_postParameters setObject:parameter forKey:key];
}

- (void)startRequest {
    
    [_request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    
    NSString *passingData = @"";
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if (_postParameters && _postParameters.count > 0)
    {
        for (NSString *key in [_postParameters allKeys]) {
            NSString *temp = [NSString stringWithFormat:@"%@=%@", key, [_postParameters objectForKey:key]];
            [arr addObject:temp];
        }
        passingData = [arr joinWithDelimeter:@"&"];
    }
    
    
    if (_methodType == GET) {
        
        if (passingData.length > 0) {
            _urlString = [NSString stringWithFormat:@"%@&%@", _urlString, passingData];
        }
        
        
        NSURL *url = [NSURL URLWithString:_urlString];
        
        _request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:TIMEOUT_INTERVAL];
        [_request setHTTPMethod:@"GET"];
        [_request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
    } else if(_methodType == POST){
        NSURL *url = [NSURL URLWithString:_urlString];
        _request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:TIMEOUT_INTERVAL];
        [_request setHTTPMethod:@"POST"];
        [_request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        if (passingData.length > 0) {
            [_request setHTTPBody: [passingData dataUsingEncoding:NSUTF8StringEncoding]];
        }

        
        if (_image) {
            // set Content-Type in HTTP header
            NSString * BoundaryConstant =@"---------------HARDIK";
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
            [_request setValue:contentType forHTTPHeaderField: @"Content-Type"];
            
            // post body
            NSMutableData *body = [NSMutableData data];
            
            // add params (all params are strings)
            for (NSString *param in _postParameters) {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_postParameters objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
            // add image data
            NSData *imageData = UIImagePNGRepresentation(_image);
            if (imageData) {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
                NSString * FileParamConstant =@"profile_pic";
                if ([self.Tag  isEqual: SEND_MESSAGE_IMAGE]) {
                    FileParamConstant = @"img";
                }
                
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.png\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:imageData];
                [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
            [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
            
            // setting the body of the post to the reqeust
            [_request setHTTPBody:body];
            
            // set the content-length
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
            [_request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        }
        
       
        
        // set URL
        
        
        
     
        
        
//        if (_image) {
//            
//            NSData *imageData = UIImagePNGRepresentation(_image);
//            
//            NSMutableData *body = [NSMutableData data];
//            NSString *boundary = @"---------------------------14737809831466499882746641449";
//            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"profile_pic\"; filename=\"test.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//            [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//            [body appendData:[NSData dataWithData:imageData]];
//            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//            [_request setHTTPBody:body];
//        }
        
    }
    
    _connections = [[NSURLConnection alloc] initWithRequest:_request delegate:self startImmediately:TRUE];
}

-(void)requestSucceeded
{
    [_delegate requestDidSucceed:self];
    
}

-(void)requestFailed:(NSError*) error
{
    [_delegate requestDidFail:self withError:error];
    
}

#pragma NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _data = [[NSMutableData alloc] init];
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    self.StatusCode = (int)[httpResponse statusCode];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    error = [NSError errorWithDomain:@"Server Connection" code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Could not connect to server, please check your internet connectivity.", @"message", nil]];
    [self performSelectorOnMainThread:@selector(requestFailed:) withObject:error waitUntilDone:FALSE];
    
    _data = nil;
    
    _connections = nil;
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    SBJSON *jsonParser = [[SBJSON alloc] init];
    NSString *stringValue = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
    //stringValue =@"Unespectation Code";
    NSError *error = nil;
    id serverData = nil;
    @try
    {
        serverData = [jsonParser objectWithString:stringValue error:&error];
        
        if (![serverData isKindOfClass:[NSDictionary class]] && ![serverData isKindOfClass:[NSArray class]])
        {
            error = [NSError errorWithDomain:@"JsonParseError" code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Invalid server data format", @"message", nil]];
            serverData = nil;
            self.IsSuccess = NO;
        }
    }
    @catch (NSException *exception)
    {
        error = [NSError errorWithDomain:@"JsonParseError" code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Error proccessing server data", @"message", nil]];
    }
    if (serverData) {
        _responseData = serverData;
        if(_responseData != nil){
            if ([_responseData objectForKey:@"success"]) {
                self.IsSuccess = [[_responseData objectForKey:@"success"] boolValue];
            }
            if ([_responseData objectForKey:@"message"]) {
                _message = [_responseData objectForKey:@"message"];
            }
        }
    }
    
    if (self.IsSuccess)
    {
        [self performSelectorOnMainThread:@selector(requestSucceeded) withObject:nil waitUntilDone:FALSE];
    }else{
        error = [NSError errorWithDomain:@"RequestError" code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:_message, @"message", nil]];
        [self performSelectorOnMainThread:@selector(requestFailed:) withObject:error waitUntilDone:FALSE];
    }
    
    _data = nil;
    
    
    
}
@end
