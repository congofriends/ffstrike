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

## Tech hands-on for developers: ##
### I18n implementation: ###
As a developer on this project you need to be aware of a few things we've done for I18n:

:w
 1. Raise an exception on missing translations for test and development ENVs.
     Code for that is here: [config/initializers/i18n.rb](https://github.com/ThoughtWorksInc/ffstrike/blob/master/config/initializers/i18n.rb)
>    **NOTE:**
>     If you see the exception in one of these environments, it means that locale key usused in the view is missing and it is your responsobility to fix it in the locales files. Make sure to verify it for EN/ES/FR languages.

 2. Manage translations with a power of static analysis by using [I18n-tasks](https://github.com/glebm/i18n-tasks)
      * their github page is pretty explanatory. Please, refer to [usage section](https://github.com/glebm/i18n-tasks#usage)
      * configuration file is `config/i18n-tasks.yml`w
