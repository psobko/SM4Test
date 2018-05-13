#import "NSData+SM4.h"
#import "sm4.h"

@implementation NSData (SM4)

- (NSData *)SM4EncryptWithKey:(NSData *)key;
{
    SM4_KEY keyPtr;
    void *block = malloc(SM4_BLOCK_SIZE);
    
    SM4_set_key(key.bytes, &keyPtr);
    

    memcpy(block, self.bytes, SM4_BLOCK_SIZE);
    
    SM4_encrypt(block, block, &keyPtr);
    NSData *result = [NSData dataWithBytes:block length:SM4_BLOCK_SIZE];
    free(block);
    
    return result;
}

- (NSData *)SM4DecryptWithKey:(NSData *)key
{
    SM4_KEY keyPtr;
    void *block = malloc(SM4_BLOCK_SIZE);

    SM4_set_key(key.bytes, &keyPtr);
    memcpy(block, self.bytes, SM4_BLOCK_SIZE);
    
    SM4_decrypt(block, block, &keyPtr);
    NSData *result = [NSData dataWithBytes:block length:SM4_BLOCK_SIZE];
      free(block);
    return result;
}

@end
