# Docker Images for Testing Puppet Modules

It's reasonable to assume that using the gems from puppet-module-gems the fast majority of modules would have the asme Gemfile. This in turn means every run of `bundle install` against that Gemfile is a waste, apart from the first onefor each Ruby/Puppet version combination. By creating an publishing Docker images we can make tests more portable, by sharing the whole execution environment, and remove the need for a local Ruby setup completely into the bargain.

This proof-of-concept provides two Dockerfiles, for Puppet 4.x and Puppet 5.x respectively. They use the relevant Ruby version from the AIO.


## Building the images

Let's build these images first. For this you will want to be in the `docker` directory where this README resides.

```
docker build -f Dockerfile-puppet-4 -t puppet/puppet-module:4 .
docker build -f Dockerfile-puppet-5 -t puppet/puppet-module:5 .
docker build -f Dockerfile-puppet-5 -t puppet/puppet-module:latest .
```


## Using the images

Now checkout your favourite module. Let's run the `validate` checks against the image build module under Puppet 4.

```
git clone https://github.com/puppetlabs/puppetlabs-image_build.git
cd puppetlabs-image_build
docker run -v `pwd`:/module -it puppet/puppet-module:4 validate
```

Or lets run the `specs` against apache on Windows under Puppet 5: 

```
git clone https://github.com/puppetlabs/puppetlabs-image_build.git
cd puppetlabs-image_build
docker run -v ${PWD}:/module -it garethr/puppet-module:5 spec
```

Note that:

* You don't need to install Ruby
* You don't need to interact with Ruby developer tools like bundler
* We ran tests against different Puppet versions and different Ruby versions


## Next steps

This is a proof-of-concept, it works nicely, but it would be possible to expand out from here to:

* Provide more Puppet/Ruby version images
* Provide alternative operating system images
* Build native Windows images
* Allow users to provide additional Gems to be installed
