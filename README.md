# SM4 Encryption Test

SM4 is a Chinese symmetric encryption algothithm which was declassified by OSCCA in 2006. It's a enctral component of the WAPI stanrdard (WLAN Authentication and Privacy Infrastructure) and almost became a global standard but was beaten by 802.11i. Despite this it's still a government enforced standard and SMS4 is widely used across China for packet encryption across wireless networks.

SM4 is a 128-bit block cipher which uses a 128-bit key, 32 rounds, and a chaotic map. It's been compared to AES-128 and similarly SM4 possesses resilient properties against various methods of cryptanalysis such as differential attacks, etc. What sparked my interest in this algorithm was it's low-power design and that it's apparent resilience against certain attacks where the AES algorithm would falter.

As the original specifications were only available in Chinese, there's been some confusion over the name. Up until it's standardization in 2012, SM4 was known as SMS4 - though it has no connection to the SMS we know from text messaging. SM is simply the abbreviation of the Chinese word for "commercial cipher" (商密).

Curious about it's performance I put together this sample project which implements both algorithms and runs a series of unit and performance tests.  Originally I was planning on using Swift for this, however working with C APIs in Swift is still rather cumbersome. And while using Objective C to create wrapper functions for Swift could have worked, it didn't seem like it was worth the trouble.

I will be reporting my findings soon.
