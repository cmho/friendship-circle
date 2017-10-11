# Friendship Circle: A Webring Engine

**Friendship Circle** is a Ruby on Rails application to power a site similar to the webrings of yore. A webring is a link list that users can submit their own site to, in exchange for linking to the previous and next sites and the ring itself on their own website.

## What can Friendship Circle do?

### Ownership Verification

As part of its base functionality, Friendship Circle can check submitted websites for ownership verification—essentially, to verify that the user has the correct credentials to be able to insert a meta tag into the header, so that someone can't claim a website that isn't their own.

### Check whether the link codes are present

It's not very sporting if you join a links list but don't link back yourself; Friendship Circle will automatically display sites with broken or nonexistent links to the administrator and flag them for review.

## What isn't Friendship Circle meant for?

### Linking to social media pages

Friendship Circle is intended for links to self-hosted websites. Because it depends on scraping meta tags for site ownership verification, and because users need to be able to insert the webring links somewhere on the base page, it's not appropriate for linking pages such as social media sites or blogs where the user doesn't control the code.

### Making a general links list

It also isn't suitable for a general links list, as it's limited to one site per user.

## How do I install it?

If you don't have your own Ruby hosting, you can still install Friendship Circle on a remote server!

### Set up a Heroku account

### Clone the repository

### Update config variables

### Push to Heroku

### Log in as seeded administrator account

### Set up application settings

### Reveal to the public!
