# Weather Application using Open Weather Map API

## How to Use

### This is an application that can be run locally by cloning the repo using the command in the terminal. `git clone https://wwww.github.com/lggg123/apple-weather-app.git`

### After you clone the repo cd into the repo apple-weather-app by typing this into the terminal. `cd apple-weather-app`

### In order to properly process the application you need the master.key (which you can obtain by either emailing [Contact Me for the master.key](mailto:machinelearner2334@gmail.com) or you can create your own credentials by creating an account on this website by clicking this link [Open Weather Map](https://home.openweathermap.org/users/sign_up). Once you create your account simply click on this link [My API Keys](https://home.openweathermap.org/api_keys) to access your API key which you will copy and can paste by creating your own credentials using the steps below:
### first you need to access your rails credentials by assigning an editor with rails credentials command by typing this into the terminal. `EDITOR="vim" rails credentials:edit`

### Once you are in underneath the # type this `open_weather_api_key: <APIKEY>` paste the <APIKEY> is the api key you copied from this link [My API Keys](https://home.openweathermap.org/api_keys)

### To exit simply type in the terminal control + c and :q to exit.

### Now you can run the server using `rails s`

### Once you checkout the browser simply type in your zip code and country code, for example 90011 and US which is US the country code for United States.
