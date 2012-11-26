Prelude
=======
Boilerplate Rails app with Bootstrap, user accounts, pages, and more

Description
-----------

Created to speed up initial release time, Prelude is a boilerplate Rails 3.2 app that includes the basics for your standard web app:

* [Bootstrap](https://github.com/seyhunak/twitter-bootstrap-rails)
* User accounts via [Devise](https://github.com/plataformatec/devise), including:
  * Avatars via [Paperclip](https://github.com/thoughtbot/paperclip)
  * Profile pages
  * Pretty CoffeeScript sign in and sign up modal
  * Username-based authentication
* S3 as Paperclip's default storage adapter
* Backbone.js
* Static pages (e.g. "About", "Terms") that are manageable by admins and written in Markdown
* Site settings (e.g. site name, etc) via [Settingslogic](https://github.com/binarylogic/settingslogic)
* Helpers for caching content for unauthenticated users and for easily setting `<title>` in each view
* Pretty 404 and 500 pages in production
* Admin interface via [Active Admin](http://activeadmin.info/)