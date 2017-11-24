# info201-finalproject
In this project, we will use a dataset which has data for all competitive League of Legends games from 2015 go 2017. We plan to find different trends,
and also compare how different pro-players have performed at the big stage. The final trends/analytics will be displayed on a web page using Shiny Apps.

## Remove this later:

So, I have created a basic template on how the tabs in our page will look.
Instead of writing all our code in a single server.R and ui.R file, it will be much easier if we keep all data-wrangling and calculations
for **each tab** in a different R file, and then refer to it in our server and ui files.

Also, creating separate branches here will be really helpful- if one of us uploads a code which is broken, it would not affect the other person's progress. I've already created one feature/layout branch, which has the server and ui file. Keep the naming convention like `feature/<tab name>` so that all the branches are grouped together in git (looks cleaner :p)

Dividing work:
Each one of us should work on **atleast** one tab, therefore must create one R file which deals with one of the issues. I (Aman) will take care of the main logic files (ui.R and server.R), so don't worry about that.

If your R files require to access some other tab's data, you'll need to pull from the master branch (granted that the person working on the other tab has merged his branch. There might be some other way to do this as well). In general, to keep things simpler, avoid using data from other R files. But make sure you don't make the code redundant just to avoid it.
