## v0.6.2.4 2016-09-12 13:48:00+0300

* Add typescript template generator (not defaulted). Thanks to @mjfaga

## v0.6.2.3 2016-07-27 17:25:00+0300

* Fixed incorrect value of register_mime_type (@mihai-dinculescu)

## v0.6.2.1 2016-07-26 18:27:00+0300

* Added Sprockets 4 support. Thanks to @mihai-dinculescu

## v0.6.2 2015-07-27 21:52:50+0300

* Updated to TS v1.6.2

## v0.6.1 2015-07-27 21:52:50+0300

* Now code raises exception with correct file name when TS compilation error occurs

## v0.6.0 2015-07-06 22:36:25+0300

* Updated version to 0.6.0 for using Typescript source 1.4.1.3

## v0.5.0 2015-03-25 10:46:29+0900

* Expire root TS cache in response to change in referenced `.ts` files (#24)

## v0.4.2 2014-11-26 07:30:12+0900

* Fix newlines (#15)
* Mention to `default_options` in README (#18)

## v0.4.1 2014-08-12 00:05:17+0900

* Fix a runtime error

## v0.4.0 2014-08-11 23:04:20+0900

* Set `--noImplicitAny` by default to tsc compiler
* Typescript::Rails::Compiler.default_options to provide tsc compiler with otpions
    * default values: `--target ES5 --noImplicitAny`
* A lot of refactoring

## v0.3.0 2014-08-09 10:27:54+0900

* Compiles TypeScript files in ES5 mode

