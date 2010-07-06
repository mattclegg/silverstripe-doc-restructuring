## Introduction
This class lets you export a static copy of your site as a tar.gz archive.

See [StaticPublisher](StaticPublisher) for a more versatile solution for deploying static content (incl. publishing to multiple content servers).
## Requirements
*  Unix-Environment (does not work on Windows)

## Usage
Usage through URL:
~~~
http://localhost/StaticExporter/export
~~~

Usage on commandline (through [sake](sake)) is not possible at the moment, as we're sending a file to the browser for download.

Specify a custom baseurl in case you want to deploy the static HTML pages on a different host:
~~~
http://localhost/StaticExporter/export?baseurl=http://example.com
~~~

## API Documentation
[Click here for the API documentation](http://api.silverstripe.org/trunk/sapphire/StaticExporter.html).

## Related
*  [StaticPublisher](StaticPublisher)
