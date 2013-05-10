//
//  DONViewController.m
//  Donateo
//
//  Created by Fady Kamal on 4/10/13.
//  Copyright (c) 2013 Orange. All rights reserved.
//

#import "DONViewController.h"
#import "XMLReader.h"

@interface DONViewController ()
@end
@implementation DONViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backroundClick:(id)sender {
    [_txtUsername resignFirstResponder];
    [_txtPassword resignFirstResponder];
}

- (NSString *)stringByDecodingURLFormat
{
    NSString *result = [(NSString *)self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}
// Don't forget to specify the parameters like user='' in the post data.
- (IBAction)loginClicked:(id)sender {
//    NSString *post =@"user=%3C%3Fxml%20version%3D%221.0%22%20encoding%3D%22UTF-8%22%3F%3E%0A%3Cuser%3E%0A%09%3CfirstName%3ESherineXML2%3C%2FfirstName%3E%0A%09%3ClastName%3ENagy%3C%2FlastName%3E%0A%09%3Cemail%3Eshe%40gmail.com%3C%2Femail%3E%0A%09%3Cpassword%3E1234567890%3C%2Fpassword%3E%0A%09%3Cphone%3E01234567890%3C%2Fphone%3E%0A%09%3Caddress%3Enasr%20city%3C%2Faddress%3E%0A%3C%2Fuser%3E";
    
    NSString *XMLRequest = [NSString stringWithFormat: @"user=<login><email>%@</email><password>%@</password></login>", _txtUsername.text,_txtPassword.text];
    //NSLog(@"XML Post: %@",XMLRequest);
    
    NSString *post = [XMLRequest stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    //NSLog(@"PostData: %@",post);
    
    NSURL *url=[NSURL URLWithString:@"http://localhost:8080/springmvc/xLogin"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //NSLog(@"Response code: %d", [response statusCode]);
//    if ([response statusCode] >=200 && [response statusCode] <300)
//    {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        //NSLog(@"Response Data: %@", responseData);
        NSString *decodedResponse = [responseData
                          stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //NSLog(@"Response Data Decoded: %@", decodedResponse);
        NSError *parseError = nil;
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:decodedResponse error:&parseError];
        //NSLog(@"Dictionary :%@",xmlDictionary);
        NSDictionary* resultDict1 = [[xmlDictionary allValues] objectAtIndex:0];
        NSDictionary* resultDict2 = [[resultDict1 allValues] objectAtIndex:1];
        //NSString *XMLmessage = [resultDict2 objectForKey:@"text"]; //Uncomment this later
//        NSLog(@"%@", XMLmessage);
        NSString *XMLmessage = @"SUCCESS"; //comment this later
        
        if ([XMLmessage isEqual: @"SUCCESS"]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            UICollectionViewController *vc = [sb instantiateViewControllerWithIdentifier:@"DONTabViewController"];
            vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:vc animated:YES completion:NULL];
        }
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                          message:XMLmessage
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        //[message show];
    //} //end of if responsecode segment
//    else {
//        
//    }
    
}

- (IBAction)registerClicked:(id)sender {
}
@end
