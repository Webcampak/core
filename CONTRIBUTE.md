# Contribute / Dev

## Dev Mode

A development mode is available for Webcampak, it is loading an uncompiled version of the UI at every page load.

It is reachable at the following location: https://localhost/app_dev.php/desktop

You can simply modify the codebase and reload the page after your changes.

### Restricted Access

By default, the development mode is only reachable from the same host than the one running webcampak. 

If you want to access the development mode from another host, you can simply comment this part fo the codebase:

```php
// File: apps/api/Symfony/3.0/web
if (isset($_SERVER['HTTP_CLIENT_IP'])
    || isset($_SERVER['HTTP_X_FORWARDED_FOR'])
    || !(in_array(@$_SERVER['REMOTE_ADDR'], ['127.0.0.1', 'fe80::1', '::1']) || php_sapi_name() === 'cli-server')
) {
    header('HTTP/1.0 403 Forbidden');
    exit('You are not allowed to access this file. Check '.basename(__FILE__).' for more information.');
}
```


## Compile your changes

You will need to use Sencha CMD to compile your modified codebase and make it available in the production mode.

You can download Sencha CMD from here: http://cdn.sencha.com/cmd/6.2.1.29/release-notes.html

If you used the zip and once you have openjdk installed on your system, simply run the following commands

```bash
cd ~/webcampak/apps/ui/Sencha/App6.0/workspace/Desktop
~/softs/sencha app build
```

Don't forget that you might need to clear your browser's cache (or Symfony cache) to see the changes reflected in production

Synmfony browser cache is located here:  

```bash
~/webcampak/resources/cache/symfony/prod/
```