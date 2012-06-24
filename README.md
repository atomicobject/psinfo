Welcome to the `psinfo` git repository used in Atomic's hands-on embedded TDD workshop.

## How to use this project ##

### Examples from the presentation ###

Out of the box the project is setup to run the examples from the presentation (like the DataLoader example). `rake` will compile the code and run the tests.

### Building the client ###

* Create a new git branch for the client: `git checkout -b client`
* Blast the example test files from the `test` directory
* Blast the example source files from the `source` directory
* Start building your client! Check in regularly with `git add` and `git commit`

### Building the server ###

We build the server in a similar fashion: create a git branch for it, wipe out old files, and start building. It may be helpful to start from the client branch if you want to reuse some of the code (like arguments parsing).

### The protocol ###

The client-server protocol is documented in the `doc/psinfo_protocol.pdf` file.

## Cucumber features ##

Cucumber features exist for both the client and server. Run them with `rake cuke:client` and `rake cuke:server`, respectively.

Run the Cucumber features regularly to track your progress. Once they're all passing, you're done!

### The command line protocol ###

The way in which the Cucumber test harness will run your `client` and `server` commands is documented in the `doc/psinfo_protocol.pdf` file.

### The Ruby cheater scripts ##

If you run Rake's `cuke:client` or `cuke:server` commands with the `CHEAT` environment variable set, then the test harness will run the Ruby scripts in `cheater` against the test suite. This can be a nice sanity check to ensure the test harness is working as expected.

Example: `cheat=yes rake cuke:server`

## Git usage ##

The document `doc/git_usage.pdf` contains some basic `git` usage commands - `add`, `commit`, etc.

Excellent git resources:

* [learn.github](http://learn.github.com/p/intro.html)
* [Git Reference](http://gitref.org)

## Git tags ##

Git tags have been used to mark the repository after a workshop concludes - i.e. the march-2011 tag refers to the code used in the March 2011 workshop.
