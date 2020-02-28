# Setting Up Paired Development Environment

## Front-end Setup

Clone down the [front-end repo](https://github.com/DanielEFrampton/paired-fe):
```
git clone git@github.com:DanielEFrampton/paired-fe.git
```

Install or Update the Xcode application:
  - Open the Mac OSX App Store, search for Xcode, and install it, or update it if that option is shown. It is a > 9GB download so expect some time.
  - Once it's downloaded, open the Xcode app, agreed to the end-user license agreement, enter your password as prompted, and allow the components to download.
CD into the front-end directory.

Install NVM (Node Version Manager, like rbenv for Node):
  - From the command line, run `brew install nvm`.
  - Add the recommended setup code to your `.bash_profile` or `.zshrc` file in your root directory:
    ```
    export NVM_DIR="$HOME/.nvm"
      [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
      [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
    ```
  - After adding those lines to your Bash or ZSH profile, restart your Terminal (or other terminal app) so that the new lines take effect.

Install the most recent stable version of Node:
  - Visit [nodejs.org](http://nodejs.org) and look at the version shown on the "LTS" button to the left.
  - Install that version of Node.js by running `nvm install #.#.#` with the actual version numbers in place of `#`.

Run `npm install` to install the JavaScript libraries needed to run the front-end server, in both the front-end and back-end directories.

You will see lots of warnings, and can ignore them unless it ends with mentioning errors. If you encounter errors, please contact the Paired dev team and/or submit your problem as an Issue on the relevant repo.

**Before starting front-end:**
 - Open project in Atom
 - Open `src/utils/index.js` file
 - Change the `url` value on the second line from `https://paired-be.herokuapp.com/graphql` (the live, actual, functioning GraphQL endpoint which will change live data) to the following which will point to your locally-deployed back-end:
    ```
    http://localhost:3001/graphql
    ```

Run `npm start` to deploy the front-end server. Your browser should open automatically to `localhost:3000`. You will need to have the back-end running for the site to function; see below.

### Testing

To run the front-end test suite with Jest, run:
```
npm run test:dev
```
You may need to update the "snapshots" by pressing `u` at the menu that appears after the test suite has run.

When running the test suite, you may see a message that no files have been changed since the test was last run. You can press 'a' to bypass this message and run the test suite, and otherwise interact with the test application through the text menus by pressing the prompted keys.

## Back-end Setup

Clone down the [back-end repo](https://github.com/DanielEFrampton/paired-be):
```
git clone git@github.com:DanielEFrampton/paired-be.git
```

Change your working directory to the repo's root directory:
```
cd paired-be
```

(If you have not installed Ruby before, consider following [this tutorial](https://mod0.turing.io/setup-instructions) and then [this tutorial](https://github.com/turingschool-examples/backend_module_0_capstone/blob/master/README.md).)

Install Bundler if you have not before:
```
gem install bundler
```

Use it to install the project's gem dependencies:
```
bundle install
```

Set up the database:
```
rake db:{create,migrate,seed}
```

Run the Rails server with:
```
rails s
```

You may now run the front-end and open it on `localhost:3000` and it will make GraphQL queries to the Rails server at `localhost:3001/graphql`.

You can shut down the Rails server process by entering Cmd-C in the terminal window.

Run the test suite with:
```
bundle exec rspec
```

To access test coverage files, run:
```
open coverage/index.html
```

To access the GraphiQL graphic interface which allows for live GraphQL queries against the server, navigate to:
```
http://localhost:3001/graphiql
```

## Notifications Setup

Email and text notifications are executed using Sidekiq background workers. In order to test these features on your local server, you will need to install Sidekiq and Redis.

### Set up Redis and Sidekiq
1. Run `bundle` in the command line to install the `sidekiq` gem and the other dependencies.
2. Sidekiq relies on Redis to execute jobs. Install Redis via the command line using [Homebrew](https://brew.sh/):
```
brew install redis
```

### Execute on local server
Open up three terminals and type the following commands into separate Terminal windows or tabs:

- Terminal 1: `redis-server` to start up redis
- Terminal 2: `bundle exec sidekiq` to start up sidekiq
- Terminal 3: `rails s` to start up local server


### Manually test using Rails console

To start up the Rails console, open another terminal and enter `rails c`.

The notifications worker takes two arguments: “contact info” and “message”. The contact info argument should be a hash containing a phone number and email address. The message should be whatever message you would like to send. If you do not include a phone number, the worker will default to sending an email. Here’s an example:

```ruby
NotificationsWorker.perform_later({phone_number: ‘3035555555’, email_address: ‘test@email.com’}, ‘This is a message’)
```

### Monitor activity

In the routes file, there should be a route pointing to ‘/sidekiq’. If you visit “localhost:3001/sidekiq”, you will see a dashboard containing information on the number of successful jobs, number of failed jobs, and which jobs are still in queue. The server will automatically refresh this page every 5 seconds until you close out of it.

### Further reading

https://itnext.io/sidekiq-overview-and-how-to-deploy-it-to-heroku-b8811fea9347
https://backend.turing.io/module3/lessons/intro_to_background_workers

## SMS Service Setup

By default, the back-end Rails service is set up to communicate with the deployed SMS micro-service. If you wish to deploy it locally in conjunction with the front-end and back-end repos, see the installation instructions on [the SMS service repo](https://github.com/msimon42/paired-sms).
