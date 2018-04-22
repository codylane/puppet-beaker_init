# beaker_init

## Overview

This puppet module is meant to help aid in puppet beaker testing.  It sets up
all the important things you need to get up and running with beaker on
your local workstaiton.  Please keep in mind that this may be
opinionated but I'm hoping this will help others.  If you find something
you would like to add, please do let me know or submit a pull request.

NOTE: This module could be destructive to your exiting beaker test
environemnts so I recommend running puppet in `noop` mode if you want to
update your existing project.

## What is puppetlabs beaker?
Please read through this documentation found here:
https://github.com/puppetlabs/beaker/tree/master/docs

It helps you test your puppet modules in a local environment before
rolling them into you production repositories.  It is not meant to
replace things like CI but help aid in your CI development cycle.

## Module Description

When I first started learning beaker I found that it required a lot of
setup that I didn't know about off hand. It took me a while to get all
the directory structure in place to to write a basic tests. I hope this module
will help remove some of those obstacles.

You could use this module in your puppet development workflow to
create a base skeleton or... You can use it to proactively adjust your
puppet development beaker projects. It's all up to you.

### Quick overview of features
* It will create a Gemfile in your project directory.
* It will create a Rakefile in your project directory.
* It will install some customized rake task helpers in your project
  direcory in the `tasks` directory.
* It will create your a spec directory in your project
  * It will create a `spec_helper`
  * It will create a `spec_helper_acceptance` for beaker testing
  * it will create a `acceptance` directory in your spec dir
    * It will create a `nodesets` directory and install your nodeset
      definitions that are defined in hiera.

## Setup
### Installing from git

```
cd /to/your/module/directory
git clone https://github.com/codylane/puppet-beaker_init.git beaker_init
```

### Installing from the forge?
This feature will not be enabled because this module may not provide a
whole lot of value now that PDK is out and probably should be used
instead.

### Setup Requirements

NOTE: Make sure that you have puppetlabs-stdlib installed in your
modules. If you are using the `bin/beaker_init` script it will handle
this for you.

It is expected that you run this using `puppet apply` but you may also
integrate this module in your puppet master.

If you want to use hiera please see the hiera example layout listed in
this repo.
  * see `hiera.yaml'
  * see `hieradata/beaker.yaml`

### Beginning with beaker_init

NOTE: This is just an example of how to use this project.

Copy a module to `/tmp/example_project`.

If you want to quickly test what this does you would cd to the location
where you installed this repo and run the following command:
```
bin/beaker_init
```

The command above will create a skeleton in `/tmp/exmaple_project` so you can
quickly start using beaker + puppet rspec... etc.

Now that you have a base skeleton beaker structure, you'll need to start
defining your beaker acceptance tests. Here is a pretty descent example
of what the layout of a complex beaker test suite would like like.
https://github.com/puppetlabs/puppetlabs-mysql/tree/master/spec

## Development

Fork this repo, make your changes, test them and submit a pull request.
I'll be happy to review and merge into this repo.

## Release Notes

`2015.4.0`
First release.  Handles vagrant and docker hypervisor environments used
with beaker.
