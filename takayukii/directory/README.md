# `aws-cache`

- https://github.com/aws/aws-sdk-php/issues/660

- [https://github.com/aws/aws-sdk-php/blob/f2bed7e4079754f4cdf1feae01ca2d2945a04c61/docs/faq.rst#how-do-i-fix-an-error-related-to-aws-cache](https://github.com/aws/aws-sdk-php/blob/f2bed7e4079754f4cdf1feae01ca2d2945a04c61/docs/faq.rst#how-do-i-fix-an-error-related-to-aws-cache)

  > ## How do I fix an error related to "aws-cache"?
  > 
  > We received a few reports from users who run into an error like the following:
  > 
  > ``` 
  > ErrorException: {...}/vendor/aws/aws-sdk-php/src/JsonCompiler.php line 93
  > file_put_contents(/tmp/aws-cache/data_manifest.json.php): failed to open stream: Permission denied
  > ```
  > 
  > The SDK uses caching to improve the performance of loading the service descriptions. To aid in that process, it writes out data to a   directory called "aws-cache" within your system's tmp directory. If that is not accessible, then you will get an error like the one shown above.
  > 
  > There are two ways to avoid this problem.
  > 
  > 1. Change the permissions of the directory to allow your application to write the cache files.
  > 2. Configure the SDK to use a different directory by setting the `AWS_PHP_CACHE_DIR` environment variable.
