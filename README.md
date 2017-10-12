# Opus
## Installation

You can install this program in its current form by cloning it by entering ```git clone git@github.com:jmstrick93/opus.git``` into the console.  

## Usage

1) After cloning the repo, navigate to the repo directory and run ```bundle install```.

2) Then, run ```shotgun``` in your terminal.

3) Open your preferred browser and navigate to ```localhost:9393/```, or whatever address at which shotgun indicates the app is running (you can find this in the shotgun terminal window-- e.g. ``` Shotgun/Thin on http://127.0.0.1:9393/```)

4) Click "New User" to create an account and get started.

## Development

After forking and cloning the repo, run ```bundle install``` Then, run rake ```db:migrate SINATRA_ENV=test``` to create a database test environment and run ```rspec``` to run the tests.   You can also run ```tux``` for an interactive prompt that will allow you to experiment.

You may create new database migration files by running ```rake db:create_migration NAME=<migration name here>```, filling out the new migration file, and then running ```rake db:migrate``` to run the migrations.  You can see a complete list of Rake commands by executing ```rake -T``` in the terminal.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jmstrick93/opus.

Contributions adding additional functionality are encouraged.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
