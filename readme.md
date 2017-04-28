# Obsidian Disc: An Offline Adventure Tracking Set, 1st Edition
This project runs on a Realm database and utilizes custom cells, state-dependent rendering of view controllers, and other very fancy things. A quick breakdown of the features: 
1. Adventure Log
  * This is where a game master views and stores his or her notes on the campaign's progress.  To view an existing log, simply tap the cell. To create a new one altogether, click the `+` sign in the upper-right hand corner.
2. Project Self
  * This is where the social aspect of Obsidian Disc becomes important. In this part of the UI, you're able to add database-specific contacts, send them secrets (via SMS (unavailable in Simulator)), or create an iCloud-synced calendar event to remind you of your next meet-up.
### ======================
## Known Issues
* I'm currently aware of a problem when starting with a fresh Realm database wherein no data will actually be saved to the server. To rectify this, simply add one LogList and one ContactList via the Realm Browser, then reload the app. 
## Special Thanks
* Thank you to [Andrew Bancroft](https://www.andrewcbancroft.com/2016/06/02/creating-calendar-events-with-event-kit-and-swift/) for his wonderful tutorials on EKEventStore. 

* Another huge thanks to the Apple and Realm teams for keeping such clean, easy-to-read documentation. 

* [Soggy Bag](https://gist.github.com/soggybag/1c863ab275e1c0e09936/revisions) is another GitHub user that hosts a great gist of sending an SMS through MessageUI.
