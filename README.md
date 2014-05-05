Shift Engage
========
Shift Engage is a toolkit for activists to organize, host events, communicate, and track interest.
We believe that paradigm changes will be driven by empowered, passionate individuals.
Our mission is to provide tools for these people to organize and mobilize.

Tech Stack
=========
Ruby on Rails 4
Heroku
Amazon S3


Deployment
=========
Asset precompilation is not configured in the deployment pipeline.
To deploy changes to assets, before deployment, run:

rake assets:clobber
rake assets:precompile RAILS_ENV="test"
