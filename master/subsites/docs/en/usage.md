# Usage

## Create a new subsite

Create a new subsite, giving it a name and a subdomain. The subdomain will determine the URL of your website. For example, if your site is running on http://localhost/mysite, and you set the subdomain to "subsite", then your subsite will be accessible on http://subsite.localhost/mysite  

Once you have created and saved your new subsite, go back to the Site Content section. In the top-right, there should be a dropdown listing the two subsites - "Main site" is the original site that you had before you installed the subsites module. Select your new subsite, and the site content tree will be updated. It should be empty at this stage.  

Add a page - change its title to "Home", and its URL Segment will be changed to "home". Save and publish this page.  

## Update your DNS

You will need to update the DNS settings so that it points to your SilverStripe installation on your webserver.

### localhost

* __windows__
>edit c:\windows\system\etc\hosts with your favourite text editor and add something like; '127.0.0.1 yoursubsite.example.com'

* __linux / apple__
>edit /etc/hosts with your favourite text editor and add something like; '127.0.0.1 yoursubsite.example.com'

### hosting

* __consult your webserver provider__

## Testing

Visit this new subdomain. You should see the new subsite homepage.
