#import <Foundation/Foundation.h>

@interface NSData (SM4)

- (NSData *)SM4EncryptWithKey:(NSData *)key;
- (NSData *)SM4DecryptWithKey:(NSData *)key;

@end
