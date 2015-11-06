# composer

###### Forked from: https://github.com/onema/opsworks-chef-cookbooks/

This coockbook contains recipes to run the install and update commands. 

### composer::install

This will download the latest version of composer from [https://getcomposer.org/installer](https://getcomposer.org/installer) 

to the current deployment directory and will run ```$ php composer.phar install --optimize-autoloader```.

### composer::update

Similar to install this recipe will download the latest version of composer from [https://getcomposer.org/installer](https://getcomposer.org/installer) 

to the current deployment directory and will run ```$ php composer.phar update```.